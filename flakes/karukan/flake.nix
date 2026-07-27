{
  description = "karukan - fcitx5 Neural Kana-Kanji Conversion IME, packaged for home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        version = "0.1.0-unstable-2026-07-20";

        src = pkgs.fetchFromGitHub {
          owner = "togatoga";
          repo = "karukan";
          rev = "main";
          # 1回目の `nix build` で実際のハッシュが提示されるので、それに置き換えてください。
          hash = "sha256-Hep7HUQW/gcqNi5oP3yEW+QBtiyDI9uTXnes4vi7M14=";
        };

        # --- Step 1: karukan-fcitx5 crate を cdylib (libkarukan_fcitx5.so) としてビルド ---
        # workspace全体をビルド対象に含めると llama-cpp-2 (C++コンパイル含む) も
        # 一緒にビルドされるため、cmake/clang を nativeBuildInputs に入れる。
        karukan-fcitx5-lib = pkgs.rustPlatform.buildRustPackage {
          pname = "karukan-fcitx5-lib";
          inherit version src;

          cargoLock = {
            lockFile = "${src}/Cargo.lock";
          };

          buildAndTestSubdir = ".";
          cargoBuildFlags = [ "-p" "karukan-fcitx5" ];
          cargoTestFlags = [ "-p" "karukan-fcitx5" ];

          nativeBuildInputs = with pkgs; [
            cmake
            pkg-config
            clang
            gcc
          ];

          buildInputs = with pkgs; [
            openssl
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.libclang
          ];

          # llama-cpp-sys-2 は CMake 経由で llama.cpp 本体をネイティブビルドする。
          # cargo のビルドスクリプト内で呼ばれる CMake が、Nix サンドボックスの
          # gcc/glibc を正しく拾えるよう CC/CXX を明示する。
          CC = "${pkgs.stdenv.cc}/bin/cc";
          CXX = "${pkgs.stdenv.cc}/bin/c++";

          # llama-cpp-2 の build.rs が bindgen / libclang を要求するため明示的に渡す。
          # bindgen が glibc の標準ヘッダ (stdio.h 等) を見失わないよう
          # stdenv の cc が使う標準インクルードパスを明示的に追加する。
          LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
          BINDGEN_EXTRA_CLANG_ARGS =
            "-isystem ${pkgs.stdenv.cc.libc.dev}/include "
            + "-isystem ${pkgs.stdenv.cc.cc.lib}/lib/clang/${pkgs.lib.versions.major pkgs.stdenv.cc.cc.version}/include";

          doCheck = false;

          # cdylib のため `cargo install` 相当のデフォルト installPhase は使えない。
          # ビルド成果物を直接 $out/lib にコピーする。
          installPhase = ''
            runHook preInstall
            mkdir -p $out/lib
            echo "=== searching for libkarukan_fcitx5.so ==="
            find . -iname 'libkarukan_fcitx5.so' -print
            echo "=== CARGO_TARGET_DIR is: ''${CARGO_TARGET_DIR:-unset} ==="
            so_path=$(find . -iname 'libkarukan_fcitx5.so' -print -quit)
            if [ -z "$so_path" ]; then
              echo "ERROR: libkarukan_fcitx5.so not found anywhere under $(pwd)"
              exit 1
            fi
            cp "$so_path" $out/lib/
            runHook postInstall
          '';

          # cargo install を呼ばないよう、checkPhase 同様 buildRustPackage の
          # 既定動作に依存しすぎないことを明示。binary が無いため `cargo install`
          # はエラーになるが、上の installPhase で上書きしているため問題ない。
        };

        # --- Step 2: C++ 側 (fcitx5-addon) を CMake でビルド ---
        # CMakeLists.txt はデフォルトで `cargo build` をカスタムターゲットとして
        # 走らせる構成になっているため、Nixのサンドボックス(ネットワーク遮断)と
        # 衝突する。事前ビルド済みの .so を直接使うようパッチする。
        karukan-fcitx5-addon = pkgs.stdenv.mkDerivation {
          pname = "karukan-fcitx5-addon";
          inherit version src;

          sourceRoot = "${src.name}/karukan-fcitx5/fcitx5-addon";

          nativeBuildInputs = with pkgs; [
            cmake
            pkg-config
            kdePackages.extra-cmake-modules
          ];

          buildInputs = with pkgs; [
            fcitx5
            libxkbcommon
          ];

          postPatch = ''
            # cargo を直接呼び出す custom_target を無効化し、
            # Step 1 で事前ビルドした .so のパスを直接指定する。
            substituteInPlace CMakeLists.txt \
              --replace-fail \
                'set(KARUKAN_RUST_LIB "''${CMAKE_CURRENT_SOURCE_DIR}/../../target/release/libkarukan_fcitx5.so")' \
                'set(KARUKAN_RUST_LIB "${karukan-fcitx5-lib}/lib/libkarukan_fcitx5.so")'

            substituteInPlace CMakeLists.txt \
              --replace-fail \
                'find_program(CARGO cargo REQUIRED)
add_custom_target(karukan_rust_lib ALL
    COMMAND ''${CARGO} build --release -p karukan-fcitx5
    WORKING_DIRECTORY "''${CMAKE_CURRENT_SOURCE_DIR}/../.."
    COMMENT "Building karukan-fcitx5 Rust library"
    BYPRODUCTS "''${KARUKAN_RUST_LIB}"
)' \
                '# cargo build skipped: using prebuilt ${karukan-fcitx5-lib}'

            substituteInPlace CMakeLists.txt \
              --replace-fail \
                'add_dependencies(karukan karukan_rust_lib)' \
                '# add_dependencies(karukan karukan_rust_lib) skipped'

            substituteInPlace CMakeLists.txt \
              --replace-fail \
                'BUILD_RPATH "''${CMAKE_CURRENT_SOURCE_DIR}/../../target/release"' \
                'BUILD_RPATH "${karukan-fcitx5-lib}/lib"'
          '';

          meta = with pkgs.lib; {
            description = "fcitx5 addon binary for karukan (Japanese neural kana-kanji IME)";
            homepage = "https://github.com/togatoga/karukan";
            license = with licenses; [ mit asl20 ];
            platforms = platforms.linux;
          };
        };
      in
      {
        packages = {
          default = karukan-fcitx5-addon;
          karukan-fcitx5-addon = karukan-fcitx5-addon;
          karukan-fcitx5-lib = karukan-fcitx5-lib;
        };

        # home-manager から:
        #   imports = [ inputs.karukan.homeManagerModules.default ];
        #   programs.karukan-fcitx5.enable = true;
        # として利用する。
        # 注意: fcitx5 本体の有効化・IM一覧への追加は home-manager 単体では
        # サポートが薄いため、NixOS側 (i18n.inputMethod) で行うか、
        # ~/.config/fcitx5/profile を home.file 等で別途管理してください。
        homeManagerModules.default = { config, lib, pkgs, ... }:
          let
            cfg = config.programs.karukan-fcitx5;
          in
          {
            options.programs.karukan-fcitx5 = {
              enable = lib.mkEnableOption "karukan fcitx5 IME addon";
            };

            config = lib.mkIf cfg.enable {
              home.packages = [ karukan-fcitx5-addon ];

              # fcitx5 がアドオンディレクトリとして $XDG_DATA_DIRS/fcitx5/addon を見るため、
              # home.sessionVariables で明示的に追加しておく。
              home.sessionVariables.XDG_DATA_DIRS =
                "${karukan-fcitx5-addon}/share\${XDG_DATA_DIRS:+:}$XDG_DATA_DIRS";
            };
          };
      });
}

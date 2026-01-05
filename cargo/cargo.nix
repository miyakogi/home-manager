{ ... }: {
  programs.cargo = {
    enable = true;
    settings = {
      cargo-new = {
        vcs = "none";
      };
      "target.x86_64-unknown-linux-gnu" = {
        linker = "clang";
        rustflags = [ "-C" "link-args=-fuse-ld=/usr/bin/modl" ];
      };
      term = {
        color = "auto";
      };
      net = {
        retry = 2;
      };
    };
  };
}

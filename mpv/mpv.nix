{ pkgs, ... }: {
  home.packages = [
    pkgs.vapoursynth
    pkgs.vapoursynth-mvtools
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      mpv-unwrapped = pkgs.mpv-unwrapped.override {
        vapoursynthSupport = true;
        vapoursynth = pkgs.vapoursynth.withPlugins (with pkgs; [
          vapoursynth-mvtools
        ]);
      };
    };
    config = {
      msg-level = "all=info";

      vo = "gpu-next";
      hwdec = "vulkan";
      deband = true;

      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      vulkan-queue-count = 1;
      vulkan-swap-mode = "mailbox";
      vd-lavc-dr = true;

      scale = "ewa_lanczossharp";
      dscale = "mitchell";
      tscale = "mitchell";

      vf = "vapoursynth=~~/interpolation.vpy:8:4";

      glsl-shaders = "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_VL.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_VL.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl";

      ao = "pipewire";

      hr-seek = "absolute";
      osc = false;
    };
  };

  home.file.".config/mpv/input.conf".source = ./input.conf;
  home.file.".config/mpv/interpolation.vpy".source = ./interpolation.vpy;
  home.file.".config/mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}

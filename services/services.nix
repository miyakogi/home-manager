{
  pkgs,
  ...
}:
{
  systemd.user.services.taskwarrior-notify = {
    Unit.Description = "Taskwarrior Due Task Notifier";
    Service = {
      Type = "oneshot";
      ExecStart = "%h/bin/tw-notify";
      Environment = [ "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.timers.taskwarrior-notify = {
    Unit.Description = "Taskwarrior Due Task Notifier";
    Timer = {
      OnCalendar = "*:0/10";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  systemd.user.services.taskwarrior-notify-daily = {
    Unit.Description = "Taskwarrior Daily Task Notifier";
    Service = {
      Type = "oneshot";
      ExecStart = "%h/bin/tw-notify-daily";
      Environment = [ "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.timers.taskwarrior-notify-daily = {
    Unit.Description = "Taskwarrior Daily Task Notifier";
    Timer = {
      OnCalendar = [
        "*-*-* 07:00:00"
        "*-*-* 19:00:00"
      ];
      OnBootSec = "2min";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  # Installed but intentionally not enabled (no `Install`), so it never
  # auto-starts; start it manually when needed.
  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama Service";
      Wants = [ "network-online.target" ];
      After = [
        "network.target"
        "network-online.target"
      ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.ollama-vulkan}/bin/ollama serve";
      Environment = [
        "OLLAMA_VULKAN=1"
        "OLLAMA_KEEP_ALIVE=-1"
        "OLLAMA_MAX_LOADED_MODELS=2"
        "OLLAMA_MAX_QUEUE=1"
        "OLLAMA_NUM_PARALLEL=1"
        "OLLAMA_CONTEXT_LENGTH=32768"
        "GGML_VK_CMD_THREADS=8"
        "GGML_VK_MEMORY_POOL_SIZE=8192"
      ];
      Restart = "on-failure";
      RestartSec = 3;
      RestartPreventExitStatus = [ 1 ];
    };
  };
}

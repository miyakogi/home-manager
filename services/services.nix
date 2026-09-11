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
}

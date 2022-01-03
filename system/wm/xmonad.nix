{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  programs.gnupg.agent.pinentryFlavor = "gnome3";
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };

    xserver = {
      enable = true;

      displayManager.gdm.enable = true;
      layout = "us,se";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
        touchpad.tapping = true;
        touchpad.scrollMethod = "twofinger";

      };
      dpi = 180;

      #  serverLayoutSection = ''
      #    Option "StandbyTime" "0"
      #    Option "SuspendTime" "0"
      #    Option "OffTime"     "0"
      #  '';

      displayManager = { defaultSession = "none+xmonad"; };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      #      xkbOptions = "caps:ctrl_modifier";

    };
  };
  # For HDpi screen
  #hardware.video.hidpi.enable = true;
  # bigger tty fonts
  # console.font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}

{ config, lib, pkgs, ... }:

{
  programs.gnupg.agent.pinentryFlavor = "gnome3";

  # Enable the X11 windowing system.
  services = {
    # Gnome3 config
    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    # GUI interface
    xserver = {
      enable = true;
      layout = "us,se";

      # Enable touchpad support.
      libinput.enable = true;

      # Enable the Gnome3 desktop manager
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false; # screen-sharing is broken
      desktopManager.gnome.enable = true;
    };
  };
}

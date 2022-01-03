{ config, lib, pkgs, ... }:

{

  services.gpg-agent = {
    enable = true;
    grabKeyboardAndMouse = false;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    pinentryFlavor = "curses";

  };
}

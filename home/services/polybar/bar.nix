{ font0 ? 19, font1 ? 21, font2 ? 40, font3 ? 28, font4 ? 9 }:

let
  bar = ''
    [bar/main]
    monitor = ''${env:MONITOR:eDP-1}
    width = 100%
    height = 48
    radius = 6.0
    fixed-center = true

    background = ''${color.bg}
    foreground = ''${color.fg}

    padding-left = 0
    padding-right = 0

    module-margin-left = 1
    module-margin-right = 2

    tray-padding = 3
    tray-background = ''${color.bg}

    cursor-click = pointer
    cursor-scroll = ns-resize

    overline-size = 2
    overline-color = ''${color.ac}

    border-bottom-size = 0
    border-color = ''${color.ac}

    ; Text Fonts
    font-0 = Iosevka Nerd Font:style=Medium:size=${toString font0};3
    ; Icons Fonts
    font-1 = icomoon-feather:style=Medium:size=${toString font1};3
    ; Powerline Glyphs
    font-2 = Iosevka Nerd Font:style=Medium:size=${toString font2};3
    ; Larger font size for bar fill icons
    font-5 = Iosevka Nerd Font:style=Medium:size=${toString font3};3
    ; Smaller font size for shorter spaces
    ;font-4 = Iosevka Nerd Font:style=Medium:size=${toString font4};3

    ;font-3 = Font Awesome 5 Free:style=Solid:pixelsize=18;0
    font-3 = Material Design Icons:style=regular:size=18;0
  '';

  top = ''
    [bar/top]
    inherit = bar/main

    tray-position = center
    modules-left = right-end-top nixos xmonad left-end-bottom right-end-top left-end-top
    modules-right = left-end-top keyboard clickable-date temperature battery
    enable-ipc = true
  '';

  bottom = ''
    [bar/bottom]
    inherit = bar/main
    bottom = true

    tray-position = none
    modules-left = right-end-bottom left-end-top cpu memory filesystem
    modules-right = left-end-bottom network left-end-bottom powermenu
    enable-ipc = true
  '';
in bar + top + bottom

{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      background_opacity = 1.0;
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };

      # Base16 Monokai - alacritty color config
      # Wimer Hazenberg (http://www.monokai.nl)
      colors = {
        # Default colors
        primary = {
          background = "0x272822";
          foreground = "0xf8f8f2";
        };
        # Colors the cursor will use if `custom_cursor_colors` is true
        cursor = {
          text = "0x272822";
          cursor = "0xf8f8f2";
        };
        # Normal colors
        normal = {
          black = "0x272822";
          red = "0xf92672";
          green = "0xa6e22e";
          yellow = "0xf4bf75";
          blue = "0x66d9ef";
          magenta = "0xae81ff";
          cyan = "0xa1efe4";
          white = "0xf8f8f2";
        };
        # Bright colors
        bright = {
          black = "0x75715e";
          red = "0xfd971f";
          green = "0x383830";
          yellow = "0x49483e";
          blue = "0xa59f85";
          magenta = "0xf5f4f1";
          cyan = "0xcc6633";
          white = "0xf9f8f5";
        };
        draw_bold_text_with_bright_colors = false;

      };

      font = {
        normal = {
          family = "Iosevka";
          style = "Light";
        };
        bold = {
          family = "Iosevka";
          style = "Medium";
        };
        italic = {
          family = "Iosevka";
          style = "Light Italic";
        };

        size = 13;
      };
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}

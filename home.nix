{ config, pkgs, ... }:

let
  # AMOLED Lilac Color Scheme
  colors = {
    background = "#000000";
    foreground = "#E8D4F7";
    primary = "#D4BBFF";
    secondary = "#A78BFA";
    selection = "#3D2A54";
    cursor = "#D4BBFF";
    urgent = "#FF6B9D";
    
    # Terminal colors
    black = "#000000";
    red = "#FF6B9D";
    green = "#B8A4FF";
    yellow = "#DDB4FF";
    blue = "#A78BFA";
    magenta = "#D4BBFF";
    cyan = "#C7B8FF";
    white = "#E8D4F7";
    
    bright_black = "#2A1F3D";
    bright_red = "#FFB3D1";
    bright_green = "#D4BBFF";
    bright_yellow = "#F0D9FF";
    bright_blue = "#C9B8FF";
    bright_magenta = "#E8D4F7";
    bright_cyan = "#DDD4FF";
    bright_white = "#F5EDFF";
  };
in
{
  home.username = "nix";
  home.homeDirectory = "/home/nix";
  programs.git.enable = true;
  home.stateVersion = "25.11";

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
  
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "none";
        padding = {
          top = 2;
          left = 3;
          right = 0;
        };
        width = 15;
      };
      modules = [
        "break"
        {
          type = "custom";
          format = "──────────────────────Hardware──────────────────────";
        }

        {
          type = "cpu";
          showPeCoreCount = true;
          keyColor = "magenta";
        }
        {
          type = "gpu";
          keyColor = "magenta";
        }
        {
          type = "memory";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "────────────────────────────────────────────────────";
        }
        "break"
        {
          type = "custom";
          format = "──────────────────────Software──────────────────────";
        }
        {
          type = "os";
          keyColor = "light_magenta";
        }
        {
          type = "kernel";
          keyColor = "light_magenta";
        }
        {
          type = "packages";
          keyColor = "light_magenta";
        }
        {
          type = "wm";
          keyColor = "magenta";
        }
        {
          type = "lm";
          keyColor = "magenta";
        }
        {
          type = "terminal";
          keyColor = "magenta";
        }
        {
          type = "shell";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "────────────────────────────────────────────────────";
        }
        "break"
        {
          type = "custom";
          format = "────────────────────Uptime / Age────────────────────";
        }
        {
          type = "command";
          key = "  OS Age ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  Uptime ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "────────────────────────────────────────────────────";
        }
        "break"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      pipes = "cd ~/pipes.sh && ./pipes.sh";
      home = "sudo vim /etc/nixos/home.nix";
      config = "sudo vim /etc/nixos/configuration.nix";
      flake = "sudo vim /etc/nixos/flake.nix";
      noctalia = "sudo vim /etc/nixos/noctalia.nix";
      niriconfig = "vim ~/.config/niri/config.kdl";
      balatro = "wine64 ~/Downloads/Balatro/Balatro.exe";
      ultrakill = "echo use steam dumbass";
      ckear = "clear";
      clea = "clear";
      autoclicker = "~/.local/bin/autoclicker";
      autoclick = "~/.local/bin/autoclicker toggle";
      ff = "fastfetch --logo none";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];

    initContent = '' 
      export PATH="$HOME/.local/bin:$PATH"
      fastfetch
    '';
  };

  # Alacritty configuration with inline AMOLED Lilac theme
  home.file.".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.85
    
    [window.padding]
    x = 0
    y = 10

    [font]
    normal.family = "Cozette"
    bold.family = "Cozette"
    italic.family = "Cozette"
    bold_italic.family = "Cozette"
    size = 13

    # AMOLED Lilac Color Scheme
    [colors.primary]
    background = "${colors.background}"
    foreground = "${colors.foreground}"

    [colors.cursor]
    cursor = "${colors.cursor}"
    text = "${colors.background}"

    [colors.selection]
    background = "${colors.selection}"
    text = "${colors.foreground}"

    [colors.normal]
    black = "${colors.black}"
    red = "${colors.red}"
    green = "${colors.green}"
    yellow = "${colors.yellow}"
    blue = "${colors.blue}"
    magenta = "${colors.magenta}"
    cyan = "${colors.cyan}"
    white = "${colors.white}"

    [colors.bright]
    black = "${colors.bright_black}"
    red = "${colors.bright_red}"
    green = "${colors.bright_green}"
    yellow = "${colors.bright_yellow}"
    blue = "${colors.bright_blue}"
    magenta = "${colors.bright_magenta}"
    cyan = "${colors.bright_cyan}"
    white = "${colors.bright_white}"
  '';

  # Fuzzel configuration with inline AMOLED Lilac theme
  home.file.".config/fuzzel/fuzzel.ini".text = ''
    [main]
    terminal = alacritty -e
    width = 40
    lines = 15
    icon-size = 40
    font = Terminess Nerd Font:size=16
    inner-pad = 12
    border-width = 2
    border-radius = 12

    # AMOLED Lilac Color Scheme
    [colors]
    background=${colors.background}EE
    text=${colors.foreground}FF
    match=${colors.primary}FF
    selection=${colors.selection}FF
    selection-text=${colors.bright_white}FF
    selection-match=${colors.bright_red}FF
    border=${colors.secondary}FF
  '';

  home.file.".local/bin/autoclicker".source = pkgs.writeShellScript "autoclicker" ''
    #!/usr/bin/env bash

    PID_FILE="/tmp/autoclicker.pid"
    CONFIG_FILE="/tmp/autoclicker.conf"

    if [ -f "$CONFIG_FILE" ]; then
        CLICK_SPEED=$(cat "$CONFIG_FILE")
    else
        CLICK_SPEED=10
    fi

    start_clicking() {
        if [ -f "$PID_FILE" ]; then
            notify-send "Autoclicker" "Already running!" -t 1000
            return
        fi
        
        CLICK_INTERVAL=$(${pkgs.bc}/bin/bc <<< "scale=4; 1 / $CLICK_SPEED")
        
        (
            while [ -f "$PID_FILE" ]; do
                ${pkgs.xdotool}/bin/xdotool click 1
                sleep "$CLICK_INTERVAL"
            done
        ) &
        
        echo $! > "$PID_FILE"
        notify-send "Autoclicker" "Started - $CLICK_SPEED clicks/sec" -t 1500
    }

    stop_clicking() {
        if [ -f "$PID_FILE" ]; then
            kill $(cat "$PID_FILE") 2>/dev/null
            rm "$PID_FILE"
            notify-send "Autoclicker" "Stopped" -t 1000
        else
            notify-send "Autoclicker" "Not running" -t 1000
        fi
    }

    toggle_clicking() {
        if [ -f "$PID_FILE" ]; then
            stop_clicking
        else
            start_clicking
        fi
    }

    if [ "$1" = "toggle" ]; then
        toggle_clicking
        exit 0
    fi

    while true; do
        if [ -f "$PID_FILE" ]; then
            STATUS="Running at $CLICK_SPEED clicks/sec"
            ACTION=$(${pkgs.zenity}/bin/zenity --list \
                --title="Autoclicker" \
                --text="$STATUS" \
                --column="Action" \
                "Stop" \
                "Change Speed" \
                "Quit" \
                --width=300 --height=250 2>/dev/null)
        else
            STATUS="Not running"
            ACTION=$(${pkgs.zenity}/bin/zenity --list \
                --title="Autoclicker" \
                --text="$STATUS\nCurrent speed: $CLICK_SPEED clicks/sec" \
                --column="Action" \
                "Start" \
                "Change Speed" \
                "Quit" \
                --width=300 --height=250 2>/dev/null)
        fi
        
        case $ACTION in
            "Start")
                start_clicking
                ;;
            "Stop")
                stop_clicking
                ;;
            "Change Speed")
                NEW_SPEED=$(${pkgs.zenity}/bin/zenity --scale \
                    --title="Click Speed" \
                    --text="Set clicks per second:" \
                    --min-value=1 --max-value=1000 \
                    --value=$CLICK_SPEED \
                    --step=1 2>/dev/null)
                
                if [ $? -eq 0 ] && [ -n "$NEW_SPEED" ]; then
                    CLICK_SPEED=$NEW_SPEED
                    echo "$CLICK_SPEED" > "$CONFIG_FILE"
                    notify-send "Autoclicker" "Speed set to $CLICK_SPEED clicks/sec" -t 1000
                    
                    if [ -f "$PID_FILE" ]; then
                        stop_clicking
                        sleep 0.2
                        start_clicking
                    fi
                fi
                ;;
            *)
                stop_clicking
                exit 0
                ;;
        esac
    done
  '';

  home.file.".local/bin/autoclicker".executable = true;
}

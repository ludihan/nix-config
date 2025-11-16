{ inputs, lib, config, pkgs, ... }: {
    # You can import other home-manager modules here
    imports = [
        # If you want to use home-manager modules from other flakes (such as nix-colors):
        # inputs.nix-colors.homeManagerModule

        # You can also split up your configuration and import pieces of it here:
        # ./nvim.nix
    ];

    nixpkgs = {
        # You can add overlays here
        overlays = [
            # If you want to use overlays exported from other flakes:
            # neovim-nightly-overlay.overlays.default

            # Or define it inline, for example:
            # (final: prev: {
            #   hi = final.hello.overrideAttrs (oldAttrs: {
            #     patches = [ ./change-hello-to-hi.patch ];
            #   });
            # })
        ];
        # Configure your nixpkgs instance
        config = {
            # Disable if you don't want unfree packages
            allowUnfree = true;
            # Workaround for https://github.com/nix-community/home-manager/issues/2942
            allowUnfreePredicate = _: true;
        };
    };

    home = rec {
        username = "ludihan";
        homeDirectory = "/home/ludihan";
        preferXdgDirectories = true;
        sessionVariables = rec {
            GOPATH = "$XDG_DATA_HOME/go";
            CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
            PYTHON_HISTORY = "$XDG_STATE_HOME/python_history";
            PYTHONPYCACHEPREFIX = "$XDG_CACHE_HOME/python";
            PYTHONUSERBASE = "($XDG_DATA_HOME)/python";
            PSQL_HISTORY = "($XDG_STATE_HOME)/psql_history";
            SQLITE_HISTORY = "($XDG_STATE_HOME)/sqlite_history";
            NPM_CONFIG_USERCONFIG = "($XDG_CONFIG_HOME)/npm/npmrc";
            CARGO_HOME = "($XDG_DATA_HOME)/cargo";
            RUSTUP_HOME = "($XDG_DATA_HOME)/rustup";
            NODE_REPL_HISTORY = "($XDG_STATE_HOME)/node_repl_history";
            DOCKER_CONFIG = "($XDG_CONFIG_HOME)/docker";
            GHCUP_USE_XDG_DIRS = "true";
            OPAMROOT = "($XDG_DATA_HOME)/opam";
            _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=($XDG_CONFIG_HOME)/java";
            OMNISHARPHOME = "($XDG_CONFIG_HOME)/omnisharp";
            NUGET_PACKAGES = "($XDG_CACHE_HOME)/NuGetPackages";
            EDITOR = "nvim";
            VISUAL = "nvim";
        };
        sessionPath = [
            "$HOME/.local/bin"
            "$CARGO_HOME/bin"
            "$GOPATH/bin"
        ];
    };
    gtk = {
        enable = true;
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };
        iconTheme = {
            name = "Obsidian-Sand";
            package = pkgs.iconpack-obsidian;
        };
        cursorTheme = {
            name = "adwaita";
        };
    };
    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
    };
    dconf = {
        enable = true;
        settings = {
            "org/gnome/desktop/background" = {
                picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
            };
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
    };


    home.packages = with pkgs; [ 
        discord
        wget
        curl
        jq
        jo
        grim
        slurp
        gcc
        rustup
        dotnet-sdk
        go
        nodejs
        python3
        uv
        blender
        vivid
        carapace
        firefox
        steam 
        osu-lazer-bin
        gh
        docker-compose
        nushell
        hyprpicker
        brightnessctl
        imv
        inxi
        kdePackages.kate
        krita
        kdePackages.kdenlive
        love
        mednafen
        git
        lf
        batsignal
        networkmanagerapplet
        unzip
        unrar
        zip
    ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };
    programs.discord.enable = true;
    programs.home-manager.enable = true;
    programs.fuzzel = {
        enable = true;
        settings = {
            main = {
                font="Iosevka:size=16";
                lines=30;
                dpi-aware=false;
                terminal = "foot";
            };
            colors = {
                background="#1A1A1AFF";
                border="#1A1A1AFF";
                selection="#505050FF";
                selection-text="#FFFFFFFF";
                selection-match="#FE8019FF";
                input="#FFFFFFFF";
                text="#AAAAAAAA";
                match="#FE8019FF";
                prompt="#FE8019FF";
            };
            border = {
                radius=0;
            };
        };
    };
    programs.tmux = {
        enable = true;
        extraConfig = ''
            bind C-p swapw -d -t -1
            bind C-n swapw -d -t +1

            bind h selectp -L
            bind j selectp -D
            bind k selectp -U
            bind l selectp -R

            bind -r H resizep -L 5
            bind -r J resizep -D 5
            bind -r K resizep -U 5
            bind -r L resizep -R 5

            bind o splitw -h
            bind i splitw -v
        '';
    };
    programs.swaylock = {
        enable = true;
        settings = {
            ignore-empty-password = true;
            indicator-caps-lock = true;
            color = "262626";
        };
    };
    services.mako = {
        enable = true;
        extraConfig = ''
            font=Terminus 10
            default-timeout=10000
            background-color=#222222
            border-color=#666666
            text-color=#ffffff

            [urgency=low]
            default-timeout=5000

            [urgency=critical]
            ignore-timeout=1
        '';
    };

    programs.waybar = {
        enable = true;
        settings.mainBar = {
            spacing = 10;
            modules-left = [
                "niri/workspaces"
                "niri/window"
            ];
            modules-right = [
                "tray"
                "pulseaudio"
                "network"
                "cpu"
                "memory"
                "temperature"
                "backlight"
                "battery"
                "clock"
            ];
            clock = {
                format = "[{:%F %H:%M}]";
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            };
            cpu = {
                format = "[CPU:{usage}%]";
            };
            memory = {
                format = "[MEM:{percentage}%]";
            };
            temperature ={
                critical-threshold = 80;
                format-critical = "[!!{temperatureC}°C!!]";
                format = "[{temperatureC}°C]";
            };
            battery = {
                states = {
                    good = 95;
                    warning = 30;
                    critical = 15;
                };
                format = "[BAT:{capacity}%]";
            };
            pulseaudio = {
                format = "[VOL:{volume}% MIC:{format_source}]";
                format-muted = "[VOL:{volume}%(MUTE) MIC:{format_source}]";
                format-source = "{volume}%";
                format-source-muted = "{volume}%(MIC MUTE)";
            };
            network = {
                format-wifi = "[NET:{signalStrength}%]";
                format-ethernet = "[NET:{ifname}]";
                format-linked = "[NET:No IP]";
                format-disconnected = "[NET:Disconnected]";
            };
            backlight = {
                format = "[BKL: {percent}%]";
            };
        };
        style = ''
            * {
                /* `otf-font-awesome` is required to be installed for icons */
                font-family: Iosevka;
                font-feature-settings: "liga off, calt off";
                border-radius: 0px;
                /* min-height: 0px; */
            }

            window#waybar {
                background-color: #1A1A1A;
                color: #ffffff;
                opacity: 1;
            }

            #workspaces button {
                padding: 0 5px;
                background-color: transparent;
                color: #ffffff;
                border: none;
            }

            #workspaces button.focused {
                background-color: #555555;
                color: #ffffff;
            }

            #workspaces button.urgent {
                background-color: #eb4d4b;
            }

            button:hover {
                box-shadow: none;
                /* Remove predefined box-shadow */
                text-shadow: none;
                /* Remove predefined text-shadow */
                background: none;
                /* Remove predefined background color (white) */
                transition: none;
                /* Disable predefined animations */
            }

            #mode {
                background-color: #64727D;
            }
        '';
    };

    programs.mpv = {
        enable = true;
        config = {
            keep-open = true;
        };
    };

    programs.zathura = {
        enable = true;
        extraConfig = ''
        set font "Terminus 12"
        set selection-clipboard clipboard
        map <C--> zoom out
        map = zoom in
        map <Left> navigate previous
        map <Right> navigate next
        '';
    };

    xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/nvim;
    xdg.configFile.niri.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/niri;
    xdg.configFile.lf.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/lf;
    xdg.configFile.npm.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/npm;
    xdg.configFile.nushell.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/nushell;
    xdg.configFile.git.source = config.lib.file.mkOutOfStoreSymlink /home/ludihan/.config/home-manager/config/git;
    xdg.userDirs = {
        desktop = null;
        templates = null;
        publicShare = null;
    };
    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "25.05";
}

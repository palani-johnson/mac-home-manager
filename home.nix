{pkgs, ...}: let
  me = "pjohnso3";
  home = "/Users/${me}";

  sessionVariables = {
    EDITOR = "code";
  };
in {
  home = {
    username = me;
    homeDirectory = home;
    stateVersion = "24.11";
    packages = with pkgs; [
      nixd
      alejandra
      imagemagick
      docker
      docker-credential-helpers
      python3
      colima
      kubectl
    ];

    sessionVariables = sessionVariables;
    preferXdgDirectories = true;
  };

  launchd.enable = true;
  launchd.agents."com.${me}.colima" = {
    enable = true;
    config = {
      Label = "com.${me}.colima";
      Program = "${pkgs.colima}/bin/colima";
      ProgramArguments = [
        "start"
        "--vm-type=vz"
        "--vz-rosetta"
        "--memory"
        "4"
      ];
      RunAtLoad = true; # Runs at login
      LaunchOnlyOnce = true; # Don't restart if already running
      KeepAlive = false; # Don't restart if dies
      WorkingDirectory = home;
    };
  };

  xdg.enable = true;

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      sessionVariables = sessionVariables;
      dotDir = ".config/zsh";
      history.path = "$HOME/.cache/zsh/history";
      initExtra = builtins.readFile ./zsh/initExtra.zsh;
      enableCompletion = true;
      prezto.enable = true;
    };

    nushell = {
      enable = true;
      extraConfig = builtins.readFile ./nushell/extraConfig.nu;
    };

    git = {
      enable = true;
      userName = "Palani Johnson";
      userEmail = "palanijohnson@gmail.com";
      extraConfig.init.defaultBranch = "main";
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        format = "$username$hostname$directory$git_branch$git_state$git_status$nix_shell$cmd_duration$line_break$sudo$status$shell$character";

        fill.disabled = false;
        fill.symbol = " ";
        shell.disabled = false;
        cmd_duration.format = "[$duration]($style) ";
        git_branch.format = "[$symbol$branch(:$remote_branch)]($style) ";
        nix_shell.format = "[ $name]($style) ";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      silent = true;
      config = {
        global.warn_timeout = "1m";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "Default";
        theme_background = false;
        proc_tree = true;
        proc_left = true;
      };
    };
  };
}

# NixOS Home-manager config

{ config, pkgs, ... }:

{
  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "michael";
  home.homeDirectory = "/home/michael";

  # User packages
  home.packages = with pkgs; [
    neofetch
    pfetch
    zsh-autosuggestions
    zsh-powerlevel10k
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
	neofetch
    '';

    localVariables = {
      COMPLETION_WAITING_DOTS = "true";
      HIST_STAMPS = "yyyy-mm-dd";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      l = "ls -lah";
      la = "ls -a";
      rf = "rm -rf";
      nf = "neofetch";
      pfetch = "PF_INFO='ascii title os kernel pkgs uptime shell editor memory palette' PF_COL2=8 PF_COL1=6 PF_COL3=4 pfetch";
      pf = "pfetch";
      sudo = "sudo ";
      nvim = "nvim -u $HOME/.config/nvim/init.vim";
    };

    # Manually load zsh plugins
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "alias-finder"
        "cargo"
        "command-not-found"
        "common-aliases"
        "cp"
        "docker"
        "docker-compose"
        "docker-machine"
        "dotnet"
        "extract"
        "git"
        "gitignore"
        "golang"
        "pip"
        "python"
        "rust"
        "rustup"
        "sudo"
        "systemd"
        "virtualenv"
        "yarn"
      ];
    };

    # Enable zsh-autosuggestions
    enableAutosuggestions = true;
  };

  # NeoVim setup
  programs.neovim = {
    enable = true;
    extraConfig = ''
      syntax enable
      set ts=4 sw=4
      set number

      " Move vim keys to the home row
      noremap ; l
      noremap l k
      noremap k j
      noremap j h

      " Adjust movement keys to compensate
      noremap h ,
      noremap , ;

	  " Remember last position
	  autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    '';
  };

  # Git setup
  programs.git = {
    enable = true;
    userEmail = "rivnakm1@gmail.com";
    userName = "Michael Rivnak";
    extraConfig = {
      pull.rebase = false;
    };
  };

  # Neofetch setup
  home.file.".config/neofetch/config.conf".source = ./neofetch.conf;

  # Visual Studio Code Server
  services.vscode-server.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}

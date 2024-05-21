# { config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "eriberttom";
  home.homeDirectory = "/home/eriberttom";


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.

    # misc
    cowsay
    lolcat
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix-related
    nixfmt
    nix-output-monitor
    nixpkgs-fmt

    ## productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    ## cli-related
    nnn
    fastfetch
    aria2
    fortune
    lsd
    fzf
    coreutils-full
    htop
    yt-dlp
    bat # cat clone with wings!
    eza # modern day ls replacement in Rust
    mtr
    iperf3
    dnsutils
    socat # netcat replacement
    nmap
    ipcalc
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    lm_sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # guis
    w3m
    firefox-beta
    logseq
    transmission
    wezterm
    glances
    python312Full
    gnome.gnome-tweaks
    sioyek # pdf for technical papers
    zathura
    mpv

    # editors
    emacs29-gtk3
    emacsPackages.nixpkgs-fmt
    emacsPackages.tree-sitter
    emacsPackages.pandoc
    libsForQt5.kate # kate kde editor
    pandoc

    # audio/video chat (unfree)
    zoom-us
    slack

    # archivers
    zip
    xz
    unzip
    p7zip



    # some nerdfonts
    terminus-nerdfont
    inconsolata-nerdfont
    guake



    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "FantasqueSansMono" "DroidSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # entry for git
  programs.git = {
    enable = true;
    userName = "erimendz-nixos";
    userEmail = "erimendz@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
    '';
    shellAliases = {
      cls = "clear";
      grep = "grep -i --color=auto";
      ll = "lsd -ta";
      # add git aliases here
      grv = "git remote -v";
      gst = "git status";
      glo = "git log --oneline --decorate";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      gb = "git branch";
      gaa = "git add --all";
      gcmsg = "git commit -m";
      gd = "git diff";
      gcb = "git checkout -b";
      gp = "git push";
      gup = "git pull --rebase";
      # yt-dlp
      yta-aac = "yt-dlp --extract-audio --audio-format aac ";
      yta-best = "yt-dlp --extract-audio --audio-format best ";
      yta-flac = "yt-dlp --extract-audio --audio-format flac ";
      yta-mp3 = "yt-dlp --extract-audio --audio-format mp3 ";
      ytv-best = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 ";

    };
  };
  programs.bash.initExtra = ''
    cdl () {
    cd "$@" && ll
    }
  '';

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  # prompt prettifier
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    # custom settings
    settings = {
      add_newline = false;
      # aws.enabled = false;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # wezterm
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    # extraConfig = ''
    #   font = wezterm.font("JetBrains Mono"),
    #   font_size = 16.0,
    #   color_scheme = "Tomorrow Night",
    #   hide_tab_bar_if_only_one_tab = true,
    # '';

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/eriberttom/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  services.emacs.defaultEditor = true;
  services.emacs.startWithUserSession = "graphical";
  xsession.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:

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

    emacs29-gtk3
    emacsPackages.mpv
    emacsPackages.w3m
    sbcl
    lispPackages.quicklisp
    aria
    # transmission-qt #bittorrent
    qbittorrent-qt5
    pandoc
    emacsPackages.pandoc
    libsForQt5.kate
    nixfmt # nix code formatter
    alejandra # yet another formatter, see github page for details, another candidate is nixfmt
    mpv
    fastfetch
    htop
    ponysay
    fortune
    cowsay
    lolcat
    mediawriter # usb iso writer
    python3 # version 3.11.8 as of April 25/24
    # https://racket-lang.org/
    racket
    # onlyoffice-bin
    libreoffice-qt
    ncdu
    which
    file
    tree
    lsd
    gparted
    meld # diff tool
    procs
    du-dust
    ripgrep
    # koreader # epub (and others) reader
    bandwhich
    bat
    lshw # provide detailed info of hardware
    geany
    gnome.gnome-tweaks
    kitty
    kitty-img
    kitty-themes
    w3m
    nyxt # lisp-coded cli browser https://nyxt.atlas.engineer/
    vivaldi # browser
    hblock
    gh
    flatpak
    lazygit # https://github.com/jesseduffield/lazygit
    # logseq
    starship
    unicode-emoji
    twitter-color-emoji
    nodePackages.emojione
    emojione
    # fonts
    roboto-serif
    roboto-mono
    jetbrains-mono
    source-code-pro
    # Linux devices manager for the Logitech Unifying Receiver
    solaar

    # audio/video chat
    # zoom-us
    # telegram-desktop

    # pdf readers
    libsForQt5.okular
    sioyek # pdf for technical papers
    zathura # pdf reader

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override {
      fonts = [ "FantasqueSansMono" "FiraCode" "Iosevka" "Inconsolata" ];
    })

  ];

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


  home.sessionVariables = {
    EDITOR = "emacsclient -t";
    VISUAL = "emacsclient -c -a emacs";
    ALTERNATE_EDITOR = "";

  };
  # services.emacs.defaultEditor = true;
  services.emacs.startWithUserSession = "graphical";
  services.emacs.enable = true;
  xsession.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

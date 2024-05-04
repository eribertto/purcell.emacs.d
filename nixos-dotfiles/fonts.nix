{ config, pkgs, ... }:

{
  fontconfig = {
    enable = true;
  };
  fonts = with pkgs; [
    anonymousPro
    arkpandora_ttf
    caladea
    carlito
    comfortaa
    comic-relief
    crimson
    dejavu_fonts
    # google-fonts
    inconsolata
    # liberationsansnarrow
    liberation_ttf
    jetbrains-mono
    fira-code
    noto-fonts-emoji
    libertine
    mononoki
    montserrat
    norwester-font
    # opensans-ttf
    powerline-fonts
    roboto
    sampradaya
    source-code-pro
    source-sans-pro
    source-serif-pro
    tai-ahom
    tempora_lgc
    terminus_font
    theano
    ubuntu_font_family
    corefonts
    monoid
  ];
}

{ pkgs, ... }:
let

  # My shell aliases
  myAliases = {
    premacs = "~/temp/emacs.build.devel/result/bin/emacs  --fullscreen --init-directory=~/Github-repos/emacs.prelude/ --file=~/.emacs.d/notes/gratitude.diary.org&";
    enan = "~/temp/emacs.build.devel/result/bin/emacs  --fullscreen --init-directory=~/Github-repos/nano-emacs/ --file=~/Github-repos/nano-emacs/README.org&";
    ls = "eza --icons -l -T -L=1";
    c = "clear";
    grep = "grep -i --color=auto";
    cat = "bat";
    htop = "btm";
    fd = "fd -Lu";
    w3m = "w3m -no-cookie -v";
    neofetch = "disfetch";
    fetch = "disfetch";
    gitfetch = "onefetch";
    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild";
    home-manager = "systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=16000M -p CPUQuota=60% home-manager";
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
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    shellAliases = myAliases;
    initExtra = ''
      cdl () {
      cd "$@" && ls
      }
    '';

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

  home.packages = with pkgs; [
    disfetch lolcat cowsay onefetch
    gnugrep gnused
    bat eza bottom fd bc
    direnv nix-direnv yt-dlp
  ];

  programs.direnv.enable = true;
  programs.direnv.enableBashIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}

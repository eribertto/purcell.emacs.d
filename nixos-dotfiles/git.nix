{ ... }: {
  # TODO get name, email, & key from config or user
  config = {
    programs.git = {
      enable = true;
      userName = "Eriberttom Nixos Dellpreci";
      userEmail = "erimendz@gmail.com";
      # signing = {
        # key = "ED1A8299";
        # signByDefault = true;
        # };
        extraConfig = {
          init.defaultBranch = "main";
          pull.ff = true;
          pull.rebase = true;
          rebase.autosquash = true;
          help.autoCorrect = "prompt";
        };
        delta.enable = true;
    };

    programs.gh = {
      enable = true;
      settings.git_protocol = "https";
    };

    # https://github.com/jesseduffield/lazygit
    programs.lazygit = {
      enable = true;
      settings = { };
    };
  };
}

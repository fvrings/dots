{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          command = "git commit --allow-empty -m 'empty commit'";
          context = "commits";
          description = "Add empty commit";
          key = "E";
          loadingText = "Committing empty commit...";
        }
      ];
      disableStartupPopups = true;
      # TODO: use stylix here
      gui = {
        authorColors = {
          "*" = "#b4befe";
        };
        theme = {
          activeBorderColor = [
            "#f5e0dc"
            "bold"
          ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#f5e0dc" ];
          defaultFgColor = [ "#cdd6f4" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
          selectedLineBgColor = [ "#313244" ];
          unstagedChangesColor = [ "#f38ba8" ];
        };
      };
      keybinding = {
        commits = {
          moveDownCommit = "<c-n>";
          moveUpCommit = "<c-p>";
        };
      };
    };
  };
}

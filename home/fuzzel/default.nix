_: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = ">>  ";
      };
      border = {
        radius = 17;
        width = 1;
      };
      dmenu = {
        exit-immediately-if-empty = true;
      };
    };
  };
}

{
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "ring" ];
        keepEnv = true;
        persist = true;
      }
      # Allow your user to run switch-to-specialisation and back without a password
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/specialisation/oxocarbon-dark/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/specialisation/gruvbox-material-light-soft/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/specialisation/catppuccin-latte/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
    ];
  };
}

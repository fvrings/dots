{ config, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/mimi.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/etc/nixos/dots/secrets/key.txt";
    secrets = {
      "config.dae" = {
        owner = config.users.users.ring.name;
      };
      "configjp.dae" = {
        owner = config.users.users.ring.name;
      };
      "configsg.dae" = {
        owner = config.users.users.ring.name;
      };
      "gh" = { };
      "gpt" = {
        owner = config.users.users.ring.name;
      };
    };
  };
}

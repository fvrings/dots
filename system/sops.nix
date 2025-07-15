{ config, ... }:
{
  sops = {
    defaultSopsFile = ../secrets/mimi.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/etc/nixos/keys.txt";
    secrets = {
      "config.dae" = {
        owner = config.users.users.ring.name;
      };
      "configjp.dae" = {
        owner = config.users.users.ring.name;
      };
      "gh" = { };
      "gpt" = {
        owner = config.users.users.ring.name;
      };
    };
  };
}

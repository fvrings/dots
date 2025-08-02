{ config, ... }:
{
  services.dae = {
    # enable = config.networking.hostName == "art";
    enable = false;
    # configFile = "/home/ring/example.dae";
    configFile = config.sops.secrets."config.dae".path;
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
  programs.clash-verge = {
    enable = true;
    tunMode = true;
    serviceMode = true;
  };
}

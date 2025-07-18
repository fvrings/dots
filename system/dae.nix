{ config, ... }:
{
  services.dae = {
    enable = config.networking.hostName == "art";
    # configFile = "/home/ring/example.dae";
    configFile = config.sops.secrets."configjp.dae".path;
    openFirewall = {
      enable = true;
      port = 12345;
    };
  };
}

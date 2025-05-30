{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "localhost";
    package = pkgs.nextcloud31;
    config.adminpassFile = config.sops.secrets."cloud".path;
    config.dbtype = "sqlite";
    extraAppsEnable = true;
    configureRedis = true;
    settings.trusted_domains = [
      "winart.local"
      "192.168.0.3"
    ];
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        tasks
        ;
    };
  };
  sops.secrets."cloud" = {
    owner = config.users.users.ring.name;
  };
  networking.extraHosts = ''
    192.168.0.3 winart.local
  '';
}

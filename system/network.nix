{ lib, ... }:
{
  networking = {
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      insertNameservers = [
        "10.0.100.1"
      ];
    };
    # networkmanager.wifi.backend = "iwd"; # Easiest to use and most distros use this by default.
    firewall.allowedTCPPorts = [
      3000
      8000
      80
      443
    ];
    nftables.enable = true;
    firewall.trustedInterfaces = [
      "incusbr0"
      "virbr0"
      "dae0"
    ];

    # resolvconf.enable = false;
    #
    # search = [ "lxd" ];
  };

}

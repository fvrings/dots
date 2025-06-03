{ ... }:
{
  imports = [
    # ./guix.nix
    # ./nextcloud.nix
    # ./ocis.nix
  ];
  # NOTE: the southbridge is fucked in this host
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
  '';
}

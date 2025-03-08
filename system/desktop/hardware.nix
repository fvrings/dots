{ pkgs, ... }:
{
  hardware = {
    # List services that you want to enable:
    # i2c.enable = true;
    # pulseaudio.support32Bit = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    pulseaudio.enable = false;
  };
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
    xserver = {
      # mpd.enable = true;
      enable = true;
      # v2raya.enable = true;
      # xserver.displayManager.gdm = {
      #   enable = true;
      # };
      # desktopManager.plasma6.enable = true;
      xkb.options = "caps:swapescape";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs = {
    light.enable = true;
  };
}

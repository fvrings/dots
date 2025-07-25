_: {
  # services.upower.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        ideapad_laptop_conservation_mode = true;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}

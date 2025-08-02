{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.rust-overlay.overlays.default
    (final: prev: {
      linux-manual = prev.linux-manual.overrideAttrs (old: {
        installCheckPhase = ''
          echo "Skipping kmalloc(9) check for kernel 6.16"
        '';
      });
    })
  ];
}

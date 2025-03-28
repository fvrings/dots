{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    inputs.rust-overlay.overlays.default
    inputs.niri.overlays.niri
  ];
}

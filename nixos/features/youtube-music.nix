{
  flake.nixosModules.youtube-music = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.pear-desktop
    ];
  };
}

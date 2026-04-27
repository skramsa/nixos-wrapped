{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain = {pkgs, ...}: {
    imports = [
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop

      self.nixosModules.youtube-music

      # self.nixosModules.gaming
      self.nixosModules.powersave

      # disko
      # inputs.disko.nixosModules.disko
      # self.diskoConfigurations.hostMain
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;

      plymouth.enable = true;

      # kernelParams = ["quiet" "amd_pstate=guided" "processor.max_cstate=1"];
      # kernelParams = ["quiet"];
      # kernelModules = ["mt7921e" "coretemp" "cpuid" "v4l2loopback"];

      # binfmt.emulatedSystems = ["aarch64-linux"];
    };

    networking = {
      hostName = "nwa-nixos";
      networkmanager.enable = true;
    };

    i18n.defaultLocale = "de_DE.UTF-8";
    console = {
    #   font = "Lat2-Terminus16";
      keyMap = "de-latin1-nodeadkeys";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

    # virtualisation.libvirtd.enable = true;
    # virtualisation.podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   defaultNetwork.settings = {
    #     dns_enabled = true;
    #   };
    # };

    services = {
      # displayManager.ly.enable = true;
      displayManager.dms-greeter = {
        enable = true;
        compositor.name = "niri";
      };
      flatpak.enable = true;
      udisks2.enable = true;
      libinput.enable = true;
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      dbus = {
        enable = true;
        implementation = "dbus";
      };
    };
    programs = {
      firefox.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vim
      wget
      ghostty
      git
    ];

    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.enable = true;

    system.stateVersion = "25.11";
  };
}

{ pkgs, lib, ... }:
{
  imports = [
    ./hardware.nix
    ./kernel.nix
    ./firmware
    ./xserver.nix
    ./bluetooth.nix
    ./touch.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
  ];
  nixpkgs.config.allowUnfree = true; # for firmware

  # neet 4.14+ for proper hardware support (and modesetting)
  # especially for screen rotation on boot
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.linux_gpd_pocket;
  boot.initrd.kernelModules = [
    "pwm-lpss" "pwm-lpss-platform" # for brightness control
    "g_serial" # be a serial device via OTG
  ];
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  #services.xserver.enable = false;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome3.enable = true;
  services.tlp.enable = true;
  i18n = {
   consoleFont = "Lat2-Terminus16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
  };
  time.timeZone = "Australia/Sydney";
}

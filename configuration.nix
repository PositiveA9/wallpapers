{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";
  services.scx.extraArgs = [ "--autopilot" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  time.timeZone = "America/Chicago";

  services.hardware.openrgb.enable = true;

  nixpkgs.config.allowUnfree = true;

    users.users.nix = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     shell = pkgs.zsh;
     packages = with pkgs; [
       tree
     ];
   };

   programs.steam.enable = true;

   programs.thunar.enable = true;

   programs.zsh.enable = true;

   programs.kdeconnect.enable = true;

   programs.niri.enable = true;

   programs.yazi.enable = true;

   programs.firefox.enable = true;

   environment.sessionVariables = {
 	 NIXOS_OZONE_WL = "1";
   };

   services.displayManager = {
     sddm = {	
	enable = true;
	wayland.enable = true;
     };
     autoLogin = {
	enable = true;
	user = "nix";
     };
  };

   environment.systemPackages = with pkgs; [
	vim 
	wget
	git
	alacritty
	fuzzel
	fastfetch
	bibata-cursors
	google-chrome
	htop
	wine64
	winetricks
	feh
	unzip
	unrar
	xwayland-satellite
	wl-clipboard
	nmap
	python3
	xdotool
	zenity  
	bc     
	openrgb-with-all-plugins 
	signal-desktop
	playerctl
	cmatrix
	cava
	gpick
	figlet
	discord

];

   fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     cozette
     nerd-fonts.terminess-ttf
     scientifica
   ];

   fonts.fontconfig.enable = true;
   fonts.fontconfig.defaultFonts = {
     monospace = [ "Cozette" "JetBrains Mono Nerd Font" ];
     sansSerif = [ "JetBrains Mono Nerd Font" ];
     serif     = [ "JetBrains Mono Nerd Font" ];
   };

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  system.stateVersion = "25.11";

}

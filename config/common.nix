{ config, pkgs, lib, ... }:
{

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILp4HgDDRQYOp1xXPTUkqv83dZw+DGIj5jZdBzR2u57Y tom v6"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMiPPoELDHdbSRFIDU55751WYNh97bEgBKVEgx3aEvUzAAAACnNzaDp0b20tdjg= Tom-YubiKey5NFC-2"
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console = {
    keyMap = "de";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  users.users.nixos.openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;

  networking.useNetworkd = true;

  networking.nftables.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    nano
    wget
    curl
    iperf3
    git
    htop
    tmux
    picocom
    mtr
    parted
    dmidecode
    flashrom
    ncdu
    lm_sensors
    pciutils
    usbutils
    bridge-utils
    tcpdump
    whois
    netcat
    jq
    tree
    tmate

    dig
    inetutils

    ethtool
    conntrack-tools

    iw

    unzip
    zip

    (pkgs.writeShellScriptBin "firewall-allow-input" ''
      export PATH="${pkgs.nftables}/bin:$PATH"
      set -eo pipefail

      if [ "$#" -lt 1 ]; then
        echo "Usage: $0 <rule>"
        echo "alias to add a rule to the nixos-fw"
        echo ""
        echo "Examples:"
        echo "$0 tcp dport 5201 accept"
        echo "$0 udp dport 5201 accept"
        exit 1
      fi

      nft add rule inet nixos-fw input-allow $@
      exit 0
    '')

  ];

}

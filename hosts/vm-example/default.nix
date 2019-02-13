{ config, pkgs, ... }:
# zfs test vm settings
{
imports = [];

i18n = {
    #consoleFont = "Lat2-Terminus16";
    #consoleKeyMap = "colemak";
    consoleUseXkbConfig = true;
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        table
        table-others # LaTeX support
        m17n
        uniemoji # ibus 1.5.14 has emoji support : P
      ];
    };
    defaultLocale = "en_US.UTF-8";
};

services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "ctrl:nocaps";
};

time.timeZone = "US/Eastern";
services.localtime.enable = false;

programs.mtr.enable = true;
programs.bash.enableCompletion = true;

networking.hostName = "erdos";

# system.stateVersion (set to the same version as the ISO installer)

# This value determines the NixOS release with which your system is to be
# compatible, in order to avoid breaking some software such as database
# servers. You should change this only after NixOS release notes say you
# should.
system.stateVersion = "18.09"; # Did you read the comment?
}

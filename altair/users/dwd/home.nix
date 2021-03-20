{ pkgs, ... }: {
# man home-configuration.nix
# Let Home Manager install and manage itself.
programs.home-manager.enable = true;

# Home Manager needs a bit of information about you and the
# paths it should manage.
home.username = "dwd";
home.homeDirectory = "/home/dwd";

home.packages = [];

nixpkgs.config = {
    allowUnfree = true;
    # allowBroken = true;
};

programs.bash = {
    shellAliases = {
        ukbbs = "ztelnet ukbbs.zapto.org";
        fenric = "ztelnet fenric.muppetwhore.net";
        tardis = "ztelnet bbs.cortex-media.info";
        nostromo = "ztelnet nostromo.synchro.net";
        scn = "ztelnet scn.org";
    };
};

programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNixDirenvIntegration = true;
};

programs.ssh = {
    #knownHosts = {
    #  github = {
    #    hostNames = [
    #      "github.com"
    #    ];
    #    publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==";
    #  };
    #};
};

programs.irssi.networks = {
    freenode = {
    nick = "dwd";
    server = {
        address = "chat.freenode.net";
        port = 6697;
        autoConnect = true;
    };
    channels = {
        nixos.autoJoin = true;
    };
    };
};

programs.git = {
    enable = true;
    userName = "Dan Dart";
    userEmail = "git@dandart.co.uk";
};

programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
    fugitive
    gundo
    nerdtree
    # node
    # onedark
    polyglot
    taglist
    # unimpaired
    ];
    settings = {
    background = "dark";
    expandtab = true;
    ignorecase = true;
    shiftwidth = 4;
    tabstop = 4;
    };
};

programs.vscode = {
    enable = true;
    # extensions = []
    #haskell = {
    #  enable = true;
    #hie = {
    #  enable = true;
    #};
    #};
    # userSettings = 

    # keybindings = 

};

services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
};

# services.code-server.enable = true;

programs.home-manager = {
    path = "";
};

# This value determines the Home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new Home Manager release introduces backwards
# incompatible changes.
#
# You can update Home Manager without changing this value. See
# the Home Manager release notes for a list of state version
# changes in each release.
home.stateVersion = "21.03";
}
pkgs:
(with pkgs; [
    amarok
    qdirstat
    systemdgenie
]) ++
(with pkgs.kdePackages; [
    # akregator
    # alligator
    ark
    # artikulate
    # audiotube
    bomber
    bovo
    breeze
    breeze-grub
    breeze-gtk
    breeze-icons
    breeze-plymouth
    # discover # no need?
    dolphin
    dolphin-plugins
    # dragon # aeeehhh
    # elisa # ehh
    filelight
    francis
    # full # !!!
    granatier
    gwenview
    isoimagewriter
    juk
    kaccounts-integration
    kaccounts-providers
    kalarm
    kalgebra
    kalm
    kalzium
    # kamoso # BROKEN
    kapman
    kasts
    katomic
    # kauth # ???
    kbackup
    kblocks
    kbounce
    kbreakout
    kcalc
    # kcompletion # ???
    kcron
    kdeplasma-addons
    kdevelop
    kdf
    kdiagram
    kdiamond
    # kdnssd # lib?
    keysmith
    kfourinline
    kget
    kgoldrunner
    # kgpg # dupe
    kgraphviewer
    khangman
    khealthcertificate
    kidletime
    # kig # BROKEN
    kigo
    killbots
    kio
    kio-admin # default?
    kio-extras
    kio-extras-kf5
    kio-fuse
    kio-gdrive
    kio-zeroconf
    kirigami
    kirigami-addons
    kirigami-gallery
    kiriki
    kiten
    # kleopatra # dupe
    klickety
    klines
    kmail
    kmail-account-wizard
    kmines
    kmouth
    kmplot
    knavalbattle
    knetwalk
    knewstuff
    knights
    koko
    kolf
    kolourpaint
    kompare
    kontact
    konqueror
    konquest
    konversation
    korganizer
    kpat
    kreversi
    ksirk
    # ksshaskpass
    ksudoku
    ksquares
    kteatime
    ktorrent
    ktimer
    # kwallet-pam
    kup
    # kwave # BROKEN
    # marble # BROKEN
    merkuro
    minuet
    # neochat # No libolm
    okular
    plasma-disks
    plasma-firewall
    plasma-browser-integration
    # ``plasma-thunderbolt
    plasma-vault
    plasmatube
    plymouth-kcm
    phonon
    # phonon-backend-gstreamer
    step
    sweeper
    tokodon
    yakuake
    xdg-desktop-portal-kde # ???
    # kdeconnect-kde # dealt with
    # plasma-hud # nose-1.3.7 not supported for interpreter python3.12
])

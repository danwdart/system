{ pkgs, ... }:
with pkgs; [
    ark
    kdeApplications.gwenview
    kdeApplications.kalarm
    kdeApplications.kdeconnect-kde
    kdeApplications.okular
    ktorrent
    libsForQt5.phonon
    libsForQt5.phonon-backend-gstreamer
    plasma5.plasma-browser-integration
    qdirstat
]
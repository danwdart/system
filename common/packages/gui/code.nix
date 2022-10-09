pkgs:
with pkgs; [
    cool-retro-term
    androidStudioPackages.canary
    android-tools
    circup
    diylc
    gnucap
    horizon-eda
    kate
    librepcb
    logisim
    logisim-evolution
    ngspice
    pcb
    python310Packages.cirq-web
    # python310Packages.cirq-rigetti # failing tests, no binary???
    python310Packages.cirq-pasqal
    python310Packages.cirq-ionq
    # python310Packages.cirq-google # build failure
    python310Packages.cirq-core
    python310Packages.cirq-aqt
    # python310Packages.cirq # depends on rigetti
    qucs
    stlink
    tkgate
    vscode # insiders?
    x11docker
    xcircuit
    xyce
    xyce-parallel
]

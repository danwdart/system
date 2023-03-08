pkgs:
with pkgs; [
    cool-retro-term
    # android-tools # build failure at fipsmodule
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
    # python312Packages.cirq-web # presumably dependent on core
    # python312Packages.cirq-rigetti # failing tests, no binary???
    # python312Packages.cirq-pasqal # presumably dependent on core
    # python312Packages.cirq-ionq # build failure
    # python312Packages.cirq-google # build failure
    # python312Packages.cirq-core # fails to build
    # python312Packages.cirq-aqto # missing
    # python312Packages.cirq # depends on rigetti
    qucs
    stlink
    tkgate
    vscode # insiders?
    x11docker
    xcircuit
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    androidStudioPackages.canary # dependent on android-tools?
    xyce # broken on aarch64
    xyce-parallel
] else [
])

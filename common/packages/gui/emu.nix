pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    chiaki-ng
    # desmume # no longer builds
    dosbox
    # duckstation # unmaintained
    # epsxe # insecure openssl
    higan
    mednafen
    melonDS
    mymcplus # yes no desktop entry
    # pcsxr # depends on insecure ffmpeg
    ppsspp
    #protontricks8
    proton-caller
    # rpcs3 # fails to build
    ruffle
    virt-viewer
    # waydroid # cython-0.29.37.1 not supported for interpreter python3.13
    # winePackages.fonts
    # master.winePackages.staging
    # winetricks # depend on correct version
    #(winetricks.override {
    #    wine = wineWowPackages.staging;
    #})
    wiiload
    wiimms-iso-tools
    wiiuse
    winetricks
    # master.yuzu
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # citra # broken on aarch64
    pcsx2 # keeps recompiling
    # retroarchFull # TODO: get rid of libretro-parallel-n64-code - that's the one that's broken on aarch64 # takes ages to compile even on a good machine, why is it even bothering
    wineWowPackages.fonts
    # master.wineWowPackages.staging # takes forever to compile
    wineWowPackages.staging
] else [
    # pkgs-x86_64.citra # broken on aarch64
    # pkgs-x86_64.pcsx2 # keeps recompiling
    # pkgs-x86_64.retroarchFull # TODO: get rid of libretro-parallel-n64-code - that's the one that's broken on aarch64
    # pkgs-x86_64.wineWowPackages.fonts
    # master.wineWowPackages.staging # takes forever to compile
    # pkgs-x86_64.wineWowPackages.staging
])


pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    desmume
    dosbox
    # epsxe # insecure openssl
    higan
    melonDS
    # pcsxr # depends on insecure ffmpeg
    #protontricks
    rpcs3
    # ruffle
    virt-viewer
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
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    citra # broken on aarch64
    pcsx2 # keeps recompiling
    retroarchFull # TODO: get rid of libretro-parallel-n64-code - that's the one that's broken on aarch64
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


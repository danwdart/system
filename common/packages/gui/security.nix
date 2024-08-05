pkgs:
with (import <nixpkgs> {
    config = {
        allowUnfree = true;
        permittedInsecurePackages = [
            "electron-9.4.4"
        ];
    };
}); [
    armitage
    # authy # broken
    plasma-pass
]
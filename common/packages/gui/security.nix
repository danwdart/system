pkgs:
with (import <nixpkgs> {
    config = {
        allowUnfree = true;
        permittedInsecurePackages = [
            "electron-9.4.4"
        ];
    };
}); [
    authy
    plasma-pass
]
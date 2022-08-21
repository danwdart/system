{
  nix = {
    settings = {
      substituters = [
        "https://websites.cachix.org"
        "https://static-haskell-nix.cachix.org"
      ];
      trusted-public-keys = [
        "websites.cachix.org-1:YMPYgEeWohlGq/0wDvWLVSRoNcBS1jIOmku6Djv7zcM="
        "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
        ];
    };
  };
}

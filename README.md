Unofficial Nix Flake for [Proton-CachyOS](https://github.com/CachyOS/proton-cachyos)

# Usage

Add it to your inputs (flake.nix):

```nix
{
  inputs = {
    proton-cachyos.url = "github:Arsalan2356/proton-cachyos-flake";
  };
}
```

Then add it to your configuration:

```nix
# In your Steam configuration (e.g., configuration.nix or steam.nix)
programs.steam = {
  enable = true;
  extraCompatPackages = [
    inputs.proton-cachyos.packages.${system}.proton-cachyos
  ];
};
```

### In Steam, the name will look something like proton-cachyos-{version}-slr-x86_64_v3.

## Issues

For issues with games or Proton itself, please report to:

[proton-cachyos](https://github.com/CachyOS/proton-cachyos) and [CachyOS Wiki](https://wiki.cachyos.org/) for CachyOS-specific issues

[Valve Proton](https://github.com/ValveSoftware/Proton) for general Proton issues

For issues with the flake itself (installation/detection issues), please open an issue here and provide as much information as possible.


## Contributing

If you want to contribute, feel free to open a PR and describe the changes you'd like to make (packaging, documentation, automation, etc.).



## Credits

This package is just a Nix flake wrapper around:

- [Proton-CachyOS](https://github.com/CachyOS/proton-cachyos) by the CachyOS team
- [Proton](https://github.com/ValveSoftware/Proton) by Valve Corporation

All credit for the underlying software goes to their respective teams. This repository simply provides the Nix packaging to make it easier to use on NixOS.

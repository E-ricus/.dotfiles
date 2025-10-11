
# Home Manager Configuration

This directory contains the Home Manager configuration for my dotfiles, managed with Nix.

## Structure

- `flake.nix`: The main entry point for the configuration, defining the Nix Flake.
- `hosts/`: Contains host-specific configurations.
  - `arch.nix`: Configuration for Arch Linux.
  - `mac.nix`: Configuration for macOS.
- `modules/`: Contains the configuration for different programs, organized by module.
- `common.nix`: Imports all the modules and defines common packages.

## Usage

To apply the configuration, you first need to symlink this directory to `~/.config/home-manager`:

```bash
ln -s /home/ericus/.dotfiles/home-manager ~/.config/home-manager
```

Then, you can apply the configuration using the following command, depending on your system:

For Arch Linux:

```bash
home-manager switch --flake .#ericus
```

For macOS:

```bash
home-manager switch --flake .#ericpuentes
```

## Integration with NixOS and nix-darwin

When you are ready to move to a full NixOS or nix-darwin setup, you can integrate this Home Manager configuration as follows:

### NixOS

In your `configuration.nix` file, you need to import the `home-manager` module and then import the user-specific configuration from this repository.

```nix
{
  imports = [
    # ... other imports
    <home-manager/nixos>
  ];

  # ... other configurations

  home-manager.users.ericus = import /path/to/your/dotfiles/home-manager/hosts/arch.nix;
}
```

### nix-darwin

Similarly, in your `darwin-configuration.nix` file:

```nix
{
  imports = [
    # ... other imports
    <home-manager/darwin>
  ];

  # ... other configurations

  home-manager.users.ericpuentes = import /path/to/your/dotfiles/home-manager/hosts/mac.nix;
}
```

After integrating, you can manage your system and home environment with a single command, for example `nixos-rebuild switch` on NixOS or `darwin-rebuild switch` on nix-darwin.

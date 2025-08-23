# Dotfiles

This repository contains the config files for the stuff I use (or have used).

## Usage

Clone the repository and use `stow` to symlink the files to the location.

> Except for `nixos`, which I have yet to figure out how to configure,
> everything else can be _stowed_.

```bash
stow <directory>
```

For example, to symlink the `fastfetch` config file, run:

```bash
stow fastfetch
```

> Note: The `stow` command should be run from the root of the repository.

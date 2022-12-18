A super minimal NixOS config for my home-server.

### [Code-server](https://github.com/msteen/nixos-vscode-server) to use the VSCode IDE through SSH

After rebuilding, enable the service with `systemctl --user enable auto-fix-vscode-server.service` and reboot.

### [Postgres](https://nixos.wiki/wiki/PostgreSQL), because I'll probably want it eventually.

To access via psql: `sudo -u postgres psql`


# References:

* [MatthiasBenaets/nixos-config](https://github.com/MatthiasBenaets/nixos-config)
* [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
* [Nix from First Principles: Flake Edition](https://tonyfinn.com/blog/nix-from-first-principles-flake-edition/)

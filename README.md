# Rocky Linux Compatibility Setup for FreeBSD

This project provides a script to set up compatibility for running Rocky Linux applications on FreeBSD. It includes a **Makefile** for streamlined installation and uninstallation of the script.

## Features

- Simplifies the setup of Linux compatibility on FreeBSD.
- Provides a script for configuring the necessary compatibility settings.
- Includes a **Makefile** for easy installation and removal.

## Prerequisites

- FreeBSD 14 or later.
- Superuser (root) privileges to install and configure compatibility settings.
- Ensure the `linux_enable` option is set in `/etc/rc.conf` if required.

## Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/vimanuelt/Rocky_Linux_Compatibility_Setup_for_FreeBSD.git
   cd Rocky_Linux_Compatibility_Setup_for_FreeBSD
   ```

2. Install the script using `make`:

   ```sh
   sudo make install
   ```

   By default, the script will be installed to `/usr/local/sbin/rocky_compat_setup`.

## Usage

Run the script to set up compatibility:

```sh
sudo setup_linux_compatibility.sh
```

Follow the on-screen instructions to configure Rocky Linux compatibility on your FreeBSD system.

### Accessing a Rocky Linux Bash Shell

Once installed and configured, you can access a bash shell in the Rocky Linux compatibility environment by running:

```sh
sudo chroot /compat/linux /bin/bash
```

This provides a Linux environment within FreeBSD for testing or running Linux applications.

## Uninstallation

To remove the script:

```sh
sudo make uninstall
```

This will delete the installed script from `/usr/local/sbin`.

## Customization

The installation location can be customized by setting the `PREFIX` and `INSTALL_DIR` variables:

```sh
sudo make install PREFIX=/custom/path
```

Similarly, you can specify a custom destination during uninstallation:

```sh
sudo make uninstall DESTDIR=/custom/path
```

## Cleaning Up

The `clean` target is a placeholder for future use. Currently, it does nothing:

```sh
make clean
```

## License

This project is licensed under the [MIT License](LICENSE).

## Contributions

Contributions, issues, and feature requests are welcome! Please open an issue or submit a pull request on [GitHub](https://github.com/vimanuelt/Rocky_Linux_Compatibility_Setup_for_FreeBSD).

## Author

Created by [Vimanuelt](https://github.com/vimanuelt). Contributions by the FreeBSD and Linux communities.

---

**Note:** This script is provided as-is and should be tested in a non-production environment before deployment.
```

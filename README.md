# Rocky Linux Compatibility Setup for FreeBSD

This script automates the setup of Linux compatibility on FreeBSD using the Rocky Linux 9 base system (`linux-rl9`). It installs necessary packages, enables Linux compatibility, and configures the system to run Linux applications.

## Prerequisites

- **FreeBSD** system with root access.
- **Internet connection** to fetch packages.

## Usage

```sh
sh setup_linux_compatibility.sh [-v] [-d]
```

Options

    -v - Verbose mode: Print more information about what the script is doing.
    -d - Dry run: Show what would be done without making any changes to the system.


Installation

    Download or copy this script to your FreeBSD machine.
    Make the script executable with:
    sh

    chmod +x setup_linux_compatibility.sh

    Run the script as root:
    sh

    sudo ./setup_linux_compatibility.sh

    or directly as root:
    sh

    ./setup_linux_compatibility.sh


What This Script Does

    Updates the system (pkg update and pkg upgrade).
    Enables Linux compatibility (sysrc linux_enable="YES" and service linux start).
    Installs linux_base-rl9 and additional libraries for better compatibility.
    Checks and adds necessary mount points in /etc/fstab.
    Recommends a system reboot for changes to take effect.


Notes

    Compatibility: This setup has been tested with FreeBSD versions where Linux compatibility for RL9 works well, but you might encounter issues with older versions of FreeBSD.
    Reboot: After running this script, it's highly recommended to reboot your system to ensure all changes are properly applied.


Troubleshooting

    If you encounter issues with package installation, ensure your package repository is up to date or check if there are known issues with the specific linux-rl9 packages.
    For errors related to system calls or missing libraries when running Linux applications, consider installing additional Linux packages as needed.


License
This script is under the MIT License. See LICENSE for more details.

Contributing
Pull requests or issues are welcome if you encounter problems or have suggestions for improvements. Please follow the existing code style and comment any changes you make.

Acknowledgements
Thanks to the FreeBSD community for their extensive documentation on Linux compatibility, which was invaluable in creating this script.

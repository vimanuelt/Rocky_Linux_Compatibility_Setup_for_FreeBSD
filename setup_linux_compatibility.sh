#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

VERBOSE=false
DRY_RUN=false
while getopts "vnd" opt; do
    case ${opt} in
        v ) VERBOSE=true ;;
        d ) DRY_RUN=true ;;
    esac
done
shift $((OPTIND -1))

if $DRY_RUN; then
    echo "Dry run mode: No changes will be made."
fi

if ! $DRY_RUN; then
    if $VERBOSE; then
        echo "Updating system..."
    fi
    pkg update
    pkg upgrade -y
else
    echo "Would update system."
fi

if ! $DRY_RUN; then
    if $VERBOSE; then
        echo "Enabling Linux compatibility..."
    fi
    if ! sysrc linux_enable="YES" >/dev/null 2>&1; then
        echo "Failed to enable Linux compatibility in rc.conf."
        exit 1
    fi
    if ! service linux start >/dev/null 2>&1; then
        echo "Failed to start Linux compatibility service."
        exit 1
    fi
    if $VERBOSE; then
        echo "Linux compatibility enabled."
    fi
else
    echo "Would enable Linux compatibility."
fi

if ! pkg info -e linux_base-rl9 >/dev/null 2>&1; then
    if ! $DRY_RUN; then
        if $VERBOSE; then
            echo "Installing linux_base-rl9..."
        fi
        if ! pkg install -y linux_base-rl9; then
            echo "Failed to install linux_base-rl9."
            exit 1
        fi
    else
        echo "Would install linux_base-rl9."
    fi
else
    if $VERBOSE; then
        echo "linux_base-rl9 already installed."
    fi
fi

for package in linux-rl9-xorg-libs linux-rl9-wayland linux-rl9-libglvnd linux-rl9-libsndfile linux-rl9-alsa-lib linux-rl9-pulseaudio-libs linux-rl9-opus linux-rl9-dri; do
    if ! pkg info -e "$package" >/dev/null 2>&1; then
        if ! $DRY_RUN; then
            if $VERBOSE; then
                echo "Installing $package..."
            fi
            if ! pkg install -y "$package"; then
                echo "Failed to install $package."
                exit 1
            fi
        else
            echo "Would install $package."
        fi
    else
        if $VERBOSE; then
            echo "$package already installed."
        fi
    fi
done

check_fstab_line() {
    local line=$1
    if ! grep -qxF "$line" /etc/fstab; then
        if ! $DRY_RUN; then
            echo "$line" >> /etc/fstab
            echo "Added: $line"
        else
            echo "Would add: $line"
        fi
    else
        echo "Already exists: $line"
    fi
}

check_fstab_line "linprocfs  /compat/linux/proc  linprocfs  rw  0   0"
check_fstab_line "tmpfs       /compat/linux/dev/shm tmpfs  rw,mode=1777  0  0"

if ! $DRY_RUN; then
    mount -a
else
    echo "Would mount all new filesystems."
fi

echo "Linux compatibility setup completed. A reboot is recommended."
if ! $DRY_RUN; then
    read -p "Do you want to schedule a reboot now? (yes/no): " ans
    if [ "$ans" = "yes" ] || [ "$ans" = "y" ]; then
        shutdown -r now
    fi
else
    echo "Would suggest scheduling a reboot."
fi

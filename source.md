```bash
#!/bin/bash
# Script Title: Arch Linux KDE Plasma & Utility Installer
# Description: Installs SDDM, KDE Plasma (X11/Wayland), and a comprehensive set of essential
# utilities and development tools specifically for an Arch Linux installation.

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e
sudo pacman -Rdd --noconfirm linux-firmware && run0 pacman -Syu linux-firmware
# Hardcode package manager and distro since this is Arch-exclusive
DISTRO="Arch Linux"
PKG_MANAGER="pacman"

# --- Package Lists for Arch Linux ---

# 'xorg' is the base X server needed for the X11 session.
# NOTE: 'plasma' is installed separately in the main execution to allow for user-requested echo messages.
DE_PACKAGES="sddm xorg"

# List of utilities to be installed in a single, efficient pacman command.
UTILITY_BULK_PACKAGES="base-devel \
    git \
    curl \
    wget \
    htop \
    neofetch \
    unarchiver \
    p7zip \
    gparted \
    firefox \
    vlc \
    libreoffice-fresh \
    power-profiles-daemon \
    zip \
    unzip \
    nautilus \
    npm"


# --- Utility Functions ---

# Function to ask for user confirmation
confirm_install() {
    read -r -p "Do you want to proceed with the installation on $1? (Y/n): " response
    case "$response" in
        [yY][eE][sS]|[yY]|"")
            true
            ;;
        *)
            false
            ;;
    esac
}

# Function to install packages using pacman
install_packages() {
    local packages="$1"
    echo "Starting bulk installation of: $packages"

    # Synchronize package database and install packages
    # -S: Synchronize (install), --needed: skip if already installed, --noconfirm: automatic confirmation
    echo "Synchronizing pacman database and installing packages..."
    sudo pacman -Sy --needed --noconfirm $packages
}

# Function to enable and start the Display Manager (SDDM)
enable_sddm() {
    echo "Attempting to enable and start SDDM service using systemd..."
    
    if command -v systemctl &> /dev/null; then
        # Disable any conflicting Display Managers (if they somehow exist)
        echo "Disabling potential conflicting display managers..."
        for dm in gdm lightdm lxdm; do
            if systemctl is-enabled --quiet $dm.service 2>/dev/null; then
                sudo systemctl disable $dm.service
                echo "Disabled $dm."
            fi
        done
        
        # Enable and start SDDM
        sudo systemctl set-default graphical.target
        sudo systemctl enable sddm
        echo "SDDM enabled. Starting SDDM now."
        # Attempt to start the service immediately, otherwise a reboot is needed
        sudo systemctl start sddm
        echo "SDDM should be running now. You must reboot your system to fully switch to the SDDM login screen."
    else
        echo "systemctl not found. SDDM must be manually configured to start on boot."
    fi
}

# --- Main Execution ---

echo "--- Arch Linux KDE Plasma & Utility Installer Script ---"

    # 2. System Update and Firmware Refresh
    echo ""
    echo "--- Phase 2: System Update and Critical Package Refresh ---"
    
    # Reinstall linux-firmware (Replaced 'run0' with 'sudo pacman' for standard execution)
    sudo pacman -Rdd --noconfirm linux-firmware && sudo pacman -Syu linux-firmware
    
    # Perform a full system update
    sudo pacman -Syu --noconfirm
    
    # Re-run firmware fix (Duplicate command requested by user)
    sudo pacman -Rdd --noconfirm linux-firmware && sudo pacman -Syu linux-firmware
    
    # 3. Essential & Optional Application Installation (Respecting user's messages)
    echo ""
    echo "--- Phase 3: Installing Desktop Environment and Utilities ---"

    echo "You will need to do Y/N for packages, don't say yes to all, a lot are optional applications you may not want!"
    echo "Essential applications will be installed without prompt, so don't worry."
    
    # Install nano
    sudo pacman -S nano 
    
    # Install Plasma (DE)
    echo "Plasma is a popular desktop interface, highly customizable and is highly recommended to use!"
    echo "Plasma, while recommended, is not essential."
    sudo pacman -S plasma

    # Install apt (Highly discouraged on Arch, but included as requested)
    echo "'apt' package is not recommended for Arch Linux unless you know how to PROPERLY set it up."
    sudo pacman -S apt

    # Install Kitty Terminal
    echo "Kitty Terminal is recommended"
    sudo pacman -S kitty
    
    # Install all other utilities in one efficient step
    install_packages "$UTILITY_BULK_PACKAGES"

    # Install SDDM and Xorg
    install_packages "$DE_PACKAGES" 

    # 4. Enable SDDM and Cleanup
    echo ""
    echo "--- Phase 4: Configuring SDDM and Cleanup ---"
    
    # Enable SDDM
    enable_sddm

    # Cleanup the downloaded script file (Corrected from pacman -R to rm)
    sudo rm archcaine-setup.sh
    echo "Removed archcaine-setup.sh file."

    echo ""
    echo "--------------------------------------------------------"
    echo "Installation Complete!"
    echo "The essential software has been installed and configured."
    echo ">>> IMPORTANT: Please REBOOT your system NOW for the new Display Manager (SDDM) and desktop environment to load correctly. <<<"
    echo "--------------------------------------------------------"

else
    echo "Installation cancelled by the user."
fi

# --- End of Main Execution ---
```
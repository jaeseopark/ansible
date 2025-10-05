
## Mac hosts

### Setting up a new M series machine

1. Set the username to `jaeseopark`.
1. Connect to internet, and remember to give a unique hostname ex. "atlas"
1. Copy the private key from the old machine, probably via AirDrop.
1. Enable remote access
    ```bash
    # Start SSH server
    sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
    mkdir ~/.ssh
    mv ${pem_path} ~/.ssh
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/authorized_keys
    ```
1. Install brew:
    ```bash
    # Pre-req:
    xcode-select --install
    # Then follow the instructions on 
    ```
1. Install cask apps
    ```bash
    # Forklift v3.5.8 -- Ansible does not allow installing of older versions.
    brew install --cask https://raw.githubusercontent.com/Homebrew/homebrew-cask/aa461148bbb5119af26b82cccf5003e2b4e50d95/Casks/f/forklift.rb
    ```
1. Install Ansible
    ```bash
    # Mac (bash)
    pip3 install ansible

    # Show where Ansible is installed
    pip3 show ansible | grep Location
    # Location: /Users/jaeseopark/Library/Python/3.9/lib/python/site-packages

    # Add the bin directory to PATH in ~/.bash_profile
    # export PATH=$PATH:/Users/jaeseopark/Library/Python/3.9/bin

    ansible-galaxy collection install ansible.posix # Needed for the nas playbook
    ```
1. Log into iCloud
1. Install App Store apps:
    * Bitwarden (+ Safari extension)
    * Magnet
    * Infuse
    * Keepa (Safari Extension)
    * Userscripts (Safari Extension)

#### Automation TODO

* Enable location services
* Turn off iMessage automatic sharing
* Disable Exposé on clicking desktop
* Point to the self hosted DNS Server
* Apps to install & configure:
    * Logitech Options +
* Automate importing of userscripts in safari
* Keyboard layouts: US english, Korean
    * keyboard: disable smart quotes
    * hotkey to switch languages: Command + quote
* ignore caps lock
* Enable firewall
* Disable 'focus' mode
* enable accessiblity zoom: Ctrl + mouse wheel
* show tray icons:
    * Wifi
    * BT
    * Airdrop
    * Screen mirroring
    * Sound
* spotlight search scope:
    * apps
    * calc
    * conversion
    * definition
    * system settings
* Bash
    * set default terminal to bash
    * Bash profile
    * or find another shell program that is good & automatable.
* Chrome
    * Enable the Remote Torrent Adder extension and register the torrent host.
* add custom size print paper settings
* pycharm light theme

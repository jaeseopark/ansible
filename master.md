# master

## Setting up a new machine

1. Connect to internet
1. Set the username to `jaeseopark`
1. Preferences - Sharing
    1. Give a single-word hostname ex. "atlas"
    1. Enable Remote Login (SSH)
    1. `mkdir ~/.ssh`
    1. Copy ssh pem file(s)
    1. Create `authorized_keys` by running:
        ```bash
        ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/authorized_keys
        ```
1. Run:
    ```bash
    xcode-select --install
    ```
1. Install https://brew.sh
1. Log into iCloud
1. Install App Store apps:
    * Bitwarden (+ Safari extension)
    * Magnet
    * Infuse
    * Keepa (Safari Extension)
    * Userscripts (Safari Extension)
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

## Automation TODO

* Bash profile
* Enable location services
* Turn off iMessage automatic sharing
* Disable Exposé on clicking desktop
* Point to the self hosted DNS Server
* Apps to install & configure:
    * Forklift 3 -- how to specify a specific version?
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
* set default terminal to bash

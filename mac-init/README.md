## Manual Steps

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

## TODO:

* Bash profile
* Disable spotlight search index
* Enable location services
* Turn off iMessage automatic sharing
* Hide application dock and change animation delay to 0ms. move it to the left
* Disable Exposé on clicking desktop
* Point to the self hosted DNS Server
* Show Safari favourite bar
* Repeated keyboard input delay
* Apps to install & configure:
    * Forklift 3 -- how to specify a specific version?
    * Logitech Options +
* Automate importing of userscripts in safari

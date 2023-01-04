## Headless Image Setup w/ cloud-init

https://github.com/timebertt/pi-cloud-init

|Control Node|Target Node|
|---|---|
|Debian 5.10.46-4 (2021-08-03) x86_64|Model 4 B Rev 1.4|

### Usage

1. Prep the image
    ```bash
    sudo ./prep_image.sh
    # ...
    # Image is ready: 2021-05-10-raspios-buster-armhf-lite-cloud-init.img
    ```
1. Write the resulting image to an SD card
    ```bash
    sudo /sbin/fdisk -l | grep SANDISK
    # ... /dev/sdb
    dd if=*.img of=/dev/sdb
    ```

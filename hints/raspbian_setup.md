# Set up a Raspbian SD card

```
# On Ubuntu MATE 18.04, for RPi3B, it went like this...
# Insert the SD card; Confirm which device, for example mmcblk0.
umount /media/$USER/*
dd if=./raspbian.img of=/dev/mmcblk0 bs=4m conv=sync
# Remove and re-insert the SD card.
myNewIP=192.168.99.216/24
myNewHostname=rpic1
sudo touch /media/$USER/mmcblk0p1/ssh
sudo tee -a /media/$USER/mmcblk0p2/etc/dhcpcd.conf <<EOM
interface eth0
inform $myNewIP
static routers=192.168.99.1
EOM
sudo tee /media/$USER/mmcblk0p2/etc/hostname <<EOM
$myNewHostname
EOM
# Configure gpu_mem to minimum 16MB:
# https://www.raspberrypi.org/documentation/configuration/config-txt/memory.md
umount /media/$USER/*
```

# Secure Raspbian

Change `pi` password:

    # echo "pi:$(tr -cd '[:alnum:]' </dev/urandom | head -c 32)" > ~pi/.random_pass
    # chpasswd <~pi/.random_pass

Create an admin user other than `pi` (for example, `USER`):

    # adduser --disabled-password --gecos "" USER
    # adduser USER sudo
    # echo "USER:$(tr -cd '[:alnum:]' </dev/urandom | head -c 32)" > ~USER/.random_pass
    # chpasswd <~USER/.random_pass
    # # Populate ~USER/.ssh/authorized_keys

- Require password for `sudo`? Configure /etc/sudoers and /etc/sudoers.d.
- Confirm the admin user can SSH in with a key.
- `sudo apt update && sudo apt upgrade`
- Schedule automatic updates of critical services. Maybe `cron-apt`?.
- Restrict access to the SSH server. In `/etc/ssh/sshd_config`:

    ```
    DenyUsers root pi
    AllowUsers USER
    LoginGraceTime 120
    StrictModes yes
    PermitRootLogin no
    PubkeyAuthentication yes
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    ```

- Install and configure a firewall?
- Install and configure `fail2ban`?
- Configure logging to an external drive or host.
- Consider enabling watchdog:
    https://raspberrypi.stackexchange.com/questions/1401/how-do-i-hard-reset-a-raspberry-pi


# Script

I tested this against current Raspbian on a Raspberry Pi 3 B, on 19 Dec 2018.

```
# Log in as pi, then `sudo su -` to become root.
if [ $(id -u) != 0 ]; then exit 1; fi
echo "pi:$(tr -cd '[:alnum:]' </dev/urandom | head -c 32)" > ~pi/.random_pass
chpasswd <~pi/.random_pass
adduser --disabled-password --gecos "" USER
adduser USER sudo
echo "USER:$(tr -cd '[:alnum:]' </dev/urandom | head -c 32)" > ~USER/.random_pass
chpasswd <~USER/.random_pass
# Haha look at this, if we sudo -u we don't need to chown. Did I write this?:
sudo -u USER -i -- mkdir -m 700 -p \$HOME/.ssh
sudo -u USER -i -- tee \$HOME/.ssh/authorized_keys <<EOM
SSH-KEY-GOES-HERE
EOM
tee -a /etc/ssh/sshd_config <<EOM
DenyUsers root pi
AllowUsers USER
LoginGraceTime 120
StrictModes yes
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
ChallengeResponseAuthentication no
EOM
sshd -t -f /etc/ssh/sshd_config
systemctl restart ssh.service
tee /etc/sudoers.d/010_USER-nopasswd <<EOM
USER ALL=(ALL) NOPASSWD: ALL
EOM
```

DISKIMG=./win10.img
WINIMG=./cd_images/en_windows_10_education_version_1511_updated_feb_2016_x64_dvd_8380184.iso
VIRTIMG=./cd_images/virtio-win-0.1.113.iso

# Enabling kvm and 4G RAM
OPTS="-enable-kvm -m 4096"

# Drive emulation
OPTS="$OPTS -drive file=$WINIMG,index=2,media=cdrom"
OPTS="$OPTS -drive file=$VIRTIMG,if=ide,index=1,media=cdrom"
OPTS="$OPTS -drive file=$DISKIMG,if=virtio,media=disk"

# CPU settings
OPTS="$OPTS -cpu host -smp cpus=1,cores=2,threads=4"

# Time settings
OPTS="$OPTS -rtc base=localtime,clock=host"

# Enables easy mouse inputs
OPTS="$OPTS -usbdevice tablet"


# Maps the rdp port to 8022 and disactivates gui
OPTS="$OPTS -redir :8022::3389"
#OPTS="$OPTS -nographic"
#OPTS="$OPTS -net user,hostfwd=tcp::5555-:3389"

# Network settings
OPTS="$OPTS -netdev user,id=vmnic -device virtio-net,netdev=vmnic"
#OPTS="$OPTS -net nic,model=virtio -net tap,ifname=tap0,script=no,downscript=no"

# command
qemu-system-x86_64 $OPTS

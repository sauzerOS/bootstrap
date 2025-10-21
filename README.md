# create bootstrap chroot in $LFS
- get latest hokuto release (github.com/sauzeros/hokuto) 
- build the bootstrap package: LFS=/mnt/lfs hokuto build --bootstrap bootstrap

# chroot into bootstrap and build final system
- hokuto chroot /mnt/lfs
- set final system target: HOKUTO_ROOT in /etc/hokuto.conf
- build system: hokuto build base-system


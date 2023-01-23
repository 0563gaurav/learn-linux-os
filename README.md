Operating system is optional thing. We can run program without os. These program called as self-Bootable or self-sufficient program.
If you want to try then follow 
step1:
type program as it in the image.
step2: fire command below
$ nasm -f bin ./boot.nasm -o boot.bin 
step3: make your usb bootable using below command
$ sudo dd if=./boot.bin of=/dev/sd<x> // replace x with device name
step 4: test on qemu
$ sudo qemu-system-x86_64 /dev/sd<x>
reboot your system and go to boot menu and select appropriate usb device to boot from.

PATH=$PATH:/home/alvan/opt/cross/bin
i686-elf-gcc -c src/kernel.c -o output/kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti || exit 1
i686-elf-gcc -T src/linker.ld -o chinar_os.bin -ffreestanding -O2 -nostdlib output/boot.o output/kernel.o -lgcc
if grub-file --is-x86-multiboot chinar_os.bin; then
    echo multiboot confirmed
else
    echo The file is not multiboot confirmed
fi

# mkdir -p isodir/boot/grub
mv chinar_os.bin isodir/boot/chinar_os.bin
# cp grub.cfg isodir/boot/grub
grub-mkrescue -o chinar_os.iso isodir
qemu-system-i386 -cdrom chinar_os.iso
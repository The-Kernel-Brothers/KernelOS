#make folders
mkdir -p obj
mkdir -p build

#assemble boot.s file
as --32 ./src/boot.s -o ./obj/boot.o

#compile kernel.c file
gcc -m32 -c ./src/kernel.c -o ./obj/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
ld -m elf_i386 -T ./linker.ld ./obj/kernel.o ./obj/boot.o -o ./build/KernelOS-i386.bin -nostdlib

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot ./build/KernelOS-i386.bin

#building the iso file
mkdir -p isodir/boot/grub
cp ./build/KernelOS-i386.bin isodir/boot/KernelOS-i386.bin
cp ./grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o ./build/KernelOS-i386.iso isodir

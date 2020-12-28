assemble:
nasm hello.asm -f bin -o boot_sect.bin

run:
qemu-system-x86_64 boot_sect.bin
qemu-system-x86_64 -drive file=boot_sect.bin,format=raw

hex viewer:
echo boot_sect.bin | xxd (-p)
hexedit boot_sect.bin


reference: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf

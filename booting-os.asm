; Doesn't work (I don't understand strings yet)
[org 0x7c00]

mov ah, 0x13

mov al, [my_string]
int 0x10

jmp $

my_string:
    db 'Booting OS',0

times 510-($-$$) db 0
dw 0xaa55
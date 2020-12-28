[org 0x7c00]

; BIOS stores our boot drive in DL, so it's best to remember this for later
mov [BOOT_DRIVE], dl ; In my case, it's 0x80 - 1st hdd
; mov dx, [BOOT_DRIVE]
; call print_hex

xor ax, ax
mov ss, ax
mov bp, 0x8000  ; Here we set our stack safely out of the
mov sp, bp      ; way, at 0x8000

mov bx, 0x0000
mov es, bx      ; 
mov bx, 0x9000  ; Load 5 sectors to 0x0000(ES):0x9000(BX)
mov dh, 2       ; from the boot disk.
; mov dh, 5     ; The book said to use 5 but hdd's don't allow reading past what exists except for floppies

mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

jmp $

%include "./print_string.asm"
%include "./print_hex.asm"
%include "./disk_load.asm"

; Global vars
BOOT_DRIVE: db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
; With following, S and F work. Without - T and F work
; Tells exactly where you expect the code to loade in memory
[org 0x7c00]
;
;   A simple boot sector program that demonstrates addressing
;

; int 10/ah = 0eh -> scrolling teletype BIOS routine
mov ah, 0x0e

; First attempt
mov al, 'F'
int 0x10
mov al, the_secret
int 0x10

mov al, 'S'
int 0x10
mov al, [the_secret]
int 0x10

mov al, 'T'
int 0x10
mov bx, the_secret
add bx, 0x7c00 ; Page 14 - Loaded Boot Sector location 
mov al, [bx]
int 0x10

; Fourth
mov al, 'F'
int 0x10
; mov al, [0x7c1e] ; From book
mov bx, 0x7c2f ; Page 14 - Loaded Boot Sector location
;add bx, 0x2f ; Where 'X' is in the bin
mov al, [bx]
int 0x10

jmp $

the_secret:
    db "X"

times 510-($-$$) db 0
dw 0xaa55
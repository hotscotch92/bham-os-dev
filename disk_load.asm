disk_load:
push dx

; xor ah, ah      ; drive reset
; int 0x13

mov ah, 0x02    ; int function - 0x02 is read
mov al, dh      ; # of sectors to read
mov ch, 0x00    ; cylinder number
mov dh, 0x00    ; head/platter #
mov cl, 0x02    ; Starting sector #
                ; Choosing 0x02 for after boot sector

int 0x13        ; sector r/w service

jc disk_error

pop dx
cmp dh, al
jne disk_error
ret

disk_error:
mov bx, DISK_ERROR_MSG
call print_string
mov dx, 0x00
mov dl, ah
call print_hex
jmp $

DISK_ERROR_MSG: db "Disk read error!", 0
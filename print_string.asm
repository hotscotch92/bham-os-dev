; Inputs: bx - string to be printed

print_string:
    pusha
print_string_loop: cmp byte [bx], 0
    je print_string_done
    mov al, [bx]
    mov ah, 0x0e
    int 0x10
    inc bx
    jmp print_string_loop
print_string_done: 
    mov al, [print_string_NEW_LINE] ; Moves cursor down
    mov ah, 0x0e
    int 0x10
    mov al, [print_string_CAR_RET]  ; Moves cursor to left
    mov ah, 0x0e
    int 0x10
    popa
    ret

print_string_NEW_LINE:
    db 0x0A
print_string_CAR_RET:
    db 0x0D
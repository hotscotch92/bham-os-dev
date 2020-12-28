; Inputs: dx - hex to be printed

print_hex:
    pusha
    mov cx, dx
    mov bx, print_hex_HEX_OUT
    call print_hex_print
    inc bx
    call print_hex_print
    inc bx
    mov al, 0x04 ; cur shft
    mov ah, 0x00 ; tmp shft
print_hex_loop: cmp byte [bx], 0
    je print_hex_done
    mov dx, cx
    call print_hex_find_mod
    cmp dl, 0x0A
    jl print_hex_mov_num
    add dl, 87
    mov [bx], dl
    jmp print_hex_done_move
print_hex_mov_num: add [bx], dl
print_hex_done_move:
    call print_hex_print
    inc bx
    dec al
    jmp print_hex_loop
print_hex_done: popa
    ret

; This prints one char at a time (issue with print string)
print_hex_print:
    pusha
    ; call print_string
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    popa
    ret

; dx: main al: mod by dx: returnValue
print_hex_find_mod:
    mov ah, al
print_hex_mov_left: cmp ah, 4
    je print_hex_mov_right
    shl dx, 4
    inc ah
    jmp print_hex_mov_left
print_hex_mov_right: cmp ah, 1
    je print_hex_ret_mod
    shr dx, 4
    dec ah
    jmp print_hex_mov_right
print_hex_ret_mod: ret

; global variables
print_hex_HEX_OUT:
    db '0x0000', 0
[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EDX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY   ; Set edx to the start of the vid mem

print_string_pm_loop:
    mov al, [ebx]           ; Store the char at EBX in AL
    mov ah, WHITE_ON_BLACK  ; Store the att's in AH

    cmp al, 0               ; if (all==0), at end of string, so
    je print_string_pm_done ; jump to done

    mov [edx], ax       ; Store char and att's at current
                        ; char cell
    add ebx, 1          ; Inc EBX to the next char in string
    add edx, 2          ; Move to next char ell in vid mem

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
BITS 16                  ; 16-bit code
ORG 0    ; Set the origin (memory address) to 0x1000

section .text
    global start

start:
    mov ah, 0   ; Set Video Mode sub-function
    mov al, 3   ; Video mode 3 (80x25 text mode)
    int 0x10    ; Call BIOS video interrupt
    mov ah, 0x0E    ; BIOS function to write a character to the screen
    mov al, '?'     ; ASCII code of the character to print
    int 0x10        ; Call the BIOS interrupt
    call Listen
    hlt

halt:
    jmp halt

Listen:
    mov ah, 0           ; Function code for keyboard input
    int 0x16            ; Call BIOS interrupt 0x16 to wait for input
    mov ah, 0x0E
    int 0x10
    cmp al, 13
    je Newline
    jmp Listen
Newline:
    mov ah, 0x0E
    mov al, 10
    int 0x10
    mov al, 13
    int 0x10
    mov al, '>'
    int 0x10
    call Listen
ret

times 510 - ($ - $$) db 0
dw 0xAA55
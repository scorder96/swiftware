BITS 16                  ; 16-bit code
ORG 0x7C00               ; Origin address for bootloader (standard boot sector address)

section .text
    start:
        mov si, msg
        call PrintStr
        call Prompt
        call Listen

        msg db "Welcome to Swift!", 13,10,0
        invalid db "INVALID", 13,10,0
        prompt db ">>>", 0
        newline db 13,10,0
        loaded db "Loaded...", 13,10,0
        
        ; Infinite loop to keep the bootloader running
        cli
        hlt
        jmp $

    Prompt:
        mov si, prompt
        call PrintStr
    ret
    Newline:
        mov ah, 0x0E
        mov al, 10
        int 0x10
        mov al, 13
        int 0x10
        call Prompt
        call Listen
    ret
    
    PrintStr:
        mov ah, 0x0E
        mov al, [si]
        psloop:
            int 0x10
            inc si
            mov al, [si]
            cmp al, 0
            jne psloop
        ret
    ret

    Listen:
        ; Wait for a key press
        mov ah, 0           ; Function code for keyboard input
        int 0x16            ; Call BIOS interrupt 0x16 to wait for input
        mov ah, 0x0E
        int 0x10
        cmp al, 'x'
        ;je Newline
        ;jmp Listen
        je Kernel
        jmp Listen
    ret
    Kernel:
        mov ah, 0x02    ; Function 2 - Read sectors
        mov al, 0x01       ; Number of sectors to read
        mov ch, 0x00       ; Cylinder number
        mov cl, 0x02
        mov dh, 0x00       ; Head number
        mov dl, 0x00       ; Drive number (0 for floppy)
        mov bx, 0x1000  ; Memory address to load the kernel (adjust as needed)
        mov bx, es
        int 0x13        ; BIOS interrupt for disk I/O
        mov si, loaded
        call PrintStr
        jc handle_error
        mov bh, 0
        jmp 0x1000:0x00
    handle_error:
        mov si, invalid   ; Function 0 - Set Video Mode
        call PrintStr   ; Video Mode 80x25 text mode
    ret


times 510-($-$$) db 0         ; Fill the rest of the boot sector with zeros
dw 0xAA55                     ; Boot signature to mark it as bootable

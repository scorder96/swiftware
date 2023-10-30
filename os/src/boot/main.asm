BITS 16                  ; 16-bit code
ORG 0x7C00               ; Origin address for bootloader (standard boot sector address)

start:
    mov si, msg
    call PrintStr
    mov si, next
    call PrintStr
    call Listen

Listen:
    mov ah, 0           ; Function code for keyboard input
    int 0x16            ; Call BIOS interrupt 0x16 to wait for input
    mov ah, 0x0E
    int 0x10
    cmp al, 13
    je boot
    jmp Listen

boot:
    mov ah, 0x02    ;Disk read mode
    mov al, 0x01    ;No of sectors to read (1)
    mov ch, 0x00    ;Cylinder no (0)
    mov cl, 0x02    ;Sector no (2) because sector 1 is boot sector
    mov dh, 0x00    ;Head no (0)
    mov dl, 0x00    ;Drive no (0)
    mov bx, 0x1000  ;Load here
    mov es, bx      ;es-extra segment, used to reach a higher no of memory loc, no need so es = 0+bx = 0x1000
    int 0x13
    jc error
    mov ah, 0x0e
    mov al, '$'
    mov bh, 0
    int 0x10
    jmp 0x1000:0x00

error:
    mov ah, 0x0e
    mov al, '!'
    mov bh, 0
    int 0x10
    hlt

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

msg db "Welcome to Swift!", 13,10,0
next db "Press ENTER to boot into kernel", 13,10,0

times 510-($-$$) db 0         ; Fill the rest of the boot sector with zeros
dw 0xAA55                     ; Boot signature to mark it as bootable
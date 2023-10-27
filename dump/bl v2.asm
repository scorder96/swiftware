BITS 16                  ; 16-bit code
ORG 0x7C00               ; Origin address for bootloader (standard boot sector address)

boot:
mov ah, 0x02
mov al, 0x01
mov ch, 0x00
mov cl, 0x02
mov dh, 0x00
mov dl, 0x00
mov bx, 0x1000
mov es, bx
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

times 510-($-$$) db 0         ; Fill the rest of the boot sector with zeros
dw 0xAA55                     ; Boot signature to mark it as bootable
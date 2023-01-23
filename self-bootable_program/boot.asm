BITS 16
ORG 0
_start:
	jmp short start
	nop
times 33 db 0
start:
	jmp 0x7c0:step2
step2:
	cli ; Clear inttrupts
	mov ax, 0x7c0
	mov ds, ax
	mov es, ax
	mov ax, 0x00
	mov ss, ax
	mov sp, 0x7c00
	sti ; Enable Intrrupts
	mov si, message
	call print

    ; code to read sector form disk
	mov ah, 03h   ; read sector command
	mov al, 1    ; one sector to read
	mov ch, 0    ; cylinder low eight bits
	mov cl, 2    ; read sector 2
	mov dh, 0    ; Head number
	mov bx, buffer
	int 0x13
    jc error

	; printing the read sector on the console
	mov si, buffer
	call print
	jmp $

error:
    mov si, error_msg
	call print
	jmp $


print:
	mov bx, 0
.loop:
	lodsb
	cmp al, 0
	je .done
	call print_char
	jmp .loop
.done:
	ret
print_char:
	mov ah, 0eh
	int 0x10
	ret
message: db 'Hello, World! Mr. Gaurav Gautam Shakya , How you are ?', 0
error_msg: db 'failed to load sector !', 0

times 510-($-$$) db 0
dw 0xaa55
buffer:
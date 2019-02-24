.model tiny
.code

X 		= 10
Y 		= 5
SWIDTH		= 60
SHEIGHT		= 10
VIDEO_SEG	= 0b800h
REDYEL		= 4eh
REDYELBL	= 0ceh
SCOLOR		= REDYEL
RCOLOR		= REDYEL
NUMBPOS		= (X + 31 + (Y + SHEIGHT/2 - 1 )* 80) * 2
NUMB		= 0feh

org 100h

start:		
include screen.asm

		mov bx, NUMBPOS
		mov ax, 0h
		mov al, NUMB
		mov cl, 0ah
drawnumb:	div cl
		mov dh, ah
		add dh, '0'
		mov ah, 0
		mov byte ptr es:[bx], dh
		mov byte ptr es:[bx+1], SCOLOR
		sub bx, 2
		cmp al, 0
		jne drawnumb

		mov ah, 0
		int 16h

		mov ax, 4c00h
		int 21h

end start


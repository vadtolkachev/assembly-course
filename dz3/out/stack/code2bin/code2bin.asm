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
NUMB		= 0f3e1h

org 100h

start:		call drawscreen
		call code2bin

		mov ax, 4c00h
		int 21h


code2bin	proc
		mov dh, SCOLOR
		mov bx, NUMBPOS
		mov ax, 0h
		mov ax, NUMB
calcnumb:	shr ax, 1
		mov dl, '0'
		jnc drawnumb
		inc dl
drawnumb:	mov word ptr es:[bx], dx
		;mov byte ptr es:[bx+1], SCOLOR
		sub bx, 2
		cmp ax, 0
		jne calcnumb

		mov ah, 0
		int 16h

		ret
		endp


include screen.asm


end start


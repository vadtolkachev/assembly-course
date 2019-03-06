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
NUMBPOS		= (X + 29 + (Y + SHEIGHT/2 - 1 )* 80) * 2
NUMB		= 3802d

org 100h

start:		call drawscreen
		call code2hex

		mov ax, 4c00h
		int 21h



code2hex	proc
		mov bx, NUMBPOS
		mov ax, NUMB
		mov dx, 0
drawnumb:	mov dh, al
		shr ax, 4
		and dh, 0fh
		add dh, '0'
		cmp dh, '9'
		jbe drawing
		add dh, 'a'-'9'-1

drawing:
		mov byte ptr es:[bx], dh
		mov byte ptr es:[bx+1], SCOLOR
		sub bx, 2
		cmp ax, 0
		jne drawnumb

draw0x:		mov byte ptr es:[bx], 'x'
		mov byte ptr es:[bx+1], SCOLOR
		sub bx, 2
		mov byte ptr es:[bx], '0'
		mov byte ptr es:[bx+1], SCOLOR

		mov ah, 0
		int 16h
		
		ret
		endp


include screen.asm


end start


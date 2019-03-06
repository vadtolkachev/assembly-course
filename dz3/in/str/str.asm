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
NUMBPOS		= (X + 24 + (Y + SHEIGHT/2 - 1 )* 80) * 2
NUMB		= 0f3e1h
SCAN_ENTER	= 1ch
MAX_NUMB_SIZE	= 16

org 100h

start:		call drawscreen

		sub sp, MAX_NUMB_SIZE + 2
		
		call bin2code
		
		mov bp, sp
		mov cl, [bp]
		mov ch, 0
		
		mov ax, 0
print_str:	mov bx, bp
		inc bx
		add bx, ax
		mov dl, [bx]
		mov dh, SCOLOR
		
		mov bx, NUMBPOS + 2*80
		add bx, ax
		add bx, ax
		mov word ptr es:[bx], dx
		
		inc ax
		loop print_str
		
		mov ah, 0	
		int 16h	
		

		mov ax, 4c00h
		int 21h
		
		
;------------------------------------------------------------------------
;------------------------------------------------------------------------
;procedures
;------------------------------------------------------------------------
;------------------------------------------------------------------------

;------------------------------------------------------------------------
;------------------------------------------------------------------------
;bin2code(char[MAX_NUMB_SIZE+2])
;Destr : ax, bx, cx
;------------------------------------------------------------------------
;------------------------------------------------------------------------
bin2code	proc
		push bp
		mov bp, sp
		
		mov dx, 0				;dx - counter
scan_cicle:	mov ah, 0	
		int 16h	

		cmp ah, SCAN_ENTER
		je scan_end
		
		mov bx, bp
		add bx, 5
		add bx, dx
		;mov [bx], 0
		mov byte ptr [bx], al
		
		mov bx, NUMBPOS
		add bx, dx
		add bx, dx
		inc dx
		
		mov ah, SCOLOR
		mov word ptr es:[bx], ax
		
		cmp dx, MAX_NUMB_SIZE
		jne scan_cicle

		
scan_end:	mov byte ptr [bp+4], dl
		pop bp
		ret
		endp


include screen.asm


end start


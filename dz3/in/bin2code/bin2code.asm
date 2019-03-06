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
SCAN_BACKSPACE	= 0eh
MAX_NUMB_SIZE	= 16

org 100h

start:		call drawscreen

		push ax
		call bin2code
		pop ax
		
		mov bx, NUMBPOS + 2*80 - 2
		add bx, dx
		add bx, dx
		inc ax
		call code2bin
		
		
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
;scans binary number
;Exit : [sp] - res, dx - size
;Destr : ax, bx, cx, dx
;------------------------------------------------------------------------
;------------------------------------------------------------------------
bin2code	proc
		push bp
		mov bp, sp
		
		mov cx, 0
		mov dx, 0				;dx - counter
scan_cicle:	mov ah, 0	
		int 16h	
		
		cmp ah, SCAN_ENTER
		je scan_end
		
		
scan_next:	shl cx, 1
		sub al, '0'
		mov ah, 0
		add cx, ax
		add al, '0'
		
		
		mov bx, NUMBPOS
		add bx, dx
		add bx, dx
		inc dx
		
		mov ah, SCOLOR
		mov word ptr es:[bx], ax
		
		cmp dx, MAX_NUMB_SIZE
		jne scan_cicle

		
scan_end:	mov [bp+4], cx
		pop bp
		ret
		endp
		
		
;------------------------------------------------------------------------
;------------------------------------------------------------------------
;prints binary numb
;Input : ax - numb, bx - position
;Destr : ax, bx, cx
;------------------------------------------------------------------------
;------------------------------------------------------------------------		
code2bin	proc
		mov dh, SCOLOR
calcnumb:	shr ax, 1
		mov dl, '0'
		jnc drawnumb
		inc dl
drawnumb:	mov word ptr es:[bx], dx
		sub bx, 2
		cmp ax, 0
		jne calcnumb

		ret
		endp


include screen.asm


end start


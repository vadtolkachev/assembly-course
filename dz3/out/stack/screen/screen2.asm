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
MSGPOS		= (X + 26 + (Y + SHEIGHT/2 - 1 )* 80) * 2

org 100h

start:		push SHEIGHT
		push SWIDTH
		push Y
		push X
		
		call drawscreen

		mov ax, 4c00h
		int 21h


;------------------------------------------------------------------------
;------------------------------------------------------------------------
;Draws screen
;Entry : x, y, width, height
;Destr : ax, bx, cx, dx, es
;------------------------------------------------------------------------
;------------------------------------------------------------------------
drawscreen	proc
		push bp
		mov bp, sp

		mov ax, VIDEO_SEG
		mov es, ax		; set video segment


		mov dx, 0
drawline:	mov cx, 0
		push dx
drawsymb:	
		
		;mov bx, (X + Y * 80) * 2
		mov ax, [bp+6]
		mov bx, 80d
		mul bx
		add ax, [bp+4]
		mov bx, 2
		mul bx
		mov bx, ax
		
		
		pop dx
		push dx
		
		add bx, cx
		add bx, dx
		
		mov byte ptr es:[bx],	' '
		mov byte ptr es:[bx+1], SCOLOR
	
	
		add cx, 2	
		mov bx, 2
		mov ax, [bp+8]
		mul bx
		cmp cx, ax
		jb drawsymb
		

		pop dx
		add dx, 2 * 80
		push cx
		push dx
		mov cx, dx
		
		mov bx, 2 * 80
		mov ax, [bp+10]
		mul bx
		cmp cx, ax
		pop dx
		pop cx
		jb drawline 
		
		
		push [bp+10]
		push [bp+8]
		push [bp+6]
		push [bp+4]
		call drawcorners
		add sp, 2*4
		
		call drawmsg
		call drawborders


		mov ah, 0
		int 16h

		pop bp
		ret
		endp


drawmsg		proc
		mov ax, 0
		mov cx, 0  
		mov bx, offset msg
		mov al, [bx]
drawlet:
		mov bx, cx
		add bx, cx
		;add bx, 80 * SHEIGHT		;middle
		add bx, MSGPOS
		mov byte ptr es:[bx], al
		mov byte ptr es:[bx+1], SCOLOR

		inc cx
		
		mov bx, offset msg
		add bx, cx
		mov al, [bx]
		cmp al, '$'
		jne drawlet
		
		ret 
		endp



drawborders	proc
		mov cx, 0
draw_up:	mov bx, cx
		add bx, (X + (Y - 1) * 80) * 2
		mov byte ptr es:[bx], 0cdh
		mov byte ptr es:[bx+1], RCOLOR

		add cx, 2
		cmp cx, 2 * SWIDTH
		jb draw_up


		mov cx, 0
draw_down:	mov bx, cx
		add bx, (X + (Y + SHEIGHT) * 80) * 2
		mov byte ptr es:[bx], 0cdh
		mov byte ptr es:[bx+1], RCOLOR

		add cx, 2
		cmp cx, 2 * SWIDTH
		jb draw_down


		mov cx, 0
draw_left:	mov bx, cx
		add bx, (X - 1 + Y * 80) * 2
		mov byte ptr es:[bx], 0bah
		mov byte ptr es:[bx+1], RCOLOR

		add cx, 2 * 80
		cmp cx, 2 * 80 * SHEIGHT
		jb draw_left


		mov cx, 0
draw_right:	mov bx, cx
		add bx, (X + SWIDTH + Y * 80) * 2
		mov byte ptr es:[bx], 0bah
		mov byte ptr es:[bx+1], RCOLOR

		add cx, 2 * 80
		cmp cx, 2 * 80 * SHEIGHT
		jb draw_right
		
		ret 
		endp



;------------------------------------------------------------------------
;------------------------------------------------------------------------
;Draws corners
;Entry : x, y, width, height
;Destr : ax, bx, cx
;------------------------------------------------------------------------
;------------------------------------------------------------------------
drawcorners	proc
		push bp
		mov bp, sp
		
		;mov bx, (X - 1 + (Y - 1) * 80) * 2
		mov ax, [bp+6]
		dec ax
		mov bx, 80d
		mul bx
		add ax, [bp+4]
		dec ax
		mov bx, 2
		mul bx
		mov bx, ax
		
		mov cl, 0c9h
		mov ch, RCOLOR
		call drawsymbol
		

		;mov bx, (X - 1 + (Y + SHEIGHT) * 80) * 2
		mov ax, [bp+6]
		add ax, [bp+10]
		mov bx, 80d
		mul bx
		add ax, [bp+4]
		dec ax
		mov bx, 2
		mul bx
		mov bx, ax		
		
		mov cl, 0c8h
		call drawsymbol
		

		;mov bx, (X + SWIDTH + (Y - 1) * 80) * 2
		mov ax, [bp+6]
		dec ax
		mov bx, 80d
		mul bx
		add ax, [bp+4]
		add ax, [bp+8]
		mov bx, 2
		mul bx
		mov bx, ax	
		
		mov cl, 0bbh
		call drawsymbol


		;mov bx, (X + SWIDTH + (Y + SHEIGHT) * 80) * 2
		mov ax, [bp+6]
		add ax, [bp+10]
		mov bx, 80d
		mul bx
		add ax, [bp+4]
		add ax, [bp+8]
		mov bx, 2
		mul bx
		mov bx, ax	
		
		mov cl, 0bch
		call drawsymbol

		pop bp

		ret
		endp
;------------------------------------------------------------------------
;------------------------------------------------------------------------
;Draws symbol
;Entry : bx - position, cl - symbol, ch - color
;------------------------------------------------------------------------
;------------------------------------------------------------------------
drawsymbol	proc

		mov word ptr es:[bx], cx		

		ret
		endp
;------------------------------------------------------------------------
;------------------------------------------------------------------------

.data
msg		db 'Hello$'

end start


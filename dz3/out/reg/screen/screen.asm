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

start:		mov ax, VIDEO_SEG
		mov es, ax		; set video segment


		mov dx, 0
drawline:	mov cx, 0
		
drawsymb:	mov bx, cx
		add bx, dx
		add bx, (X + Y * 80) * 2
		mov byte ptr es:[bx],	' '
		mov byte ptr es:[bx+1], SCOLOR
		
		add cx, 2 * 1		
		cmp cx, 2 * 1 * SWIDTH
		jb drawsymb
		
		add dx, 2 * 80
		cmp dx, 2 * 80 * SHEIGHT
		jb drawline 

		mov cx, 0  
		mov bx, offset msg
		mov al, [bx]


drawmsg:
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
		jne drawmsg


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


		mov bx, (X - 1 + (Y - 1) * 80) * 2
		mov byte ptr es:[bx], 0c9h
		mov byte ptr es:[bx+1], RCOLOR

		mov bx, (X - 1 + (Y + SHEIGHT) * 80) * 2
		mov byte ptr es:[bx], 0c8h
		mov byte ptr es:[bx+1], RCOLOR

		mov bx, (X + SWIDTH + (Y - 1) * 80) * 2
		mov byte ptr es:[bx], 0bbh
		mov byte ptr es:[bx+1], RCOLOR

		mov bx, (X + SWIDTH + (Y + SHEIGHT) * 80) * 2
		mov byte ptr es:[bx], 0bch
		mov byte ptr es:[bx+1], RCOLOR
		

		mov ah, 0
		int 16h

		mov ax, 4c00h
		int 21h

.data
msg		db 'Hello$'

end start


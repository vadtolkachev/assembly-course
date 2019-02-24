darwscreen:	mov ax, VIDEO_SEG
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



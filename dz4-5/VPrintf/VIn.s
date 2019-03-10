section .text

global VGetChar
global VGetBin
global VGetHex
global VGetDec

extern VMemSet


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VGetChar()
;Exit : al - char
;Destr : rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VGetChar:	push rsi
		push rdi
		
		push rax

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, 2
		syscall

		pop rax
		
		pop rdi
		pop rsi
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VGetBin()
;Exit : rax - numb
;Destr : rbx, rcx, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VGetBin:	push rsi
		push rdi
		
		sub rsp, 65

		mov rax, rsp			;memset(rsp, '\0', 65)
		push 65
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, 65
		syscall


		mov rax, 0
		mov rsi, rsp
gb_cicle:	shl rax, 1
		mov bl, 0
		mov bl, [rsi]
		sub bl, '0'
		add al, bl
		inc rsi
		cmp byte [rsi], 10
		jne gb_cicle



		add rsp, 65
		
		pop rdi
		pop rsi
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VGetHex()
;Exit : rax - numb
;Destr : rbx, rcx, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VGetHex:	push rsi
		push rdi
		
		sub rsp, 17

		mov rax, rsp			;memset(rsp, '\0', 17)
		push 17
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, 17
		syscall


		mov rax, 0
		mov rsi, rsp
gh_cicle:	shl rax, 4
		mov bl, 0
		mov bl, [rsi]
		sub bl, '0'
		cmp bl, 9
		jbe gh_next
		sub bl, 'a'-'9'-1

gh_next:	add al, bl
		inc rsi
		cmp byte [rsi], 10
		jne gh_cicle


		add rsp, 17
		
		pop rdi
		pop rsi
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VGetDec()
;Exit : rax - numb
;Destr : rbx, rcx, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VGetDec:	push rsi
		push rdi
		
		sub rsp, 21

		mov rax, rsp			;memset(rsp, '\0', 21)
		push 21
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, 21
		syscall


		mov rax, 0
		mov rsi, rsp
gd_cicle:	mov rdx, 10
		mul rdx
		mov bl, 0
		mov bl, [rsi]
		sub bl, '0'
		add al, bl
		inc rsi
		cmp byte [rsi], 10
		jne gd_cicle


		add rsp, 21
		
		pop rdi
		pop rsi
		ret
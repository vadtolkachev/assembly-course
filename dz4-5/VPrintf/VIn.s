section .text

global VGetChar
global VGetBin
global VGetHex
global VGetDec

extern VMemSet


BIN64_STRLEN	equ 64
HEX64_STRLEN	equ 16
DEC64_STRLEN	equ 20


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
		
		sub rsp, BIN64_STRLEN + 1

		mov rax, rsp			;memset(rsp, '\0', BIN64_STRLEN+1)
		push BIN64_STRLEN+1
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, BIN64_STRLEN+1
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



		add rsp, BIN64_STRLEN+1
		
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
		
		sub rsp, HEX64_STRLEN+1

		mov rax, rsp			;memset(rsp, '\0', HEX64_STRLEN+1)
		push HEX64_STRLEN+1
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, HEX64_STRLEN+1
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


		add rsp, HEX64_STRLEN+1
		
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
		
		sub rsp, DEC64_STRLEN+1

		mov rax, rsp			;memset(rsp, '\0', DEC64_STRLEN+1)
		push DEC64_STRLEN+1
		push 0
		push rax
		call VMemSet
		add rsp, 3*8

		mov rax, 0
		mov rdi, 0
		mov rsi, rsp
		mov rdx, DEC64_STRLEN+1
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


		add rsp, DEC64_STRLEN+1
		
		pop rdi
		pop rsi
		ret
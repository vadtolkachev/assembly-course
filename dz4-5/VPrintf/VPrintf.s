section .text

global VPrintf

extern VPrintBin
extern VPuts
extern VPutChar
extern VPrintHex
extern VPrintDec
extern VStrChr


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;prints format string with args, args can be %d, %x, %b, %c, %s, %%
;VPrintf(str, arg1, arg2, ..., argN)
;Destr: rax, rbx, rcx, rdx, r8, r9, r10
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPrintf:	push rbp
		mov rbp, rsp
		push rsi
		push rdi

		mov r8, rbp		;r8 - str index
		add r8, 2*8
		mov r8, [r8]

		mov r9, rbp		;r9 - arg index
		add r9, 2*8
					

pr_cicle:	mov rax, '%'		;-------------------------------------------------
		push rax		;-------------------------------------------------
		push qword r8		;--find %, print all before %, parse %, repeat,
		call VStrChr		;--if % not found - print string and ret
		add rsp, 2*8		;--
					;--
		cmp rbx, 0		;--
		je pr_end		;--
					;--
		sub rbx, r8		;--
					;--
		mov rdx, rbx		;--
		mov rax, 1		;--
		mov rdi, 1		;--
		mov rsi, r8		;--
		syscall			;--
					;--
		add r8, rdx		;--
		inc r8			;-------------------------------------------------
		mov rcx, [r8]		;-------------------------------------------------

		cmp cl, '%'
		je pr_proc

		cmp cl, 'd'
		je pr_dec

		cmp cl, 'x'
		je pr_hex

		cmp cl, 'b'
		je pr_bin

		cmp cl, 'c'
		je pr_char

		cmp cl, 's'
		je pr_str

		jmp pr_ret


pr_proc:	mov rax, 1
		mov rdi, 1
		mov rsi, r8
		mov rdx, 1
		syscall

		inc r8
		jmp pr_cicle


pr_dec:		add r9, 8
		push r8
		push qword [r9]
		call VPrintDec
		add rsp, 8
		pop r8

		inc r8
		jmp pr_cicle


pr_hex:		add r9, 8
		push qword [r9]
		call VPrintHex
		add rsp, 8

		inc r8
		jmp pr_cicle


pr_bin:		add r9, 8
		push qword [r9]
		call VPrintBin
		add rsp, 8

		inc r8
		jmp pr_cicle


pr_char:	add r9, 8
		push qword [r9]
		call VPutChar
		add rsp, 8

		inc r8
		jmp pr_cicle


pr_str:		add r9, 8
		push qword [r9]
		call VPuts
		add rsp, 8

		inc r8
		jmp pr_cicle


pr_end:		push qword r8
		call VPuts
		add rsp, 8



pr_ret:		pop rdi
		pop rsi
		pop rbp
		ret

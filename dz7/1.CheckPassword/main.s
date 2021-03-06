section .text


global _start
_start:		mov rax, 10

		push 1132

		sub rsp, 22

		push msg1
		call VPuts
		add rsp, 8

		push rsp
		call VGets
		add rsp, 8

		push rsp
		call VHashFunc
		add rsp, 8

		add rsp, 22

		cmp rax, [rsp]
		je v_success

		push msg3
		call VPuts
		add rsp, 8
		jmp v_end


v_success:	push msg2
		call VPuts
		add rsp, 8



v_end:		mov rax, 0x3c
		mov rdi, 0
		syscall



;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VHashFunc(buf_addr)
;Exit: rax - hash
;Destr: rbx, rcx, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VHashFunc:	push rbp
		mov rbp, rsp

		mov rax, 0
		mov rbx, [rbp + 2*8]

hf_cicle:	mov rcx, 0
		movzx rcx, BYTE [rbx]
		cmp rcx, 0
		je hf_end

		add rax, rcx
		inc rbx
		jmp hf_cicle
hf_end:		

		pop rbp
		ret

;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VGets(buf_addr)
;Destr: rax, rbx, rcx, rdx, rsi, rdi
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VGets:		push rbp
		mov rbp, rsp

		mov rbx, [rbp + 2*8]

gs_cicle:	mov rax, 0
		mov rdi, 0
		mov rsi, rbx
		mov rdx, 1
		syscall

		mov cl, [rbx]
		inc rbx

		cmp cl, 0xa
		je gs_end

		jmp gs_cicle
gs_end:		mov BYTE [rbx], 0

		pop rbp
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPuts(str_addr)
;Destr: rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPuts:		push rsi
		push rdi

		push qword [rsp+3*8]
		call VStrLen
		add rsp, 8

		mov rdx, rax
		mov rax, 1
		mov rdi, 1
		mov rsi, [rsp+3*8]
		syscall

		pop rdi
		pop rsi
		ret

;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VStrLen(str_addr)
;Exit : rax - strlen
;Destr : rbx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VStrLen:	mov rbx, [rsp+8]
		mov rax, 0

sl_cicle:	cmp byte [rbx], 0
		je sl_ret
		inc rbx
		inc rax
		jmp sl_cicle

sl_ret:		ret



;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VPrintDec(numb)
;Destr: rax, rbx, rcx, rdx, r8
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VPrintDec:	push rbp
		mov rbp, rsp
		push rsi
		push rdi
		
		sub rsp, 21			;char str[21]
		mov byte [rsp+20], 0		;str[20] = '\0'

		mov rax, rsp			;memset(str, '0', 20)
		push 20
		push '0'
		push rax
		call VMemSet
		add rsp, 3*8


		mov rax, [rbp+2*8]		;rbx = numb

		mov r8, rsp			;r8 = rsp+20
		add r8, 20
		mov rbx, 10
pd_cicle:	dec r8
		mov rdx, 0
		div rbx
		add byte [r8], dl
		cmp rax, 0
		jne pd_cicle


		push r8
		call VPuts
		add rsp, 8


		add rsp, 21

		pop rdi
		pop rsi
		pop rbp	
		ret


;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VMemSet(mem_addr, value, size) - value must be <= 0xff
;Destr : rax, rbx, rcx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VMemSet:	push rbp
		mov rbp, rsp

		mov rax, [rbp+2*8]	;mov rax, mem_addr
		mov rbx, [rbp+3*8]	;mov rbx, value
		mov rcx, [rbp+4*8]	;mov rcx, size

ms_cicle:	mov byte [rax], bl
		inc rax
		loop ms_cicle

		pop rbp
		ret

;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
;VEndl()
;Destr: rax, rdx
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
VEndl:		push rsi
		push rdi

		dec rsp
		mov byte [rsp], 0xa

		mov rax, 1
		mov rdi, 1
		mov rsi, rsp
		mov rdx, 1
		syscall

		inc rsp

		pop rdi
		pop rsi
		ret



section .data
msg1:		db "Введите пароль: ", 0xa, 0
msg2:		db "Правильно!", 0xa, ".∧＿∧", 0xa, "( ･ω･｡)つ━☆・*。", 0xa, "⊂　 ノ 　　　・゜+.", 0xa, "しーＪ　　　°。+ *´¨)", 0xa, "　　　　　　　　　.· ´¸.·*´¨) ¸.·*¨)", 0xa, "　　　　　　　　　　(¸.·´ (¸.·'* ☆0", 0xa, 0
msg3:		db "███████████▓▓▓▓▓▓▓▓▒░░░░░▒▒░░░░░░░▓█████", 0xa, "██████████▓▓▓▓▓▓▓▓▒░░░░░▒▒▒░░░░░░░░▓████", 0xa, "█████████▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒░░░░░░░░░▓███", 0xa, "████████▓▓▓▓▓▓▓▓▒░░░░░░░▒▒▒░░░░░░░░░░███", 0xa,"███████▓▓▓▓▓▓▓▓▒░░▒▓░░░░░░░░░░░░░░░░░███", 0xa,"██████▓▓▓▓▓▓▓▓▒░▓████░░░░░▒▓░░░░░░░░░███", 0xa,"█████▓▒▓▓▓▓▓▒░▒█████▓░░░░▓██▓░░░░░░░▒███", 0xa,"████▓▒▓▒▒▒░░▒███████░░░░▒████░░░░░░░░███", 0xa,"███▓▒▒▒░░▒▓████████▒░░░░▓████▒░░░░░░▒███", 0xa,"██▓▒▒░░▒██████████▓░░░░░▓█████░░░░░░░███", 0xa,"██▓▒░░███████████▓░░░░░░▒█████▓░░░░░░███", 0xa,"██▓▒░▒██████████▓▒▒▒░░░░░██████▒░░░░░▓██", 0xa,"██▓▒░░▒███████▓▒▒▒▒▒░░░░░▓██████▓░░░░▒██", 0xa,"███▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░███████▓░░░▓██", 0xa,"███▓░░░░░▒▒▒▓▓▒▒▒▒░░░░░░░░░██████▓░░░███", 0xa,"████▓▒▒▒▒▓▓▓▓▓▓▒▒▓██▒░░░░░░░▓███▓░░░░███", 0xa,"██████████▓▓▓▓▒▒█████▓░░░░░░░░░░░░░░████", 0xa,"█████████▓▓▓▓▒▒░▓█▓▓██░░░░░░░░░░░░░█████", 0xa,"███████▓▓▓▓▓▒▒▒░░░░░░▒░░░░░░░░░░░░██████", 0xa,"██████▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░▒▓████████", 0xa,"██████▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░▓██████████", 0xa,"██████▓▓▓▓▒▒██████▒░░░░░░░░░▓███████████", 0xa,"██████▓▓▓▒▒█████████▒░░░░░░▓████████████", 0xa,"██████▓▓▒▒███████████░░░░░▒█████████████", 0xa,"██████▓▓░████████████░░░░▒██████████████", 0xa,"██████▓░░████████████░░░░███████████████", 0xa,"██████▓░▓███████████▒░░░████████████████", 0xa,"██████▓░███████████▓░░░█████████████████", 0xa,"██████▓░███████████░░░██████████████████", 0xa,"██████▓▒██████████░░░███████████████████", 0xa,"██████▒▒█████████▒░▓████████████████████", 0xa,"██████░▒████████▓░██████████████████████", 0xa,"██████░▓████████░███████████████████████", 0xa,"██████░████████░▒███████████████████████", 0xa,"█████▓░███████▒░████████████████████████", 0xa,"█████▒░███████░▓████████████████████████", 0xa,"█████░▒██████░░█████████████████████████", 0xa,"█████░▒█████▓░██████████████████████████", 0xa,"█████░▓█████░▒██████████████████████████", 0xa,"█████░▓████▒░███████████████████████████", 0xa,"█████░▓███▓░▓███████████████████████████", 0xa,"██████░▓▓▒░▓████████████████████████████", 0xa,"███████▒░▒██████████████████████████████", 0xa,"████████████████████████████████████████", 0xa,"████████████████████████████████████████", 0xa, "Неправильно!", 0xa, 0

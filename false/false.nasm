global _start

section .text
_start:
	mov	rdi, 3
	mov	rax, 60
	syscall

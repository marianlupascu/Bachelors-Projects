#2. Verificaþi dacã numãrul stocat în registrul $t1 este pozitiv. Dacã da, puneþi 

#0 în registrul $t2, dacã nu, puneþi 1 în registrul $t2.

.data
	x:.word -5
.text
main:

lw $t1,x
li $t2,0

bgez $t1,sfarsit
li $t2,1

sfarsit:
li $v0,10
syscall
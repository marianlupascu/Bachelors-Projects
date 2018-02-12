#Verificaþi dacã un numãr dat este palindrom. Utilizaþi stiva.


.data
	nr:.word 0
	string: .asciiz "Dati numarul: "
	string1:.asciiz "Numarul este palindrom"
	string2:.asciiz "Numarul nu este palindrom"
.text
main:

la $a0, string
li $v0,4
syscall	

li $v0,5
syscall
sw $v0,nr
lw $t1,nr

subu $sp,$sp,4
sw $0,0($sp)

move $t2,$t1

loop:

	rem $s1,$t2,10
	subu $sp,$sp,4
	sw $s1,0($sp)
	div $t2,$t2,10
	bnez $t2,loop


comparare:
	lw $t0,0($sp)
	addu $sp,$sp,4
	rem $t3,$t1,10
	bne $t3,$t0,sfarsit1
	div $t1,$t1,10
	bnez $t1,comparare

li $v0,4
la $a0,string1
syscall

li $v0,10
syscall

sfarsit1:
	li $v0,4
	la $a0,string2
	syscall

	li $v0,10
	syscall
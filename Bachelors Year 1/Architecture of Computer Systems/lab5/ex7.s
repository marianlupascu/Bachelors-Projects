#5. Ordonaþi crescãtor un vector de numere întregi.




.data
	vector:.space 30
	n:.word 0
	string1:.asciiz "Dati n: \n"
	string2:.asciiz "Dati elementele vectorului: \n"
	string3:.asciiz "Elementele ordonate sunt: \n"
.text

citire:
	move $t1,$s1
	li $t2,0
	loop:
	addi $t2,1
	li $v0,5
	syscall
	sw $v0,vector($t0)
	addi $t0,4
	bne $t2,$t1,loop
	jr $ra

afisare:
	li $t2,0
	li $t0,0
	move $t1,$s1
	loop1:
	addi $t2,1
	lw $a0,vector($t0)
	li $v0,1
	syscall
	addi $t0,4
	bne  $t2,$t1,loop1
	jr $ra

sortare:
	li $t0,0
	mulo $t0,$s2,4
	move $t2,$s2
	move $t3,$s3
	move $t1,$s1
	loop3:
	beq $t2,$t1,end_loop3
	addi $t2,1
	lw $t4,vector($t0)
	move $t5,$t0
	addi $t0,4
	blt $t3,$t4,loop3
	sw $t3,vector($t5)
	sw $t4,vector($s0)
	b loop3	
	end_loop3:
	jr $ra

main:

li $v0,4
la $a0,string1
syscall

li $v0,5
syscall
sw $v0,n
lw $s1,n


li $v0,4
la $a0,string2
syscall


jal citire


li $s2,0
li $s0,0


loop2:
	addi $s2,1	
	lw $s3,vector($s0)
	jal sortare
	addi $s0,4
	bne $s2,$s1,loop2



li $v0,4
la $a0,string3
syscall


jal afisare

li $v0,10
syscall




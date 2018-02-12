#2. Se citesc de la tastatură:

#- un număr natural n;

#- un vector de n elemente, element cu element;

#Se cere:

#- o subrutina care sa calculeze factorialul unui număr;

#- folosind subrutina, să se determine suma factorialelor elementelor vectorului;

#- să se afişeze rezultatul la consolă.


.data
	vector:.space 100
	n:.word 0
	string1:.asciiz "Dati n:\n"
	string2:.asciiz "Dati elementele: \n"
.text

factorial:
	move $t0,$s3
	li $t1,1
	loop:
	mulo $t1,$t1,$s3
	sub $s3,1
	bnez $s3,loop
	move $v0,$t1
	jr $ra


main:

li $v0,4
la $a0,string1
syscall
li $v0,5
syscall
sw $v0,n

li $v0,4
la $a0,string2
syscall

lw $s1,n
li $s0,0
li $s2,0

citire:
	addi $s2,1
	li $v0,5
	syscall
	sw $v0,vector($s0)
	addi $s0,4
	bne $s2,$s1,citire

li $s2,0
li $s0,0
li $s4,0

calcul:
	addi $s2,1
	lw $s3,vector($s0)
	jal factorial
	add $s4,$s4,$v0
	addi $s0,4
	bne $s2,$s1,calcul

move $a0,$s4
li $v0,1
syscall

li $v0,10
syscall
	

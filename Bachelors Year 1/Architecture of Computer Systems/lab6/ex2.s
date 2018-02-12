#2. Se citesc de la tastatură:

#- un număr natural n;

#- un vector de n elemente, element cu element;

#- o putere p;

#Se cere:

#- o subrutină care să calculeze puterea p a unui număr;

#- folosind subrutina, să se determine suma puterilor p corespunzatoare

#elementelor vectorului;

#- să se afişeze rezultatul la consolă.


.data
	n:.word 0
	vector:.space 100
	p:.word 0
	string1:.asciiz "Dati n: \n"
	string2:.asciiz "Dati elementele: \n"
	string3:.asciiz "Dati puterea: \n"
.text

putere:
	move $t0,$s5
	move $t1,$s4
	li $t2,1
	loop:
	mulo $t1,$t1,$t1
	addi $t2,1
	bne $t2,$t0,loop
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
li $s0,0
lw $s1,n
li $s2,0

citire:
	addi $s2,1
	li $v0,5	
	syscall
	sw $v0,vector($s0)
	addi $s0,4
	bne $s2,$s1,citire

li $v0,4
la $a0,string3
syscall
li $v0,5
syscall
sw $v0,p


li $s0,0
li $s2,0
li $s3,0
lw $s5,p
lw $s1,n

calcul:
	addi $s2,1
	lw $s4,vector($s0)
	jal putere
	move $s6,$v0
	addi $s0,4
	add $s3,$s3,$s6
	bne $s2,$s1,calcul

li $s0,0
li $s2,0
lw $s1,n

li $v0,1
move $a0,$s3
syscall

li $v0,10
syscall


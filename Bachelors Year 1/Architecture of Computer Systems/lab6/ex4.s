#1. Se citesc de la tastatură:

#- un număr natural n;

#- o matrice pătratică n x n, element cu element;

#Se cere:

#- o subrutină care să calculeze suma elementelor de pe diagonala principală;

#- să se apeleze subrutina pentru matricea citită;

#- să se afişeze rezultatul la consolă;


.data
	matrice:.space 200
	n:.word 0
	string1:.asciiz "Dati n: \n"
	string2:.asciiz "Dati elementele:\n"
.text

calcul:
	lw $t1,n
	lw $t3,n
	li $t0,0
	li $t2,0
	addi $t3,1
	mulo $t3,$t3,4
	loop:
	mulo $t4,$t3,$t2
	lw $t0,matrice($t4)
	addi $t2,1
	add $t5,$t5,$t0
	bne $t2,$t1,loop
	move $v0,$t5
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
mulo $s1,$s1,$s1
li $s0,0
li $s2,0

citire:
	addi $s2,1
	li $v0,5
	syscall
	sw $v0,matrice($s0)
	addi $s0,4
	bne $s2,$s1,citire

jal calcul

move $a0,$v0
li $v0,1
syscall

li $v0,10
syscall

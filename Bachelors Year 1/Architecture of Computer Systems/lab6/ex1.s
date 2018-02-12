#1. Se citesc de la tastatură:

#- un număr natural n;

#- o matrice pătratică n x n, element cu element;

#- 2 numere 1 ≤l1, l2 ≤ n;

#Se cere:

#- sa se interschimbe în memorie elementele de pe liniile l1 şi l2.

# - să se afişeze rezultatul la consolă.



.data
	matrice:.space 400
	n:.word 0
	string1:.asciiz "Dati n: \n"
	string2:.asciiz "Dati elemetentele: \n" 
	string3:.asciiz "Dati prima linie: \n"
	string4:.asciiz "Dati a doua linie: \n"
	enter:.asciiz "\n"
	l1: .word 0
	l2: .word 0
.text

citire:
	move $t1,$s0
	li $t0,0
	li $t2,0
	loop:
	addi $t2,1 
	li $v0,5
	syscall
	sw $v0,matrice($t0)
	addi $t0,4
	bne $t2,$t1,loop
	jr $ra

afisare:
	move $t1,$s0
	li $t0,0
	li $t2,0
	li $t3,0
	lw $t4,n
	loop2:
	beq $t2,$t1,end_loop2
	li $v0,1
	lw $a0,matrice($t0)
	syscall
	addi $t0,4
	addi $t2,1
	addi $t3,1
	bne $t3,$t4,loop2
	li $v0,4
	la $a0,enter
	syscall
	li $t3,0
	b loop2
	end_loop2:
	jr $ra


	

interschimbare:
	lw $t0,n
	lw $t1,l1
	lw $t2,l2
	sub $t1,1
	sub $t2,1
	multu $t1,$t0
	mflo $t1
	multu $t2,$t0
	mflo $t2
	li $t3,4
	multu $t1,$t3
	mflo $t1
	multu $t2,$t3
	mflo $t2
	li $t5,0
	loop1:
	lw $t3,matrice($t1)
	lw $t4,matrice($t2)
	sw $t3,matrice($t2)
	sw $t4,matrice($t1)
	addi $t5,1
	addi $t1,4
	addi $t2,4
	bne $t5,$t0,loop1
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
lw $s0,n
mulo $s0,$s0,$s0
jal citire


li $v0,4
la $a0,string3
syscall
li $v0,5
syscall
sw $v0,l1


li $v0,4
la $a0,string4
syscall
li $v0,5
syscall
sw $v0,l2

jal interschimbare

lw $s0,n
mulo $s0,$s0,$s0

jal afisare 
        
li $v0,10
syscall

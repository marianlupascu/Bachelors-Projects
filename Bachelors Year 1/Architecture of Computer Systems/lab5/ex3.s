#1. Fie ºirul urmãtor definit recursiv: 

#a1 = 1; 

#a2 = 2; 

#an = 3*an-2 + an-1. 

#Determinaþi al 5-lea element al ºirului, folosind o subrutinã care primeºte 2 

#termeni consecutivi ºi întoarce urmãtorul element al ºirului.




.data
	string: .asciiz "an = ? , dati n: "
	x1:.word 1
	x2:.word 2
	n:.word 0
.text

calcul:
	move $t0,$a0
	move $t1,$a1
	mulo $t3,$t0,3
	add $t3,$t3,$t1
	move $v0,$t3
	jr $ra

main:

la $a0, string
li $v0,4
syscall

li $v0,5
syscall
sw $v0,n
lw $s0,n

lw $a0,x1
lw $a1,x2

sub $s0,$s0,2

loop:
	jal calcul
	move $a0,$a1
	move $a1,$v0
	sub $s0,$s0,1
	bnez $s0,loop

move $a0,$v0
li $v0,1
syscall

li $v0,10
syscall

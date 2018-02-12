#3. Se citesc de la consolã un numãr natural ºi o cifrã. Sã se afiºeze „Da” dacã 

#printre cifrele numãrului citit se gãseºte aceastã cifrã ºi „Nu” în caz 

#contrar.



.data
	string1: .asciiz "Dati numarul: "
	string2: .asciiz "Dati cifra: "
	nr:.word 0
	x:.word 0
	r1:.asciiz "DA"
	r2:.asciiz "NU"
.text

cauta:
	move $t1,$s1
	move $t0,$s0
	loop:
	rem $t2,$t0,10
	div $t0,$t0,10
	seq $t3,$t1,$t2
	bnez $t3,sfarsit
	bnez $t0,loop
	sfarsit:
	move $v0,$t3
	jr $ra	


main:


la $a0, string1
li $v0, 4
syscall

li $v0,5
syscall
sw $v0,nr
lw $s0,nr

la $a0, string2
li $v0, 4
syscall

li $v0,5
syscall
sw $v0,x
lw $s1,x

jal cauta

move $s2,$v0

bnez $s2,sfarsit1
beqz $s2,sfarsit2

sfarsit1:

la $a0,r1
li $v0,4
syscall

li $v0,10
syscall

sfarsit2:

la $a0,r2
li $v0,4
syscall

li $v0,10
syscall

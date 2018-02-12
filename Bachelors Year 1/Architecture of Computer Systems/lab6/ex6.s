#3. Se citesc de la tastatură:

#- un număr n;

#- un cuvânt de lungime maximă n care conţine numai majuscule (textul clar);

#- un număr k (cheia de criptare);

#Se cere:

#- o subrutină care sa întoarcă textul criptat corespunzător (fiecare literă este

#înlocuită cu litera aflată în alfabet peste k poziţii, considerând alfabetul circular: A

#> B > ... > Y > Z > A);

#- să se apeleze subrutina pentru şirul citit;

#- să se afişeze rezultatul la consolă;


.data
	string:.space 100
	n:.word 0
	k:.word 0
	string1:.asciiz "Dati n: \n"
	string2:.asciiz "Dati cuvantul de lungime n: \n"
	string3:.asciiz "Dati cheia de criptare: \n"
.text

criptare:
	li $t0,0
	lw $t3,k
	loop:
	lb $t1,string($t0)
	move $t2,$t1
	add $t1,$t1,$t3
	sb $t1,string($t0)
	addi $t0,1
	bnez $t2,loop
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

la $a0,string
li $v0,8
syscall

li $v0,4
la $a0,string3
syscall

li $v0,5
syscall
sw $v0,k


jal criptare

li $v0,4
la $a0,string
syscall


li $v0,10
syscall
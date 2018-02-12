#Se citesc de la tastatură:

#- un număr n;

#- un şir de caractere de lungime maxim n;

#Se cere:

#- o subrutina care să înlocuiască în memorie ‚a’ cu ‚A’ şi ‚A’ cu ‚a’;

#- să se apeleze subrutina pentru şirul citit;

#- să se afişeze rezultatul la consolă;

#ATENTIE: Eu am facut problema generala si imi defineam la inceput
# cele doua caractere care ar trebui inlocuite. 


.data
	n:.word 0
	string:.space 100
	string1:.asciiz "c"
	string4:.asciiz "C"
	string2:.asciiz "Dati n:\n"
	string3:.asciiz "Dati sirul de caractere:\n"

.text

inlocuire:
	li $t0,0
	lb $t2,string1($t0) # incarc in t2 c
	lb $t3,string4($t0) # incarc in t3 C
	li $t1,1
	loop:
	beqz $t1,end_loop #conditia de oprire in caz de se ajunge la sf sirului
	lb $t1,string($t0) #incarc in $t1 primul element din sir, iar la urmatoarea executare a buclei se va incarca al doilea...si tot asa
	move $t5,$t0 #salvez in t5 adresa primului element din sir(dupa fiecare bucla va deveni urmatorul) pentru a putea face inlocuirea 
	addi $t0,1  #trec la urmatorul element din sir
	bne $t1,$t2,loop1 # verific daca elementul din sir este egal cu c, iar daca nu, sar la loop1
	lb $t4,string($t5) #incarc in $t4 ce se  afla la adresa lui t5..in cazul nostru c
	sub $t4,32 #pentru a transforma c in C trebuie scazut  32 (ascii)
	sb $t4,string($t5) #pun pe adresa lui t5 din sir litera transformata
	b loop # reiau de la capat
	loop1:
	bne $t1,$t3,loop #verific daca elementul din sir este egal cu C
	lb $t4,string($t5) #incarc ce se afla la adresa lui $t5 in $t4
	addi $t4,32 #pentru a transforma C in c trebuie adunat 32
	sb $t4,string($t5) #si stochez C pe adresa lui $t5
	b loop
	end_loop:
	jr $ra
	
	


main:

li $v0,4
la $a0,string2
syscall
li $v0,5
syscall
sw $v0,n

li $v0,4
la $a0,string3
syscall

la $a0,string
li $v0,8
syscall

jal inlocuire

li $v0,4
la $a0,string
syscall	


li $v0,10
syscall
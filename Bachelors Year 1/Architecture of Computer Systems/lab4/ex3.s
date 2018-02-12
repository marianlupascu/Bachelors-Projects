#1. Declaraþi un ºir oarecare de caractere. Determinaþi lungimea ºirului, prin 

#parcurgerea ºi contorizarea locaþiilor de memorie, pânã când întâlniþi 

#caracterul delimitator de final.

.data
	string:.asciiz "ana are mere."
.text
main:

la $a0,string
li $t0,-1 #elimina caracterul final: 0

citire:
	lb $s1,($a0)
    addi $a0,1
    addi $t0,1
    bnez $s1, citire

li $v0,10
syscall

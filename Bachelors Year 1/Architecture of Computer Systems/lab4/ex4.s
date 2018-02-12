#2. Definiþi un vector de numere întregi de lungime cunoscutã. Determinaþi 

#suma elementelor pozitive din vector.

.data
	vector: .word 2 3 4 -2 1 -5
	n:.word 6
.text
main:

la $s0,vector
lw $t0,n
li $t1,1
li $t3,0

loop:
    beq $t0,$t1,end_loop
	addi $t1,1
	lw $t2, ($s0)
	addi $s0,4
    bltz $t2,loop
    add $t3,$t3,$t2
    b loop

end_loop:

li $v0,10
syscall
        
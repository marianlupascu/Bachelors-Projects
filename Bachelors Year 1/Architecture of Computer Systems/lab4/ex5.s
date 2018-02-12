#Sã se citeascã ºi sã se afiºeze un vector de n elemente întregi, unde n este introdus 

#de la tastaturã. Sã se afiºeze un meniu cu urmãtoarele opþiuni: 

#1. Suma elementelor; 

#2. Ultimul element; 

#3. Elementele mai mari decât n; 

#4. Ieºire din program. 

#La introducerea opþiunii 1, sã se afiºeze suma elementelor vectorului. 

#La introducerea opþiunii 2, sã se afiºeze ultimul element al vectorului; 

#La introducerea opþiunii 3, sã se afiºeze elementele mai mari decât n; 

#La introducerea opþiunii 4, sã se opreascã execuþia programului.







.data
	string1:.asciiz "Dati numarul de elemente ale vectorului.\n"
	string3:.asciiz "Dati elementele vectorului.\n"
	string2:.asciiz "Vectorul este: "
	alege:.asciiz "\n 1.Suma elementeleor;\n 2.Ultimul element; \n 3.Elementele mai mari decat n; \n 4.Iesire din program. \n "
	n:.word 0
	elem:.space 50
	x:.word 0
.text
main:

li $v0,4
la $a0,string1
syscall

li $v0,5
syscall
sw $v0,n
lw $t0,n

li $t1,0

la $t2,elem

li $v0,4
la $a0,string3
syscall

loop:
	beq $t0,$t1,end_loop
	addi $t1,1

	li $v0,5
	syscall

	sw $v0,($t2)
	lw $t5,($t2)
	add $t4,$t5,$t4
	addi $t2,4
	b loop

end_loop:
	


	li $v0,4
	la $a0,string2
	syscall

li $t1,0
la $t2,elem


loop_afisare:

	beq $t0,$t1,end_loop_afisare
	addi $t1,1

	lw $a0,($t2)
	li $v0,1
	syscall
	addi $t2,4
	b loop_afisare	

end_loop_afisare:

	li $t1,0
        la $t2,elem
	
	li $v0,4
	la $a0,alege
	syscall

	li $v0,5
	syscall
	sw $v0,x
	lw $t3,x
	beq $t3,1,suma
	beq $t3,2,ultimul
	beq $t3,3,loop_afisare_mai_mare
	beq $t3,4,sfarsit


suma:
	move $a0,$t4
	li $v0,1
	syscall
	b end_loop_afisare


ultimul:
	move $a0,$t5
	li $v0,1
	syscall
	b end_loop_afisare






loop_afisare_mai_mare:
      
	beq $t0,$t1,end_loop_afisare_mai_mare
	addi $t1,1
	lw $s1,($t2)
	addi $t2,4
	blt $s1,$t0,loop_afisare_mai_mare
	move $a0,$s1
	li $v0,1
	syscall
	b loop_afisare_mai_mare


end_loop_afisare_mai_mare:

     b end_loop_afisare

sfarsit:

li $v0,10
syscall
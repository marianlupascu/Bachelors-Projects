#1. Determinaþi dacã într-unul din regiºtrii $t1 - $t5 se gãseºte valoarea 7. 

#Dacã da, introduceþi valoarea 1 în registrul $t0. Dacã nu, introduceþi 

#valoarea 0 în registrul $t0.


.data
	x:.word 5
        y:.word 9
        z:.word 10
.text
main:

lw $t1,x
lw $t2,y
lw $t3,z

li $t0,1

beq $t1,7,sfarsit
beq $t2,7,sfarsit
beq $t3,7,sfarsit
li $t0,0


sfarsit:
li $v0,10
syscall
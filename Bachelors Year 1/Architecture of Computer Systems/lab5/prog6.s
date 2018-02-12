#4. Sã se determine dacã o matrice are numai elemente impare pe diagonala 

#principalã.


.data
n : .word 3
m : .word 3
matrice: .word 1 2 3 5 5 6 7 8 9
string1: .asciiz "Da"
string2: .asciiz "Nu"
.text
b main
subrutina:
lw $t0,n
lw $t1,m
la $t2,matrice
li $t3,0
li $t4,0
li $t5,1
loop:
li $t3,0
loop2:
bne $t3,$t4,pop
lw $t6,($t2)
rem $t6,$t6,2
bnez $t6,pop
li $t5,0 
pop:
add $t3,$t3,1
beq $t3,$t1,loop3
add $t2,$t2,4
b loop2
loop3:
add $t4,$t4,1
beq $t4,$t0,stop
b loop
stop:
move $v0,$t5
jr $ra
main:
jal subrutina
move $s0,$v0
li $s1,1
bne $s0,$s1,pam
li $v0,4
la $a0,string1
syscall
pam:
beq $s0,$s1,pa
li $v0,4
la $a0,string2
syscall
pa:
li $v0,10
syscall

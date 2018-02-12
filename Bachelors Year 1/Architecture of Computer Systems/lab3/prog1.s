#interschimba t1=1,t2=2
.data
.text

main:
li $t1,1
li $t2,2
move $t3,$t1
move $t1,$t2
move $t2,$t3
li $v0,10
syscall
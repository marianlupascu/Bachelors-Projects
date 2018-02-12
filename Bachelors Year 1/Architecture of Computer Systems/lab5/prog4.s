
#2. Determinaþi lungimea maximã a unei secvenþe de caractere repetitive 

#dintr-un ºir de caractere. De exemplu pentru ºirul „aaabbcdddee” se va 

#întoarce 3, fiindcã „aaa” ºi „ddd” au lungimea maximã, egalã cu 3.


.data
sir: .asciiz "ddddeeeaaaaa"
.text

main:
la $s0,sir
li $s1,0

loop:
la $a0,($s0)
jal max
move $s2,$v0
add $s0,$s0,$s2
bge $s1,$s2,salt
move $s1,$s2
salt:
lb $s4,($s0)
bnez $s4,loop

li $v0,10
syscall

max:
la $t0,($a0)
li $t1,0
loop2:
add $t1,$t1,1
lb $t2,($t0)
lb $t3,1($t0)
bne $t2,$t3,sar
add $t0,$t0,1
b loop2
sar:
move $v0,$t1
jr $ra


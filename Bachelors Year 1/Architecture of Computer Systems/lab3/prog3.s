#x,y,z-word,10,,11,12
#a)$t1=word x+4(doar cu x)
#b)stocati pe 2 octeti,la x+8 val 14
.data
x: .word 10
y: .word 11
z: .word 12
.text

main:
lw $t1,x+4
li $t2,14
sh $t2,x+8
li $v0,10
syscall
#t0=0x12345678.prin shiftare t2=0x091a2b3
.data

.text

.main:
li $t0,0x12345678
sll $t2, $t0,3
rol $t2,$t2,$t0
li $v0,10
syscall
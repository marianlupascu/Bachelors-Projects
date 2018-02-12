#t0=0x1234.prin shiftare t2=0x91a0
.data

.text

.main:
li $t0,0x1234
sll $t2, $t0, 3
li $v0,10
syscall
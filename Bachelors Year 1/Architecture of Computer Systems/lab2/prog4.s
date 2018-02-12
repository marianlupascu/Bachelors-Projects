#(x or y)and(not z)xor w
#x=t1,y=t2,z==t3,w=t4,rez=t5

.data

.text

.main:
or $t1,$t1,$t2
not $t3,$t3
and $t1,$t1,$t3
xor $t5,$t1,$t4

li $v0,10
syscall

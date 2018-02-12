#var3=8*var1-[var2/16],var1=16,var2=31
.data
var1: .word 16
var2: .word 31
var3: .word 0
.text
main:
lw $s1,var1
lw $s2,var2
mulo $s3,$s1,8
div $s4,$s2,16
sub $s3,$s3,$s4
sw $s3,var3
li $v0,10
syscall
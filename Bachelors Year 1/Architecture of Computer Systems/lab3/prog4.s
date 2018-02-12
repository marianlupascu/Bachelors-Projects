#x eticheta la care se mem 5,word
#x+4 valoarea pol f=2x^2-4x+12
.data
     x: .word 5
.text
   
  main:
lw $s1,x
mulo $s2,$s1,$s1
mulo $s2,$s2,2
mulo $s3,$s1,4
sub $s2,$s2,$s3
add $s2,$s2,12
sw $s2,x+4
li $v0,10
syscall
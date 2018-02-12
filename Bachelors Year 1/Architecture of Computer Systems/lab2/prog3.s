#in t3 punem valoarea modul(x-y)
#x=t1,y=t2
.data

.text

.main:
sub $t1,$t1,$t2
abs $t3,$t1
li $v0,10
syscall


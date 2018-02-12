#Sa se obtina in t3 valoarea
#[x/y]*{y/x},x in t1,y,in t2
#[]-catul,{}-restul
.data

.text

.main:
div $t1,$t2
mflo $t3
div $t2,$t1
mfhi $t2
mulo $t3,$t3,$t2
li $v0,10
syscall

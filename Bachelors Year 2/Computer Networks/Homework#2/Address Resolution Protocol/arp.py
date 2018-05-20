#ex no#2

from scapy.all import *

eth = Ether(dst = "ff:ff:ff:ff:ff:ff")
arp = ARP(pdst = '198.13.13.0/16')
answered, unanswered = srp(eth/arp)

print("Exists " + str(len(answered)) + " connexions:\n")
for i in range(0, len(answered)):
    print "IP:  " + answered[i][1].psrc + "   MAC:  " + answered[i][1].hwsrc
print("")

#../docker-compose exec rt1 bash
#python /elocal/rezolvare\ tema2/arp.py 


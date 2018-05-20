# inainte de toate trebuie adaugata o regula de ignorare 
# a pachetelor RST pe care ni le livreaza kernelul automat
# iptables -A OUTPUT -p tcp --tcp-flags RST RST -j DROP
from scapy.all import *
from struct import *
import sys

ip = IP()
ip.src = '198.13.0.15' #sursa      = mid1
ip.dst = '198.13.0.14' #destinatia = rt1
# int('DSCP_BINARY_STR' + 'ECN_BINARY_STR', 2)
ip.tos = int('011110' + '11', 2) #DSCP && ECN


tcp = TCP()
tcp.sport = 54321
tcp.dport = int(sys.argv[1])

optiune = 'MSS'
op_index = TCPOptions[1][optiune]
op_format = TCPOptions[0][op_index]
# print op_format
# ('MSS', '!H')
# Maximum Segment Size MSS = 2
valoare = struct.pack(op_format[1], 2)
tcp.options = [(optiune, valoare)]
# CWR + ECE
tcp.flags = 'EC'

## SYN ##
tcp.seq = 100
tcp.flags = 'S' # flag de SYN
raspuns_syn_ack = sr1(ip/tcp)

tcp.seq += 1
tcp.ack = raspuns_syn_ack.seq + 1
tcp.flags = 'A'
ACK = ip / tcp

send(ACK)

for ch in "he!":
    tcp.flags = 'PAEC'
    tcp.ack = raspuns_syn_ack.seq + 1
    print "Am trimis: " + ch
    rcv = sr1(ip/tcp/ch)
    #rcv
    tcp.seq += 1

tcp.flags='R'
RES = ip/tcp
send(RES)

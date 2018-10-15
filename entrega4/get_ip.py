import os
print("Welcome to Rapha`s target gdb arm server")

#Session to get targets ip with arp-scan command
mac_ad = input("Current board mac address: ")
print("Using Mac Address: {0}".format(mac_ad))
# print(f"Using Mac Address: {mac_ad}")
print("Getting ip of target, please ensure that your machine is in the same subnet as your pc and verify your mac address")
interface = input("Your network interface: ")
command = "sudo arp-scan --interface={0} --localnet | grep {1}".format(interface, mac_ad) #ens33-vm; en0-mac

#Getting output from arp-scan
output = str(os.popen(command).read())
ip = output.split('	', 1)[0]
print("If found, your target ip is: {0}".format(ip))

#Input the binary file which target will run
path = input("Please insert the complete path to your binary file: ")
print("path: {0}".format(path))

#Get port where gdb server is open at target
port = input("Insert gdb server port of target: ")

#Name of the file when transfering to target
name = path.split("/")[-1]

gdb_file = open("host_file.gdb", "w")
gdb_file.write("target extended-remote {0}:{1}\n".format(ip, port))
gdb_file.write("remote put {0} {1}\n".format(path, name))
gdb_file.write("set remote exec-file {0}\n".format(name))
gdb_file.write("run\n")

gdb_file.close()

# 192.168.0.103	86:2f:19:54:fc:f6	(Unknown)

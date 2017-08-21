#!/bin/bash

#writtin by Abdulaziz Albani

#Run this script on CentOS 

#passwd file hash
PasswdHash="$(md5sum /etc/passwd | cut -d ' ' -f 1)"

#menu method
menu(){
echo " Script Menu
Enter 1 for Check Passwd file Hashe
Enter 2 for ping to check if the host are alive
Enter 3 to Exit"
read -p " Enter your option followed by enter: " MenuOption
if [ $MenuOption -eq 1 ]; then
	CheckHashe
elif [  $MenuOption -eq 2 ]; then
	isAlive
elif [  $MenuOption -eq 3 ]; then
	exit
fi
}

#this method will compare the file hash
CheckHashe(){
echo "############## Check if passwd file is changed or not ##############"
#get a file name from the user
read -p "Please Enter file path followed by ENTER: " filename
md5="$(md5sum $filename | cut -d ' ' -f 1)"
if [ "$PasswdHash" == "$md5" ]; then
	echo "The file has not been changed"
elif [ "$PasswdHash" != "$md5" ]; then
	echo "The file is changed"
fi
echo "########################################"
menu
}

#this method check if a host is alive using ping command
isAlive(){
echo "############## Check if host is Alive or not ##############"
read -p "Please enter the host domain or ip address followed by Enter: " addr
ping1="$(ping -c3 $addr | grep % | cut -d ' ' -f 6)"
ping2="$(ping -c3 $addr | grep % | cut -d ' ' -f 8)"
if [ "$ping1" == "0%" ]; then
	echo " Host is Alive "
elif [ "$ping2" == "100%" ]; then
	echo " Host is Dead "
fi
echo "########################################"
menu
}
menu

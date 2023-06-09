#!/bin/bash

#we will print a line for frontend folde

a=10
Date=$(date +%F)
echo -e "\e[32;34m this is Frontend $a\e[0m"
echo  this is to test the bash 
echo  "my project is good"
echo -e "/t work is good "
echo -e "Today's date is \e[43;32m $Date \e[0m"
echo -e "\e[43;32m Test \e[0m"
echo -e "\e[44;33m; good \e[0m"

a=10
b=20
c=40
echo -e "value of a is $a"
echo -e "value \e[32 ;of a is [33 ; $a\e [0m"
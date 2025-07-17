#!/bin/bash
tput cup 0 0
echo "******************************************************************************"
tput cup 1 0
echo "******************************************************************************"


echo "enter Item no.="
read no
echo "enter Item name="
read nm
echo "enter Price"
read pp
echo "saving the record"
echo "$no:$nm:$pp">>entries
echo "want to enter another record (y/n)"
read ch
if [ $ch ="y" ];then
bash s1
fi

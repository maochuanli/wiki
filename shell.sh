#!/bin/bash
valid=true
count=1
while [[ $valid ]]
do
    echo $count
    if [ $count -eq 5 ]
    then
	break
    else
	echo 'count'
    fi
    ((count++))
done


for (( counter=10; counter>0; counter-- ))
do
    echo -n "$counter "
done
printf "\n"

#read -p "Name: " name
echo "Welcome $name to LinuxHint"

n=10
if [ $n -lt 10 ];
then
    echo "It is a one digit number"
else
    echo "It is a two digit number"
fi

username="admin"
password="secret"
if [[  $username == "admin" && $password == "secret"  ]]; then
    echo "valid user"
else
    echo "invalid user"
fi


n=45
if [[  $n -eq 15 || $n  -eq 45  ]]
then
    echo "You won the game"
else
    echo "You lost the game"
fi

n=101

if [ $n -eq 101 ];
then
    echo "You got 1st prize"
elif [ $n -eq 510 ];
then
    echo "You got 2nd prize"
elif [ $n -eq 999 ];
then
    echo "You got 3rd prize"

else
    echo "Sorry, try for the next time"
fi

n=510

case $n in
    101)
	echo echo "You got 1st prize" ;;
    510)
	echo "You got 2nd prize" ;;
    999)
	echo "You got 3rd prize" ;;
    *)
	echo "Sorry, try for the next time" ;;
esac

echo "Total arguments : $#"
echo "0th Argument = $0"
echo "1st Argument = $1"
echo "2nd argument = $2"
echo "all argument = $*"

string1="Linux"
string2="Hint"
echo "$string1$string2"
string3=$string1+$string2
string3+=" is a good tutorial blog site"
echo $string3

Str="Learn Linux from LinuxHint"
subStr=${Str:0:2}
echo $subStr

read x
echo "Enter second number"
read y
(( sum=x+y ))
echo "The result of addition=$sum"

function F1()
{
    area=$(($1 * $2))
    echo "Area is : $area"
    echo 'I like bash programming'
}

F1 12 34
s=$(F1 1 3)
echo $s

echo 'make dir'
ndir='/tmp/dir'
if [ -d "$ndir" ]
then
    echo "Directory exist"
else
    `mkdir $ndir`
    echo "Directory created"
fi

cmd=$(echo hi)
echo $cmd


file='book.txt'
while read line; do
    echo $line
done < $file

Recipient="mao.chuan.li@gmail.com"
Subject="Greeting"
Message="Welcome to our site"
`mail -s $Subject $Recipient <<< $Message`

Year=`date +%Y`
Month=`date +%m`
Day=`date +%d`
Hour=`date +%H`
Minute=`date +%M`
Second=`date +%S`
echo `date`
echo "Current Date is: $Day-$Month-$Year"
echo "Current Time is: $Hour:$Minute:$Second"

date "+DATE: %Y-%m-%d+TIME: %H:%M:%S <"

echo "Wait command" &
process_id=$!
wait $process_id
echo "Exited with status $?"

echo "Wait for 5 seconds"
sleep 5
echo "Completed"

#!/bin/bash
# A small Bash script to set up User LED3 to be turned on or off from 
#  Linux console. Written by Derek Molloy (derekmolloy.ie) for the 
#  book Exploring BeagleBone.

LED3_PATH=/sys/class/leds/beaglebone:green:usr3

# Example bash function
function removeTrigger
{
  echo "none" >> "$LED3_PATH/trigger"
}

echo "Starting the LED Bash Script"
if [ $# -eq 0 ]; then
  echo "There are no arguments. Usage is:"
  echo -e " bashLED Command \n  where command is one of "
  echo -e "   on, off, flash or status  \n e.g. bashLED on "
  exit 2
fi
echo "The LED Command that was passed is: $1" #=blink
echo "Blinking the LED $2 times" #same as X number of times
if [ "$1" == "on" ]; then
  echo "Turning the LED on"
  removeTrigger
  echo "1" >> "$LED3_PATH/brightness"
elif [ "$2" == "off" ]; then
  echo "Turning the LED off"
  removeTrigger
  echo "0" >> "$LED3_PATH/brightness"

elif [ "$1" == "blink" ]; then #blink becomes command
X=$2 #empty contents of X into 2
i="0" #integer i with initialization
#structure of while loop for bash files taken from web
while [ $i -lt $2 ] #-lt is less than
	# while contents of i are less than contents of  X, execute
do
	echo "1" >> "$LED3_PATH/brightness" #turn on LED
	sleep 1 #pause for 1 second
	echo "0" >> "$LED3_PATH/brightness" #turn off LED
	sleep 1 #pause for 1 second
	i=$[$i+1] #increment i by 1, number of times to blink until reaches X times
done

elif [ "$1" == "flash" ]; then
  echo "Flashing the LED"
  removeTrigger
  echo "timer" >> "$LED3_PATH/trigger"
  sleep 1
  echo "100" >> "$LED3_PATH/delay_off"
  echo "100" >> "$LED3_PATH/delay_on"
elif [ "$1" == "status" ]; then
  cat "$LED3_PATH/trigger";
fi
echo "End of the LED Bash Script"

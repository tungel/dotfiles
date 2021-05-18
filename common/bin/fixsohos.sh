#!/bin/bash

THRESHOLD=200

while true; do
  echo "-----------------------------------------------------------------------"
  echo
  number_of_processes=`sudo lsof -n -i TCP | grep -i 'com.sopho' | awk '{ print $2 }' | wc -l`

  echo "Number of Sophos processes: $number_of_processes"

  if (( number_of_processes > $THRESHOLD )); then
    echo "Threshold reached!"
    echo "Killing sophos processes..."
    sudo kill -9 `sudo lsof -n -i TCP | grep -i 'com.sopho' | awk '{ print $2 }' | head -1`
    echo "Done killing sophos."
  else
    echo "We are fine for now"
  fi

  sleep 10
done


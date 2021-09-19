#!/bin/bash

THRESHOLD=5

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

  echo "-----------------------------------------------------------------------"
  echo "Killing Sophos Network Extension..."
  sudo kill -9 `ps aux | grep 'Sophos Network Extension' | grep '_sophos' | awk '{ print $2 }'`
  echo "Done killing Sophos Network Extension."

  echo "-----------------------------------------------------------------------"
  echo "Killing SophosScanD..."
  sudo kill -9 `ps aux | grep 'SophosScanD' | grep '_sophos' | awk '{ print $2 }'`
  echo "Done killing SophosScanD."

  echo "-----------------------------------------------------------------------"
  echo "Killing SophosEventMonitor..."
  sudo kill -9 `ps aux | grep 'SophosEventMonitor' | grep '_sophos' | awk '{ print $2 }'`
  echo "Done killing SophosEventMonitor."

  sleep 1
done


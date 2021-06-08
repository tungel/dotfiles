#!/bin/bash


if  [ -z "$SSH_ORIGINAL_COMMAND" ]; then
  # $SSH_ORIGINAL_COMMAND is empty
  echo "Nothing to execute."
else
  echo "You are trying to run: $SSH_ORIGINAL_COMMAND"

  if [ "$SSH_ORIGINAL_COMMAND" = "suspend" ]; then
    echo "Suspending the system..."
    sudo systemctl suspend
  elif [ "$SSH_ORIGINAL_COMMAND" = "restartnx" ]; then
    echo "Restarting nomachine..."
    sudo /etc/NX/nxserver --restart
  fi
fi

# to execute the original command, we can do (but let's don't do it as it's not
# secured):
# exec $SSH_ORIGINAL_COMMAND


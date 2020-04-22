#!/bin/bash

# Copy default config files:
ranger --copy-config=commands_full
ranger --copy-config=rifle
ranger --copy-config=scope
ranger --copy-config=rc

# Add the customized configurations to the ranger's config files
cat ~/.config/ranger/rc.conf.ttl >> ~/.config/ranger/rc.conf
cat ~/.config/ranger/rifle.conf.ttl >> ~/.config/ranger/rifle.conf


#!/bin/bash

# ref: https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x/40254864

# map caps lock to left control key
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'


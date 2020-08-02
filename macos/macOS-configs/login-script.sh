#!/bin/bash

# ref: https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x/40254864

# map caps lock to left control key
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'

# swap CMD and Alt keys on the left side of the keyboard
# map left CMD (E3) key to left Alt (E2)
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x7000000E3,"HIDKeyboardModifierMappingDst":0x7000000E2}]}'
# map left Alt (E2) key to left CMD (E3)
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x7000000E2,"HIDKeyboardModifierMappingDst":0x7000000E3}]}'


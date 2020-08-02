#!/bin/bash

# ref:
# - https://stackoverflow.com/questions/127591/using-caps-lock-as-esc-in-mac-os-x/40254864
# - Remapping Keys in macOS 10.12 Sierra
#   https://developer.apple.com/library/archive/technotes/tn2450/_index.html#//apple_ref/doc/uid/DTS40017618-CH1-KEY_TABLE_USAGES

# map caps lock (39) to left control key (E0)
# swap CMD (E3) and Alt (E2) keys on the left side of the keyboard
hidutil property --set '{"UserKeyMapping":[
{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0},
{"HIDKeyboardModifierMappingSrc":0x7000000E3,"HIDKeyboardModifierMappingDst":0x7000000E2},
{"HIDKeyboardModifierMappingSrc":0x7000000E2,"HIDKeyboardModifierMappingDst":0x7000000E3}
]}'


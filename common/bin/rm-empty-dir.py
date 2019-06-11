#!/usr/bin/env python

# ==============================================================================
# https://github.com/everbot/dotfiles
#
# Author: Tung Le
#
# Delete empty directories in a given input directory
# Use with care!
# ==============================================================================

import argparse
import os

emptyDirList = set()
def removeDir(dirPath):
    # if the input dir is empty?
    if not os.listdir(dirPath):
        if (args.delete):
            print("Deleting: " + dirPath)
            os.rmdir(dirPath)
        else:
            emptyDirList.add(dirPath)
    else:
        for i in os.listdir(dirPath):
            childPath = os.path.join(dirPath, i) # get path of the child
            if os.path.isdir(childPath):
                removeDir(childPath)

        # check if its empty subdirs are gone so we can delete it
        if (args.delete):
            if not os.listdir(dirPath):
                print("Deleting: " + dirPath)
                os.rmdir(dirPath)
        else:
            for i in os.listdir(dirPath):
                childPath = os.path.join(dirPath, i) # get path of the child
                # if it contains at least 1 item, we don't delete it
                if not(childPath in emptyDirList):
                    return
            emptyDirList.add(dirPath)


parser = argparse.ArgumentParser(description='Remove empty dir')
parser.add_argument('-i', '--input', help='Input dir name', required=True)
parser.add_argument('--delete', action='store_true', help='Execute removing empty dirs')
args = parser.parse_args()

removeDir(args.input)

if not args.delete:
    print("List of empty directories:")
    for i in emptyDirList:
        print(i)


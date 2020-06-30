#!/usr/bin/env python

import sys
import os
from datetime import datetime

# Usage: ./process-hashes.py hashes.txt

# To generate hashes file:
# time find . -type f -exec openssl sha256 -r '{}' \; | sort -t ' ' -k2,2 > _hashes-`date +%F`.txt

# Return a dict that contains hashes as keys and array of paths as values
def generate_file_dict(hash_file):
    file_dict = {}
    # ref: https://realpython.com/read-write-files-python/
    with open(hash_file, 'r') as reader:
        line = reader.readline()
        for line in reader:
            # each line must have 2 parts: the checksum and the relative path to the file
            # 0674ecaa132e39b8d2006f9efc31c3e163a13563a150224a777182b897b3ad7d *./path/file.JPG

            # split the line into hash part and path part
            hash_path = line.split(" ", 1)
            if len(hash_path) != 2 or "*./.hashes/" in hash_path[1]:
                # ignore .hashes folder or if there is problem with string
                # splitting
                continue
            hash_path[1] = hash_path[1].rstrip('\n')
            hash_value = hash_path[0]
            if hash_value not in file_dict:
                file_dict[hash_value] = []
            file_dict[hash_value].append(hash_path[1])

    return file_dict

def print_duplicates(duplicates_dict, file_path):
    print(f"Found {len(duplicates_dict)} duplicated entries in {file_path}")
    for k, v in duplicates_dict.items():
        print(f"{k}: {v}")
    print("======================================================================")

def print_dicts_diff(dict1, dict2, file1, file2):
    print("======================================================================")
    print(f"Only in '{file1}':")
    count = 0
    for k, v in dict1.items():
        if k not in dict2:
            count += 1
            print(f"{k}: {v}")
    print(f"Found {count} differences.")

args = sys.argv

hashes_dir = '.hashes'
today_file = f"hashes-{datetime.today().strftime('%Y-%m-%d')}.txt"

# trying to get latest hashes file
previous_hash_file = ''
files_list = sorted(os.listdir(hashes_dir), reverse=True)
if len(files_list) > 0:
    previous_hash_file = os.path.join(hashes_dir, files_list[0])
    print(f"Current latest hash file:  {previous_hash_file}")

try:
    os.makedirs(hashes_dir)
except OSError as e:
    if not os.path.exists(hashes_dir):
        sys.exit("Error creating '.hashes' directory. Check permissions.")

new_hash_file = os.path.join(hashes_dir, today_file)
print(f"Creating new hash file in: {new_hash_file}")
create_hashes_cmd = "time find . -type f -exec openssl sha256 -r '{}' \; | sort -t ' ' -k2,2 > .hashes/" + today_file
stream = os.popen(create_hashes_cmd)
create_hashes_output = stream.read()
print(create_hashes_output)
print('----------------------------------------------------------------------')

file_dict_1 = generate_file_dict(new_hash_file)
duplicates_1 = dict(filter(lambda item: len(item[1]) > 1, file_dict_1.items()))
print_duplicates(duplicates_1, new_hash_file)

if previous_hash_file:
    file_dict_2 = generate_file_dict(previous_hash_file)
    duplicates_2 = dict(filter(lambda item: len(item[1]) > 1, file_dict_2.items()))
    print_duplicates(duplicates_2, previous_hash_file)

    # now compare 2 hashes files
    print_dicts_diff(file_dict_1, file_dict_2, new_hash_file, previous_hash_file)
    print_dicts_diff(file_dict_2, file_dict_1, previous_hash_file, new_hash_file)


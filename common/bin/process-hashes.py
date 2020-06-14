#!/usr/bin/env python

import sys

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

if len(args) > 1:
    hash_file_1 = args[1]
    file_dict_1 = generate_file_dict(hash_file_1)
    duplicates_1 = dict(filter(lambda item: len(item[1]) > 1, file_dict_1.items()))
    print_duplicates(duplicates_1, hash_file_1)

# Usage: ./process-hashes.py hashes1.txt hashes2.txt
if len(args) > 2:
    hash_file_2 = args[2]
    file_dict_2 = generate_file_dict(hash_file_2)
    duplicates_2 = dict(filter(lambda item: len(item[1]) > 1, file_dict_2.items()))
    print_duplicates(duplicates_2, hash_file_2)

    # now compare 2 hashes files
    print_dicts_diff(file_dict_1, file_dict_2, hash_file_1, hash_file_2)
    print_dicts_diff(file_dict_2, file_dict_1, hash_file_2, hash_file_1)


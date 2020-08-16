#!/usr/bin/env python3

import click
import re
import errno
import os
import shutil

OUTPUT_DIR_HELP = 'The ouput directory that stores dated sub directories'

# Example dry-run: move-files-to-dated-folder.py -o ../output
# To actually move files: move-files-to-dated-folder.py -o ../output -r


@click.command()
@click.option('--output-dir', '-o', multiple=False, default=None, help=OUTPUT_DIR_HELP, required=True)
@click.option('--no-dry-run', '-r', multiple=False, is_flag=True)
def main(output_dir=None, no_dry_run=None):

    # the first 8 chars must be in the form yyyymmdd
    dmy_matcher = re.compile("^\d{8}")
    # or in the form yyyy-mm-dd
    dmy_dash_matcher = re.compile("^\d{4}-\d{2}-\d{2}")

    cwd = os.getcwd()

    for item in os.listdir(cwd):
        # full path of original file
        current_file_path = os.path.join(os.getcwd(), item)

        found_match = False

        if dmy_matcher.match(item):
            target_dir_name = f"{item[0:4]}-{item[4:6]}"  # yyyy-mm
            found_match = True
        elif dmy_dash_matcher.match(item):
            target_dir_name = f"{item[0:4]}-{item[5:7]}"  # yyyy-mm
            found_match = True

        if not found_match:
            continue

        target_dir_path = os.path.join(output_dir, target_dir_name)
        try:
            os.makedirs(target_dir_path)
        except OSError as e:
            if e.errno != errno.EEXIST:
                raise

        print(f"Moving {current_file_path} to {target_dir_path}")

        if no_dry_run:
            shutil.move(current_file_path, target_dir_path)

    if no_dry_run:
        print('\n\nSuccessfully moved files!')
    else:
        print('\n\nNOTE: NO OP due to dry run = true')


if __name__ == '__main__':
    main()

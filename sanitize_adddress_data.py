#! /usr/bin/env python
"""
A skeleton python script which reads from an input file,
writes to an output file and parses command line arguments
"""
from __future__ import print_function

import csv

import sys

def main():
    print("Hello, World!")

    if len(sys.argv) < 2:
        print('You need to specify a file')
        sys.exit()

    argc = len(sys.argv)

    for i in range(1, argc):
        csv_file_name = sys.argv[i]
        print("file is {0}".format(csv_file_name))
        with open(csv_file_name) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            num_columns = 0
            column_names = []
            for row in csv_reader:
                if line_count == 0:
                    print(f'Column names are {", ".join(row)}')
                    column_names = row
                    num_columns  = len(column_names)
                    line_count += 1
                else:
                    num_row_columns = len(row)
                    if num_row_columns < num_columns:
                        print(f"Row {line_count} has {num_row_columns} cols instead of expected {num_columns} cols")
                        # assume this is junk??
                        print(f"Discarding row {row}")
                        continue
                    for col_num in range(0, num_columns):
                        col_name = column_names[col_num]
                        row_data = row[col_num].strip()
                        print(f"{col_name}='{row_data}' ", end='')
                    print()
                    line_count += 1
            print(f'Processed {line_count} lines.')

if __name__ == "__main__":
    main()
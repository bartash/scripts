#! /usr/bin/env python
"""
A skeleton python script which reads from an input file,
writes to an output file and parses command line arguments
"""
from __future__ import print_function

import csv

import logging
import sys

class CsvData(object):

    def __init__(self, name):
        self.name = name



def main():
    logging.getLogger().setLevel(logging.INFO)

    if len(sys.argv) < 2:
        print('You need to specify a file')
        sys.exit()

    argc = len(sys.argv)

    holders = []
    for i in range(1, argc):
        csv_file_name = sys.argv[i]
        logging.debug(f"file is {csv_file_name}")
        with open(csv_file_name) as csv_file:
            holder = CsvData(name=csv_file_name)
            holders.append(holder)
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            num_columns = 0
            column_names = []
            for row in csv_reader:
                if line_count == 0:
                    logging.info(f'Column names are {", ".join(row)}')
                    column_names = row
                    num_columns  = len(column_names)
                    line_count += 1
                else:
                    num_row_columns = len(row)
                    if num_row_columns < num_columns:
                        logging.warning(f"Row {line_count} has {num_row_columns} cols instead of expected {num_columns} cols")
                        # assume this is junk?? For example in original test data this was "</div>"
                        logging.warning(f"Discarding row {row}")
                        continue
                    debug_str = ""
                    for col_num in range(0, num_columns):
                        col_name = column_names[col_num]
                        row_data = row[col_num].strip()
                        debug_str += f"{col_name}='{row_data}' "
                    logging.info(f"{debug_str}")
                    line_count += 1
            logging.info(f'Processed {line_count} lines from {csv_file_name}.')

    logging.info(f"Read %d files", len(holders))

if __name__ == "__main__":
    main()
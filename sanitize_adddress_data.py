#! /usr/bin/env python
"""
A skeleton python script which reads from an input file,
writes to an output file and parses command line arguments
"""
from __future__ import print_function

import csv

import logging
import sys

class CsvInputData(object):

    def __init__(self, name):
        self.name = name
        self.rows = []
        self.columns = None

class CsvOutputData(object):
    def __init__(self):
        # key is columns tuple, value is dict with rows -> years_string
        self.rows = {}


OUTPUT_COLS = ["LAST1"
               "FIRST1",
               "LAST2",
               "FIRST2",
               "NAME",
               "NUMBER",
               "STREET",
               "ADDRESS",
               "CITY",
               "STATE",
               "ZIP",
               "EMAIL1",
               "EMAIL2",
               "PHONE"
               ]

def build_output(holders):
    output = CsvOutputData()
    # Merge common rows, I happen to know there is only one column tuple where this is done
    # so I can use a single CsvData to merge it into.
    new_holder = None
    for holder in holders:
        ylen = len(holder.name)
        year = holder.name[ylen - 8:ylen - 4]
        columns = tuple(holder.columns)
        if columns not in output.rows:
            output.rows[columns] = {}
        row_dict = output.rows[columns]
        for row in holder.rows:
            row_tuple = tuple(row)
            if row_tuple not in row_dict:
                row_dict[row_tuple] = year
            else:
                row_dict[row_tuple] = row_dict[row_tuple]  + f" {year}"
    return output



def count_columns(holders):
    all_cols = {}
    col_tuples = {}
    years = {}
    for holder in holders:
        for col_name in holder.columns:
            all_cols[col_name] = 1
        ylen = len(holder.name)
        year = holder.name[ylen - 8:ylen - 4]
        logging.debug(f"count_columns look at {holder.name} year='{year}'")
        columns = tuple(holder.columns)
        if columns in col_tuples:
            col_tuples[columns] += 1
            years[columns] = years[columns] + " {}".format(year)
        else:
            col_tuples[columns] = 1
            years[columns] = "{}".format(year)
    logging.info(f"all columns")
    for col_name in all_cols:
        logging.info(f"{col_name}")
    for key in col_tuples:
        logging.info(f"cols[{key}]={col_tuples[key]} occurs in years {years[key]}")



def main():
    logging.getLogger().setLevel(logging.INFO)

    if len(sys.argv) < 2:
        print('You need to specify a file')
        sys.exit()

    argc = len(sys.argv)

    holders = read_csv_files(argc)
    logging.info(f"Read %d files", len(holders))

    count_columns(holders)

    output = build_output(holders)
    logging.info(f"output size={len(output.rows)}")


def read_csv_files(argc):
    """return a list of CsvData objects read from the file arguments"""
    holders = []
    for i in range(1, argc):
        csv_file_name = sys.argv[i]
        logging.debug(f"file is {csv_file_name}")
        with open(csv_file_name) as csv_file:
            holder = CsvInputData(name=csv_file_name)
            holders.append(holder)
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            num_columns = 0
            column_names = []
            for row in csv_reader:
                if line_count == 0:
                    logging.info(f'Column names are {", ".join(row)}')
                    column_names = row
                    num_columns = len(column_names)
                    line_count += 1
                    holder.columns = column_names
                else:
                    num_row_columns = len(row)
                    if num_row_columns < num_columns:
                        logging.warning(
                            f"Row {line_count} has {num_row_columns} cols instead of expected {num_columns} cols")
                        # assume this is junk?? For example in original test data this was "</div>"
                        logging.warning(f"Discarding row {row}")
                        continue
                    debug_str = ""
                    for col_num in range(0, num_columns):
                        col_name = column_names[col_num]
                        row_data = row[col_num].strip()
                        debug_str += f"{col_name}='{row_data}' "
                    logging.debug(f"{debug_str}")
                    line_count += 1
                    holder.rows.append(row)
            logging.info(f'Processed {line_count} lines from {csv_file_name}.')
    return holders


if __name__ == "__main__":
    main()
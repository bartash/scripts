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
        self.column_group = {}


OUTPUT_COLS = [
    "YEARS",
    "LAST1",
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
    "PHONE",
]

def build_output(holders):
    """Build a data structure containing all the data"""
    output = CsvOutputData()
    for holder in holders:
        ylen = len(holder.name)
        year = holder.name[ylen - 8:ylen - 4]
        columns = tuple(holder.columns)
        if columns not in output.column_group:
            output.column_group[columns] = {}
        row_dict = output.column_group[columns]
        for row in holder.rows:
            row_tuple = tuple(row)
            if row_tuple not in row_dict:
                row_dict[row_tuple] = year
            else:
                row_dict[row_tuple] = row_dict[row_tuple]  + f" {year}"
    return output



def count_columns(holders):
    """Look at all the columns. This method does not have any actual function"""
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


def print_output(output, file_name):
    """Output the data as csv"""
    with open(file_name, 'w', newline='') as csvfile:
        fieldnames = OUTPUT_COLS
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames, restval='')
        writer.writeheader()

        for columns in output.column_group:
            rows = output.column_group[columns]
            for row in rows:
                col_count = 0
                row_dict = {}
                years = rows[row]
                row_dict['YEARS'] = years
                for column in columns:
                    col_text = row[col_count]
                    if col_text == "No Change":
                        col_text = ""
                    row_dict[column] = col_text
                    col_count  += 1
                # do some post-processing
                fixup_address(row_dict)
                fixup_name(row_dict)
                fixup_name2(row_dict)
                # write the row
                writer.writerow(row_dict)


def fixup_address(row_dict):
    # Fixup address data
    if not 'ADDRESS' in row_dict:
        if 'NUMBER' in row_dict and 'STREET' in row_dict:
            row_dict['ADDRESS'] = row_dict['NUMBER'] + " " + row_dict['STREET']
    if 'ADDRESS' in row_dict and row_dict['ADDRESS']:
        if not 'NUMBER' in row_dict and not 'STREET' in row_dict:
            addr_split = row_dict['ADDRESS'].split(None, 1)
            row_dict['NUMBER'] = addr_split[0]
            row_dict['STREET'] = addr_split[1]

def fixup_name(row_dict):
    # Fixup name data
    if not 'NAME' in row_dict:
        if 'LAST1' in row_dict and 'FIRST1' in row_dict:
           if 'LAST2' in row_dict and 'FIRST2' in row_dict and row_dict['LAST2'] and row_dict['FIRST2']:
                row_dict['NAME'] = row_dict['FIRST1'] + " " + row_dict['LAST1'] + \
                                   " and " + row_dict['FIRST2'] + " " + row_dict['LAST2']
           else:
                row_dict['NAME'] = row_dict['FIRST1'] + " " + row_dict['LAST1']


def fixup_name2(row_dict):
    # If NAME is just two words then use them for FIRST1 and LAST1
    if 'NAME' in row_dict:
        if ('LAST1' not in row_dict or not row_dict['LAST1']) and ('FIRST1' not in row_dict or not row_dict['FIRST1']):
            name = row_dict['NAME']
            if name:
                name_split = name.split(None)
                if len(name_split) == 2:
                    row_dict['FIRST1'] = name_split[0]
                    row_dict['LAST1'] = name_split[1]



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
    logging.info(f"output size={len(output.column_group)}")

    # FIXME make output file a parameter.
    target = "/home/asherman/git/contactsData/merged9.csv"
    print_output(output, target)
    logging.info(f"Generated {target}")


def read_csv_files(argc):
    """return a list of CsvData objects read from the file arguments"""
    holders = []
    for i in reversed(range(1, argc)):
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
#!/usr/bin/env python
import json
import sys


def main():
	"""
	This program parses the dwx log file
	"""
	if len(sys.argv) != 2:
		print("usage: %s file" % sys.argv[0])
		sys.exit(-1)
	with open(sys.argv[1]) as file:
		for line in file:
			try:
				data = json.loads(line)
				# print("{0}".format(data['timestamp']))
				msg=data['message']
				print("{0}".format(msg))
			except ValueError as v:
				print("skip a line %s" % line)
	sys.exit(0)


if __name__ == "__main__":
	main()


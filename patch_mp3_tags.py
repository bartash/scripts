#!/usr/bin/env python3

# for tags see https://id3.org/id3v2.4.0-frames
import sys

from mutagen.id3 import ID3
from mutagen.easyid3 import EasyID3


def main():
	"""
	This program reads and patches mp3 files
	"""
	if len(sys.argv) != 2:
		print("usage: %s file" % sys.argv[0])
		sys.exit(-1)
	file = sys.argv[1]

	# here is where to manipulate the new name - strip prefix, undo camel case
	new = file


	audio = EasyID3(file)
	# print all tags
	print("dumping all tags")
	print(audio.pprint())
	old = audio["title"]
	audio["title"] = file
	print(f"old title was {old} new is {new}")

	audio.save()


if __name__ == "__main__":
	main()


#!/usr/bin/env python
import json
import sys


def main():
  """
  This program parses the json output from
   k get pods -n  impala-0000000000-xxxx -o json
  to show the cpu resources used
  """
  if len(sys.argv) != 2:
    print("usage: %s file" % sys.argv[0])
    sys.exit(-1)
  with open(sys.argv[1]) as file:
    data = json.load(file)
  items = data['items']
  for item in items:
    for container in item['spec']['containers']:
      resources = container['resources']
      if 'limits' in resources:
        limits = resources['limits']
        cpu = "unknown"
        if 'cpu' in limits:
          cpu =  limits['cpu']
        # print("image %s limits cpu %s" % (container['name'], cpu))
      if 'requests' in resources:
        requests = resources['requests']
        cpu = "unknown"
        if 'cpu' in requests:
          cpu =  requests['cpu']
        if 'memory' in requests:
          memory =  requests['memory']
        print("image %s requests cpu %s memory %s" % (container['name'], cpu, memory))
  sys.exit(0)


if __name__ == "__main__":
  main()

#!/usr/bin/env python

# alternative perl command: /usr/bin/json_pp

import sys, json
print json.dumps(json.load(sys.stdin), sort_keys=True, indent=2)

#!/usr/bin/python

import sys

lines = sys.stdin.read().splitlines()

def special_print(line):
  line = line.replace('<a href','@@@')
  line = line.replace('</a>','@@@')
  buffer = line.split('@@@')
  is_title = False
  for b in buffer:
    if b[0] == '=':
      print b.split('>',1)[1],
      if is_title:
        print '<br>',
      else:
        print ''
    else:
      if is_title:
        print b.replace("</span>,","</span>")
        is_title = False
      else:
        print b
      is_title = "class='title'" in b

for line in lines:
  if "View publication details" in line:
    special_print(line)
  else:
    print line

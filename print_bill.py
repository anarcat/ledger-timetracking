#!/usr/bin/python

from __future__ import print_function

import sys

try:
    import ledger
except:
    sys.exit('ledger extension missing, try installing python-ledger')

def dumpattrs(obj):
    for field in dir(obj):
        print('%s' % field, end='')
        try:
            print(': %s' % getattr(obj, field))
        except Exception as e:
            # a bunch of those fail, ignore
            print(': could not extract field! (%s)' % e)
        
    
for post in ledger.read_journal("ledger.lgr").query(""):
        print("Transferring %s to/from %s" % (post.amount, post.account))
        print('transaction fields:')
        dumpattrs(post)
        for func in ('xdata',):
            print('%s: attrs:' % func, end='')
            xdata = getattr(post, func)()
            dumpattrs(xdata)

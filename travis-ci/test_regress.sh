#!/usr/bin/env sh


make -C doc -f Makefile_test testall > testall_doc.log 2>&1
tail -100 testall_doc.log
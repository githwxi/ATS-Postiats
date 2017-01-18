#!/usr/bin/env sh


cd ${PATSHOME}
make -C ${PATSHOME}/doc -f Makefile_test testall > testall_doc.log 2>&1
tail -100 testall_doc.log
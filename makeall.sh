#!/bin/sh

# Updates core ATS system

cd src/
make cleanall
cd ..

make -f codegen/Makefile_atslib
touch src/.depend
make -C src -f Makefile all

cp src/patsopt bin/patsopt

cd utils/atscc
make
cp patscc ../../bin/
cd ../..
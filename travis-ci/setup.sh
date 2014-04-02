#!/usr/bin/env sh

ATS1=$1

wget http://downloads.sourceforge.net/project/ats-lang/ats-lang/anairiats-${ATS1}/ats-lang-anairiats-${ATS1}.tgz
tar xf ats-lang-anairiats-${ATS1}.tgz
cd ats-lang-anairiats-${ATS1}
./configure
make -j8

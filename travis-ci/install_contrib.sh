#!/usr/bin/env sh

cd $HOME
git clone https://github.com/githwxi/ATS-Postiats-contrib

cd $PATSHOME/contrib/CATS-parsemit  && make all
cd $PATSHOME/contrib/CATS-atscc2clj && make all && cp -f atscc2clj $PATSHOME/bin && atscc2clj
cd $PATSHOME/contrib/CATS-atscc2erl && make all && cp -f atscc2erl $PATSHOME/bin && atscc2erl
cd $PATSHOME/contrib/CATS-atscc2js  && make all && cp -f atscc2js $PATSHOME/bin  && atscc2js
cd $PATSHOME/contrib/CATS-atscc2php && make all && cp -f atscc2php $PATSHOME/bin && atscc2php
cd $PATSHOME/contrib/CATS-atscc2pl  && make all && cp -f atscc2pl $PATSHOME/bin  && atscc2pl
cd $PATSHOME/contrib/CATS-atscc2py3 && make all && cp -f atscc2py3 $PATSHOME/bin && atscc2py3
cd $PATSHOME/contrib/CATS-atscc2scm && make all && cp -f atscc2scm $PATSHOME/bin && atscc2scm

cd $PATSHOME/contrib/ATS-extsolve      && make all && cp -f patsolve $PATSHOME/bin      && patsolve
cd $PATSHOME/contrib/ATS-extsolve-smt2 && make all && cp -f patsolve_smt2 $PATSHOME/bin && patsolve_smt2
cd $PATSHOME/contrib/ATS-extsolve-z3   && make all && cp -f patsolve_z3 $PATSHOME/bin   && patsolve_z3



# Libatsopt

Libatsopt is the library version of Patsopt (i.e., the compiler for
ATS/Postiats). It is primarily for implementing tools that process the
syntax trees of programs written in ATS2.

## Building libatsopt

After npm-installing the package ats1-libatsopt, one needs to locate
where the package is stored locally. For the sake of illustration, let
us suppose that the package resides inside a directory of the following
name:
  
$SomePath/node_modules/ats1-libatsopt

Please issue the following command-line to build libatsopt:

cd $SomePath/node_modules/ats1-libatsopt; make all

Alternatively, one may issue the following command-line:

make -C $SomePath/node_modules/ats1-libatsopt all

## Linking to libatsopt

Note that the generated library libatsopt.a is stored in the following
directory:

$SomePath/node_modules/ats1-libatsopt/ccomp/atslib/lib

Typically, one needs the following options for linking to libatsopt
  
-L $SomePath/node_modules/ats1-libatsopt/ccomp/atslib/lib -latsopt

## Examples of using libatsopt

Please find various examples of using libatsopt inside libatsopt/TEST/.

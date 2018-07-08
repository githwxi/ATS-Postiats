# ATS-Postiats-include

For compiling the C code generated from ATS source via patsopt

## Package Description

The package ATS-Postiats-include contains various .h and .cats files
needed for compiling the C code generated from ATS source.  Normally,
there is no need to install this package explicitly as it is part of
the ATS programming language system.  There are, however, situations
where one does not want to install ATS or have difficulty installing
it. Under such situations, one can install this package so as to
compile the C code generated from ATS source via patsopt. Please note
that releasing C code generated from ATS source is considered a highly
effective way of distributing portable software written in ATS.

The package ATS-Postiats-include can also be readily used for
cross-platform development where it is difficult to generate on the
source platform certain object code needed for an application designed
to be running on some target platform (that is different for the
source platform). Instead, it is more convenient or even necessary to
compile C code on the target platform to generate the needed object
code. For instance, combining ATS with the Xcode platform (on MacOS)
can be handled in such a manner.

## Typical Usage of the Package

Suppose that the package is stored in a directory
${ATS-Postiats-include}. The following command-line shows a typical
way of using the package for compilation:

CC=gcc && \
${CC} -I${ATS-Postiats-include} -I${ATS-Postiats-include}/ccomp/runtime ...

For instance, if the package is npm-installed locally, then the directory
containing the package is likely to be 'node_modules/ats-postiats-include'

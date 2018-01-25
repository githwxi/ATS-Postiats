# Libgmp

A simple package for calling GMP-functions in ATS

## Description

###CATS Files

1. CATS/gmp.cats: This file contains various C-macros that are
needed for compiling the C code generated from ATS source. Note that
the include-path must be properly set for the C-compiler so as to
allow it to have access to `gmp.cats`.

###SATS Files

1. SATS/gmp.sats:
This file contains the interface (in ATS) for various GMP-functions.

###DATS Files

1. DATS/gmp.dats: It is yet empty at this moment.

###TEST Files

The pidigits directory contains an example that computes
to a given position all of the digits in the famous constant PI.

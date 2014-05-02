# [ATS2](http://www.ats-lang.org/) - ATS/Postiats

A Programming Language System to Unleash the Potentials of Types and Templates

## Project Description

ATS/Postiats (or ATS2/Postiats) is the name for the current compiler of
ATS2, the successor of ATS (or ATS1).

The actual implementation of ATS/Postiats started in the March of 2011, and
it took about two and one-half years to reach the first release of ATS2 at
the beginning of September, 2013. As of now, the code base for the compiler
of ATS2 consists of 140,000+ lines of code (LOC), which are nearly all
written in ATS1.

When compared to ATS1, the single most important new feature is the
template system of ATS2. This is a feature that could potentially change
the way a programmer writes his or her code. One can certainly feel that
this is a very powerful feature (a bit like feeling that OOP is a very
powerful feature). However, how this feature should be properly and
effectively used in practice needs a lot more investigation.

Another thing about ATS2 is that it is a lot leaner than ATS. One can make
good use of ATS2 without any need for compiled library (libatslib.a). Also,
GC support in ATS1 is now removed; if needed, third-party GC (e.g.,
Bohem-GC) can be readily employed.

## Build Status

* [![Build Status](https://travis-ci.org/githwxi/ATS-Postiats.svg?branch=master)](https://travis-ci.org/githwxi/ATS-Postiats) Ubuntu

## Installing ATS2

Please see
[http://www.ats-lang.org/DOWNLOAD/](http://www.ats-lang.org/DOWNLOAD/) for instructions.

## Developing ATS2

The compiler of ATS2 is nearly all implemented in ATS1, which is available
at [http://sourceforge.net/projects/ats-lang/](http://sourceforge.net/projects/ats-lang/).

## License

* The Compiler (ATS/Postiats):
  [GPLv3](https://github.com/githwxi/ATS-Postiats/blob/master/COPYING-gpl-3.0.txt)
* The Libraries (ATSLIB/{prelude,libc,libats}):
  [GPLv3](https://github.com/githwxi/ATS-Postiats/blob/master/COPYING-gpl-3.0.txt)

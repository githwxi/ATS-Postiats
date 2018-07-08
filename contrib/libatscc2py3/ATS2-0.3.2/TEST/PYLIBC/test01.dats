(* ****** ****** *)
//
// Trying libatscc2py3/PYLIBC
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Starting time: May 23, 2016
//
(* ****** ****** *)
//
#include"./../../staloadall.hats"
//
(* ****** ****** *)
//
staload "./../../SATS/PYLIBC/datetime.sats"
//
(* ****** ****** *)
//
extern
fun
test01_main
(
// argless
) : void = "mac#"
//
(* ****** ****** *)

implement
test01_main() =
{
//
val today = date_today()
val ((*void*)) = println! ("today.ctime() = ", today.ctime())
val ((*void*)) = println! ("today.weekday() = ", today.weekday())
val ((*void*)) = println! ("today.isoweekday() = ", today.isoweekday())
//
val today = datetime_today()
val ((*void*)) = println! ("today.ctime() = ", today.ctime())
//
} (* end of [test01_main] *)

(* ****** ****** *)

%{^
######
import sys
######
sys.setrecursionlimit(1000000)
######
from libatscc2py3_all import *
from libatscc2py3_all_pylibc import *
######
%} // end of [%{^]

(* ****** ****** *)

%{$
if __name__ == '__main__': test01_main()
%} // end of [%{$]

(* ****** ****** *)

(* end of [test01.dats] *)

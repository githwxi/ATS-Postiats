(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Python3
//
(* ****** ****** *)
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOME\
/contrib/libatscc2py3/ATS2-0.3.2"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PY3}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun rtfind (f: int -> int): int = "mac#"
//
implement
rtfind (f) = let
//
fun loop
(
  f: int -> int, i: int
) : int =
  if f (i) = 0 then i else loop (f, i+1)
//
in
  loop (f, 0(*i*))
end // end of [rtfind]

(* ****** ****** *)

%{^
import sys
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
######
%} // end of [%{^]

(* ****** ****** *)

%{$
#
poly0 = lambda x: x*x + x - 6
print('rtfind(lambda x: x*x + x - 6) =', rtfind(poly0))
poly1 = lambda x: x*x - x - 6
print('rtfind(lambda x: x*x - x - 6) =', rtfind(poly1))
#
poly2 = lambda x: x*x + 2*x - 99
print('rtfind(lambda x: x*x + 2*x - 99) =', rtfind(poly2))
poly3 = lambda x: x*x - 2*x - 99
print('rtfind(lambda x: x*x - 2*x - 99) =', rtfind(poly3))
#
%} // end of [%{$]

(* ****** ****** *)

(* end of [rtfind.dats] *)

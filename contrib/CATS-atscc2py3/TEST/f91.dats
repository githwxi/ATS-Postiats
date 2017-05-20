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
extern fun f91 : int -> int = "mac#f91"
//
implement
f91 (x) = if x >= 101 then x - 10 else f91(f91(x+11))
//
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
if (len(sys.argv) >= 2):
  print(f91(int(sys.argv[1])))
else:
  print('Usage: f91 <integer>')
#endif
%} // end of [%{$]

(* ****** ****** *)

(* end of [f91.dats] *)

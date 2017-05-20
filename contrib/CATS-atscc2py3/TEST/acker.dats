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
fun acker 
  : (int, int) -> int = "mac#acker"
//
implement
acker (m, n) =
(
case+
  (m, n) of 
| (0, _) => n + 1
| (_, 0) => acker(m-1, 1)
| (_, _) => acker(m-1, acker(m, n-1)) 
)
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
if (len(sys.argv) < 3):
  print('Usage: acker <integer> <integer>')
else:
  print(acker(int(sys.argv[1]), int(sys.argv[2])))
#endif
%} // end of [%{$]

(* ****** ****** *)

(* end of [acker.dats] *)

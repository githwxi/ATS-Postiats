(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Python3
//
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
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
"{$LIBATSCC2PY3}/SATS/float.sats"
//
(* ****** ****** *)
//
extern
fun
fact : double -> double = "mac#fact"
//
implement
fact (n) = let
//
fun loop
(
  n: double, res: double
) : double =
  if n > 0.0 then loop (n-1.0, n*res) else res
//
in
  loop (n, 1.0)
end // end of [fact]

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
  print(fact(float(sys.argv[1])))
else:
  print('Usage: fact2 <integer>')
#endif
%} // end of [%{$]

(* ****** ****** *)

(* end of [fact2.dats] *)

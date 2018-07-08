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
dataprop FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat} {r0,r1:int}
    FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]
//
(* ****** ****** *)
//
extern
fun
fibats 
  : {n:nat} int(n) -> [r:int] (FIB(n,r) | int(r)) = "mac#"
//
implement
fibats{n}(n) = let
//
fun loop
  {i:nat | i <= n}{r0,r1:int} .<n-i>.
(
  pf0: FIB (i, r0)
, pf1: FIB (i+1, r1)
| ni: int (n-i), r0: int r0, r1: int r1
) : [r:int] (FIB (n, r) | int r) =
(
  if ni > 0 then
    loop {i+1} (pf1, FIB2 (pf0, pf1) | ni - 1, r1, r0 + r1)
  else (pf0 | r0)
) (* end of [loop] *)
//
in
  loop {0} (FIB0 (), FIB1 () | n, 0, 1)
end // end of [fibats]
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
  print(fibats(int(sys.argv[1])))
else:
  print('Usage: fibats <integer>')
#endif
%} // end of [%{$]

(* ****** ****** *)

(* end of [fibats.dats] *)

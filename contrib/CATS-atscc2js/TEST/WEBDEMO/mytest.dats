(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Node.js
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun fact : int -> int = "mac#fact"
//
implement
fact (n) = if n > 0 then n * fact(n-1) else 1
//
extern
fun acker : (int, int) -> int = "mac#acker"
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
//
dataprop FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat} {r0,r1:int}
    FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
//
(* ****** ****** *)
//
extern
fun fibats{n:nat}
  : int(n) -> [r:int] (FIB(n,r) | int(r)) = "mac#fibats"
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

(* end of [mytest.dats] *)

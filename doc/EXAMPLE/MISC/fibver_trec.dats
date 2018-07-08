(*
** A verfied implementation that computes the Fibonacci numbers
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: 2006 (?) // this is one of the first examples in ATS
*)
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)

dataprop FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat} {r0,r1:int} FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]

(* ****** ****** *)

fun fibver
  {n:nat} (n: int n) .<>.
  :<> [r:int] (FIB (n, r) | int r) = let
//
fun loop
  {i:nat | i <= n} {r0,r1:int} .<n-i>.
(
  pf0: FIB (i, r0), pf1: FIB (i+1, r1) | ni: int (n-i), r0: int r0, r1: int r1
) :<> [r:int] (FIB (n, r) | int r) =
    if ni > 0 then
      loop {i+1} (pf1, FIB2 (pf0, pf1) | ni - 1, r1, r0 + r1)
    else (pf0 | r0)
  // end of [loop]
in
  loop {0} (FIB0 (), FIB1 () | n, 0, 1)
end // end of [fibver]

(* ****** ****** *)

implement
main0 () = {
  val () = assertloc ((fibver(10)).1 = 55)
  val () = assertloc ((fibver(20)).1 = 6765)
} // end of [main0]

(* ****** ****** *)

(* end of [fibver_trec.dats] *)

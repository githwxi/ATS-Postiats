(*
** A verfied implementation that computes the Fibonacci numbers
** Note that proof construction is combined with the while-loop
** construct in this example.
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2012
*)

(* ****** ****** *)

staload
_(*INT*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

dataprop
FIB (int, int) =
  | FIB0 (0, 0) | FIB1 (1, 1)
  | {n:nat}
    {r0,r1:int}
    FIB2 (n+2, r0+r1) of (FIB (n, r0), FIB (n+1, r1))
// end of [FIB]

(* ****** ****** *)

fun fibver
  {n:nat} .<>. (n: int n)
  : [r:int] (FIB (n, r) | int r) = let
  var r0: int = 0
  var r1: int = 1
  var i : int = 0
  prvar pf0 = FIB0 ()
  prvar pf1 = FIB1 ()
  val () = while* {
    i:nat;r0,r1:int | i <= n
  } (
    pf0: FIB (i, r0), pf1: FIB (i+1, r1), i: int (i), r0: int r0, r1: int r1
  ) : [r:int] (pf0 : FIB (n, r), r0: int r) => (
    i < n
  ) {
    val () = i := i+1
    val tmp = r0 + r1
    val () = r0 := r1
    val () = r1 := tmp
    prval pf1_ = pf1
    prval pf0_ = pf0
    prval pftmp = FIB2 (pf0_, pf1_)
    prval () = pf0 := pf1_
    prval () = pf1 := pftmp
  } // end of [while*]
in
  (pf0 | r0)
end // end of [fibver]

(* ****** ****** *)

implement
main (
) = 0 where {
  val () = assertloc ((fibver(10)).1 = 55)
  val () = assertloc ((fibver(20)).1 = 6765)
} // end of [main]

(* ****** ****** *)

(* end of [fibver_loop.dats] *)

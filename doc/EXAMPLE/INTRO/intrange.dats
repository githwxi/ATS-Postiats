//
// An implementation style that is often
// dubbed tail-recursion-modulo-allocation
//
// Author: Hongwei Xi (August 2007)
//

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

fun intrange
(
  m: int, n: int
) : List0_vt(int) = let
//
vtypedef
res = List0_vt(int)
//
fun loop
(
  m: int, n: int, res: &res? >> res
) : void =
  if m < n then let
    val () = res :=
      list_vt_cons{int}{0}(m, _)
    val list_vt_cons (_, res1) = res
    val () = loop (m+1, n, res1)
    prval () = fold@ (res)
  in
    // nothing 
  end else
    (res := list_vt_nil ())
  // end of [if]
//
var res: res
val () = loop (m, n, res)
//
in
  res
end // end of [intrange]

(* ****** ****** *)
//
staload "libats/SATS/sllist.sats"
//
staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"
//
(* ****** ****** *)

implement
main (
  // argless
) = 0 where {
  #define M 0
  #define N 10
  val out = stdout_ref
//
  typedef T = int
//
  val xs = intrange (M, N)
  val xs = $UN.castvwtp0{Sllist(T)}(xs)
//
  val ln = sllist_length (xs)
  val () = assertloc (ln = N-M)
  val () = fprint_sllist<T> (out, xs)
  val () = fprint_newline (out)
//
  val () = sllist_free (xs)
//
} // end of [main]

(* ****** ****** *)

(* end of [intrange.dats] *)

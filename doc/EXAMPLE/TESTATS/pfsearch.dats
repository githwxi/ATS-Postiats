//
// Searching at-view proofs in records
//
// Author: Hongwei Xi (March 2013)
// Authoremail: gmhwxiATgmailDOTcom
//

(* ****** ****** *)

vtypedef
tptr (a:t@ype, l:addr) = (a @ l | ptr (l))

(* ****** ****** *)

fun{a:t0p}
tptr_get {l:addr} (tp: !tptr (a, l)): a = !(tp.1)
fun{a:t0p}
tptr_set {l:addr}
  (tp: !tptr (a?, l) >> tptr (a, l), x: a): void = !(tp.1) := x
// end of [tptr_set]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [pfsearch.dats] *)

(* ****** ****** *)
//
// HX-2013-08
//
// The following code showed a bug in ATS2,
// which has since been fixed. The bug caused
// the following code to form more than one
// linear closure.
//
// Try:
//
// valgrind ./qa-list-60
//
// to see that the
// created linear closure is freed after use.
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

implement
main0 () = let
  val cloptr = lam (x:int): int =<cloptr> x + 2
  val r = cloptr (78)
  val () = cloptr_free($UN.castvwtp0{cloptr0}(cloptr))
in
  println! ("res is : ", r)
end // end of [main0]

(* ****** ****** *)

(* end of [qa-list-60.dats] *)

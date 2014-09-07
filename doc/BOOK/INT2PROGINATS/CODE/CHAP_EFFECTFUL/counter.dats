(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

typedef
counter = '{
  get= () -<cloref1> int
, inc= () -<cloref1> void
, reset= () -<cloref1> void
} // end of [counter]

(* ****** ****** *)

fun newCounter
(
// argumentless
) : counter = let
  val count = ref<int> (0)
in '{
  get= lam () => !count
, inc= lam () => !count := !count + 1
, reset= lam () => !count := 0
} end // end of [newCounter]

(* ****** ****** *)

symelim .get // HX: avoid potential overloading

(* ****** ****** *)

implement
main0 () =
{
//
val
mycntr = newCounter()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
val () = mycntr.inc()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
val () = mycntr.inc()
//
val () = println! ("mycntr.count = ", mycntr.get())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [counter.dats] *)

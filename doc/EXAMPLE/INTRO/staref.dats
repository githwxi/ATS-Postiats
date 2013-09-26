//
// Statically allocated reference
//
// Author: Hongwei Xi (June, 2013)
//

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

local

var __count: int = 0 // it is statically allocated
val theCount =
  ref_make_viewptr{int}(view@(__count) | addr@(__count))
// end of [val]

in (* in of [local] *)

fun theCount_get (): int = !theCount

fun theCount_inc (): void = !theCount := !theCount + 1

fun theCount_getinc
  (): int = let
  val n = !theCount; val () = !theCount := n + 1 in (n)
end // end of [theCount_getind]

fun theCount_reset (): void = !theCount := 0

end // end of [local]

(* ****** ****** *)

implement
main0 () =
{
//
val () = assertloc (theCount_getinc () = 0)
val () = assertloc (theCount_getinc () = 1)
val () = assertloc (theCount_getinc () = 2)
//
} // end of [main0]

(* ****** ****** *)

(* end of [staref.dats] *)

(*
** for testing [prelude/array]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A = (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
val (pf | p) = arrayptr_takeout_viewptr (A)
val i = 2
val () = assertloc (p->[i] = i)
val () = p->[i] := ~i
val () = assertloc (p->[i] = ~i)
val () = array_interchange (!p, (i2sz)0, (i2sz)4)
val () = assertloc (p->[0] = 4 && p->[4] = 0)
//
prval () = arrayptr_addback (pf | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_array.dats] *)

(*
** for testing [prelude/arrayptr]
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
val A = (arrayptr)$arrpsz{int}(0, 1, 2, 3, 4)
val i = 2
val () = assertloc (A[i] = i)
val () = A[i] := ~i
val () = assertloc (A[i] = ~i)
val () = arrayptr_interchange (A, (i2sz)0, (i2sz)4)
val () = assertloc (A[0] = 4 && A[4] = 0)
val A = A // HX: a puzzling existential unpacking :)
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_arrayptr.dats] *)

(*
** for testing [prelude/pointer]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

val () =
{
//
val (
) = assertloc (NULL = $UNSAFE.cast{ptr}(0))
val (
) = assertloc (
  ptr_add<ptr> (nullp, 1) = ptr1_add_bsz (nullp, sizeof<ptr>)
) // end of [val]
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_pointer.dats] *)

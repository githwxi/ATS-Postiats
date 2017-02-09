(*
** for testing [prelude/pointer]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define nullp the_null_ptr

(* ****** ****** *)

val () =
{
//
val (
) = assertloc (nullp = $UNSAFE.cast{ptr}(0))
val (
) = assertloc (
  ptr_add<ptr> (nullp, 1) = add_ptr_bsz (nullp, sizeof<ptr>)
) // end of [val]
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val ap =
aptr_make_elt<int> (10)
//
val-10 = aptr_get_elt<int>(ap)
val () = aptr_set_elt<int>(ap, 2 * 10)
val-20 = aptr_getfree_elt(ap)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_pointer.dats] *)

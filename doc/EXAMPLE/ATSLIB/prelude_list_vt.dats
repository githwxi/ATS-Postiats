(*
** for testing [prelude/list_vt]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () =
{
val x0 = 0
val x1 = 1
val xs = nil_vt{int}()
val xs = cons_vt{int}(x0, cons_vt{int}(x1, xs))
val+~cons_vt (x, xs) = xs
val () = assertloc (x = x0)
val+~cons_vt (x, xs) = xs
val () = assertloc (x = x1)
val+~nil_vt () = xs
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val xs =
list_make_intrange (0, 10)
val xs = list_vt_cast{int}(xs)
val () = fprintln! (stdout_ref, "digits = ", xs)
val rxs = list_vt_reverse (xs)
val () = fprintln! (stdout_ref, "digits(rev) = ", rxs)
val () = list_vt_free (rxs)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list_vt.dats] *)

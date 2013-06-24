(*
** for testing [libats/ML/list0]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/list0.dats"
//
(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs = list0_make_intrange (0, 10)
val () = assertloc (xs[0] = 0)
val () = assertloc (xs[5] = 5)
val () = assertloc (xs[9] = 9)
val () = assertloc (list0_head_exn(xs) = 0)
val () = assertloc (list0_head_exn(list0_tail_exn(xs)) = 1)
//
val xs = list0_make_intrange (0, 30, 3)
val () = assertloc (xs[0] = 0)
val () = assertloc (xs[5] = 15)
val () = assertloc (xs[9] = 27)
val () = assertloc (list0_head_exn(xs) = 0)
val () = assertloc (list0_head_exn(list0_tail_exn(xs)) = 3)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val xs = (list0)$arrpsz{string}("a", "b", "c", "d", "e")
val () = assertloc (xs[0] = "a")
val () = assertloc (xs[1] = "b")
val () = assertloc (xs[2] = "c")
val () = assertloc (xs[3] = "d")
val () = assertloc (xs[4] = "e")
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val xs = (list0)$arrpsz{string}("a", "b", "c", "d", "e")
val xsxs = list0_append (xs, xs)
val () = assertloc (length (xsxs) = 2 * length (xs))
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_list0.dats] *)

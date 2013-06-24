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
val () = assertloc (list0_head_exn(xs) = 0)
val () = assertloc (list0_head_exn(list0_tail_exn(xs)) = 1)
val () = assertloc (xs[9] = 9)
val xs = list0_make_intrange (0, 30, 3)
val () = fprintln! (out, "multiples(3) = ", xs)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_list0.dats] *)

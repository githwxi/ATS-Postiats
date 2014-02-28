(*
** for testing [libats/ML/matrix0]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/matrix0.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/matrix0.dats"
//
(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val nrow = i2sz(3)
val ncol = i2sz(4)
val A_elt = matrix0_make_elt<int> (nrow, ncol, 0)
val () = fprintln! (out, "A_elt = ", A_elt)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val nrow = i2sz(3)
val ncol = i2sz(4)
val A_elt = matrix0_tabulate<int> (nrow, ncol, lam (i, j) => sz2i(i+j)+1)
val () = fprintln! (out, "A_elt = ", A_elt)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val nrow = i2sz(3)
val ncol = i2sz(4)
val A_elt = matrix0_make_elt<int> (nrow, ncol, 0)
//
val () = A_elt[2,3] := 1
val () = assertloc (A_elt[2][3] = 1)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_matrix0.dats] *)

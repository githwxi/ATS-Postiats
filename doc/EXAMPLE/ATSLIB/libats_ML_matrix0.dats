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
val nrow = i2sz(3)
and ncol = i2sz(4)
//
val A_elt =
  matrix0_make_elt<int> (nrow, ncol, 0)
//
val ((*void*)) = println! ("A_elt = ", A_elt)
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
val M_elt =
matrix0_tabulate<int>
  (nrow, ncol, lam (i, j) => sz2i(i+j)+1)
val () = fprintln! (out, "M_elt = ", M_elt)
//
val () =
  fprintln! (out, "M_elt.nrow = ", M_elt.nrow())
val () =
  fprintln! (out, "M_elt.ncol = ", M_elt.ncol())
//
var i: int and j: int
val () =
for (i := 0; i < 3; i := i+1) M_elt[i,0] := 0
val () =
for (j := 0; j < 4; j := j+1) M_elt[0,j] := 0
//
val () = fprintln! (out, "M_elt = ", M_elt)
//
val () = matrix0_iforeach (M_elt, lam (i, j, x) => x := 0)
//
val () = fprintln! (out, "M_elt = ", M_elt)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val nrow = i2sz(4)
val ncol = i2sz(4)
val M_elt =
matrix0_tabulate<int>
( nrow
, ncol
, lam (i, j) => sz2i(i)-sz2i(j))
//
val res =
matrix0_foldleft<int><int>
  (M_elt, 0, lam (res, x) => res + x)
//
val ((*void*)) = assertloc(res = 0)
//
val res =
matrix0_ifoldleft<int><int>
( M_elt
, 0 (* initial value *)
, lam (res, i, j, x) => res + sz2i(j)-sz2i(i))
//
val ((*void*)) = assertloc(res = 0)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_matrix0.dats] *)

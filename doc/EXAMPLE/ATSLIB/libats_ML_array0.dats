(*
** for testing [libats/ML/array0]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/array0.sats"

(* ****** ****** *)
//
staload _(*anon*) = "libats/ML/DATS/array0.dats"
//
(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val asz = i2sz(3)
val A_elt = array0_make_elt<int> (asz, 0)
val () = fprintln! (out, "A_elt = ", A_elt)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val asz = (i2sz)10
//
val A = array0_tabulate<int> (asz, lam i => $UN.cast{int}(i))
//
val out = stdout_ref
//
val () = fprintln! (out, "A = ", A)
//
val A2 = array0_map<int><int> (A, lam (x) => 2 * x)
//
local
implement
fprint_array$sep<> (out) = fprint (out, "| ")
in
val () = fprintln! (out, "A2 = ", A2)
end // end of [local]
//
val sum = array0_foldleft<int><int> (A, 0, lam (res, x) => res + x)
val () = fprintln! (out, "sum(45) = ", sum)
//
val isum = array0_ifoldleft<int><int> (A, 0, lam (res, i, x) => res + $UN.cast2int(i) * x)
val () = fprintln! (out, "isum(285) = ", isum)
//
val rsum = array0_foldright<int><int> (A, lam (x, res) => x + res, 0)
val () = fprintln! (out, "rsum(45) = ", rsum)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_array0.dats] *)

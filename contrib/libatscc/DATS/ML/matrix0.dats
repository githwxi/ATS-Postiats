(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
//
staload
"./../../SATS/ML/array0.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
assume
matrix0_vt0ype_type
  (a:vt0p) = mtrxszref(a)
//
(* ****** ****** *)
//
implement
matrix0_make_elt
(nrow, ncol, x0) =
mtrxszref_make_elt(nrow, ncol, x0)
//
(* ****** ****** *)
//
implement
matrix0_nrow
  {a}(M) = mtrxszref_get_nrow{a}(M)
implement
matrix0_ncol
  {a}(M) = mtrxszref_get_ncol{a}(M)
//
(* ****** ****** *)

(* end of [matrix0.dats] *)

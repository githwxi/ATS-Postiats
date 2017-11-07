(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
//
staload
"./../../SATS/ML/matrix0.sats"
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
{a}(nrow, ncol, x0) =
mtrxszref_make_elt{a}(nrow, ncol, x0)
//
(* ****** ****** *)
//
implement
matrix0_nrow(M) = mtrxszref_get_nrow(M)
implement
matrix0_ncol(M) = mtrxszref_get_ncol(M)
//
(* ****** ****** *)
//
implement
matrix0_get_at
  (M, i, j) = mtrxszref_get_at(M, i, j)
//
implement
matrix0_set_at
  (M, i, j, x0) = mtrxszref_set_at(M, i, j, x0)
//
(* ****** ****** *)
//
implement
matrix0_foreach
{a}(M0, fwork) =
mtrxszref_foreach_cloref{a}(M0, fwork)
implement
matrix0_foreach_row
{a}(M0, fwork) =
mtrxszref_foreach_row_cloref{a}(M0, fwork)
implement
matrix0_foreach_col
{a}(M0, fwork) =
mtrxszref_foreach_col_cloref{a}(M0, fwork)
//
implement
matrix0_foreach_method
{a}(M0) =
lam(fwork) => matrix0_foreach{a}(M0, fwork)
implement
matrix0_foreach_row_method
{a}(M0) =
lam(fwork) => matrix0_foreach_row{a}(M0, fwork)
implement
matrix0_foreach_col_method
{a}(M0) =
lam(fwork) => matrix0_foreach_col{a}(M0, fwork)
//
(* ****** ****** *)

(* end of [matrix0.dats] *)

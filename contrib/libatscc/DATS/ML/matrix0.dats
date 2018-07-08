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
//
implement
matrix0_tabulate
{a}{m,n}
(nrow, ncol, fopr) =
mtrxszref_tabulate_cloref{a}(nrow, ncol, fopr)
//
(* ****** ****** *)
//
implement
cbind_matrix0_matrix0
{a}(M0, M1) = let
//
val m0 = M0.nrow()
val m1 = M1.nrow()
val n0 = M0.ncol()
val n1 = M1.ncol()
val () = assertloc(m0 = m1)
//
val M0 = mtrxszref_get_matrixref(M0)
val M1 = mtrxszref_get_matrixref(M1)
//
in (* in-of-let *)
//
mtrxszref_make_matrixref
(
cbind_matrixref_matrixref{a}
($UN.cast(M0), $UN.cast(M1), m0, n0, n1), m0, n0+n1
) (* mtrxszref_make_matrixref *)
//
end // end of [cbind_matrix0_matrix0]
//
(* ****** ****** *)

(* end of [matrix0.dats] *)

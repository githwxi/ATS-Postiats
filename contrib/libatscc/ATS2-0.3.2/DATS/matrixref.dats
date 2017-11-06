(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/matrixref.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
implement
matrixref_exists_cloref
  (M, m, n, pred) =
(
  int2_exists_cloref
    (m, n, $UN.cast{cfun2(int,int,bool)}(pred))
  // int2_exists_cloref
)
implement
matrixref_forall_cloref
  (M, m, n, pred) =
(
  int2_forall_cloref
    (m, n, $UN.cast{cfun2(int,int,bool)}(pred))
  // int2_forall_cloref
)
//
(* ****** ****** *)
//
implement
matrixref_foreach_cloref
  (M, m, n, fwork) =
(
  int2_foreach_cloref
    (m, n, $UN.cast{cfun2(int,int,void)}(fwork))
  // int2_foreach_cloref
)
//
(* ****** ****** *)
//
// HX: matrix-with-size
//
(* ****** ****** *)
//
implement
mtrxszref_make_elt
  (m, n, x0) =
(
  mtrxszref_make_matrixref
    (matrixref_make_elt(m, n, x0), m, n)
  // mtrxszref_make_matrixref
) (* end of [mtrxszref_make_elt] *)
//
(* ****** ****** *)
//
implement
mtrxszref_exists_cloref
  (MSZ, ftest) = let
  val m = MSZ.nrow()
  val n = MSZ.ncol()
in
//
int2_exists_cloref
  (m, n, $UN.cast{cfun2(int,int,bool)}(ftest))
//
end // end of [mtrxszref_exists_cloref]
//
(* ****** ****** *)
//
implement
mtrxszref_forall_cloref
  (MSZ, ftest) = let
  val m = MSZ.nrow()
  val n = MSZ.ncol()
in
//
int2_forall_cloref
  (m, n, $UN.cast{cfun2(int,int,bool)}(ftest))
//
end // end of [mtrxszref_forall_cloref]
//
(* ****** ****** *)
//
implement
mtrxszref_exists_method
  (MSZ) =
(
  lam(ftest) =>
    mtrxszref_exists_cloref(MSZ, ftest)
  // end of [lam]
)
implement
mtrxszref_forall_method
  (MSZ) =
(
  lam(ftest) =>
    mtrxszref_forall_cloref(MSZ, ftest)
  // end of [lam]
)
//
(* ****** ****** *)
//
implement
mtrxszref_foreach_cloref
  (MSZ, fwork) = let
  val m = MSZ.nrow()
  val n = MSZ.ncol()
in
//
int2_foreach_cloref
  (m, n, $UN.cast{cfun2(int,int,void)}(fwork))
//
end // end of [mtrxszref_foreach_cloref]
//
implement
mtrxszref_foreach_method
  {a}(MSZ) =
(
  lam(fwork) => mtrxszref_foreach_cloref{a}(MSZ, fwork)
) (* end of [mtrxszref_foreach_method] *)
//
(* ****** ****** *)
//
implement
mtrxszref_foreach_row_cloref
  (MSZ, fwork) = let
  val m = MSZ.nrow()
  val n = MSZ.ncol()
in
//
int2_foreach_cloref
(m, n, $UN.cast{cfun2(int,int,void)}(fwork))
//
end // end of [mtrxszref_foreach_row_cloref]
//
implement
mtrxszref_foreach_row_method
  {a}(MSZ) =
(
  lam(fwork) => mtrxszref_foreach_row_cloref{a}(MSZ, fwork)
) (* end of [mtrxszref_foreach_row_method] *)
//
(* ****** ****** *)
//
implement
mtrxszref_foreach_col_cloref
  (MSZ, fwork) = let
  val m = MSZ.nrow()
  val n = MSZ.ncol()
in
//
int2_foreach_cloref
( n, m
, lam(j: int, i: int) =>
  fwork($UN.cast{Nat}(i), $UN.cast{Nat}(j))
) (* end of [int2_foreach_cloref] *)
//
end // end of [mtrxszref_foreach_col_cloref]
//
implement
mtrxszref_foreach_col_method
  {a}(MSZ) =
(
  lam(fwork) => mtrxszref_foreach_col_cloref{a}(MSZ, fwork)
) (* end of [mtrxszref_foreach_col_method] *)
//
(* ****** ****** *)

(* end of [matrixref.dats] *)

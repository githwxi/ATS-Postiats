(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
fun
matrixref_make_elt
  {a:t@ype}{m,n:nat}
  (int(m), int(n), a): matrixref(a, m, n) = "mac#%"
//
(* ****** ****** *)
//
fun
matrixref_get_at
  {a:t@ype}{m,n:int}
(
  matrixref(a, m, n), natLt(m), int(n), natLt(n)
) : a = "mac#%" // end-of-function
//
fun
matrixref_set_at
  {a:t@ype}{m,n:int}
(
  matrixref(a, m, n), natLt(m), int(n), natLt(n), a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)

overload [] with matrixref_get_at of 100
overload [] with matrixref_set_at of 100

(* ****** ****** *)
//
fun
matrixref_exists_cloref
  {a:vt@ype}{m,n:int}
(
  matrixref(a, m, n)
, int(m), int(n), ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
//
fun
matrixref_forall_cloref
  {a:vt@ype}{m,n:int}
(
  matrixref(a, m, n)
, int(m), int(n), ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
matrixref_foreach_cloref
  {a:vt@ype}{m,n:int}
(
  matrixref(a, m, n)
, int(m), int(n), fwork: (natLt(m), natLt(n)) -<cloref1> void
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
// HX: matrix-with-size
//
(* ****** ****** *)
//
fun
mtrxszref_make_elt
  {a:t0p}{m,n:nat}
  (int(m), int(n), x0: a): mtrxszref(a) = "mac#%"
//
fun
mtrxszref_make_matrixref
  {a:vt0p}{m,n:int}
  (matrixref(a, m, n), int(m), int(n)): mtrxszref(a) = "mac#%"
// end of [mtrxszref_make_matrixref]
//
(* ****** ****** *)
//
fun
mtrxszref_get_nrow
{a:vt0p}(mtrxszref(a)): intGte(0) = "mac#%"
fun
mtrxszref_get_ncol
{a:vt0p}(mtrxszref(a)): intGte(0) = "mac#%"
//
overload .nrow with mtrxszref_get_nrow of 100
overload .ncol with mtrxszref_get_ncol of 100
//
(* ****** ****** *)
//
fun
mtrxszref_get_at
{a:t0p}(mtrxszref(a), i: int, j: int): a = "mac#%"
fun
mtrxszref_set_at
{a:t0p}(mtrxszref(a), i: int, j: int, x: a): void = "mac#%"
//
(* ****** ****** *)

overload [] with mtrxszref_get_at of 100
overload [] with mtrxszref_set_at of 100

(* ****** ****** *)
//
fun
mtrxszref_exists_cloref
  {a:t@ype}
(
  mtrxszref(a), ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
mtrxszref_exists_method
  {a:t@ype}
(
  mtrxszref(a))(ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
//
fun
mtrxszref_forall_cloref
  {a:t@ype}
(
  mtrxszref(a), ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
mtrxszref_forall_method
  {a:t@ype}
(
  mtrxszref(a))(ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
//
overload .exists with mtrxszref_exists_method
overload .forall with mtrxszref_forall_method
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_cloref
  {a:vt@ype}
(
  M: mtrxszref(a), fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_method
  {a:vt@ype}
(
  M: mtrxszref(a))(fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload .foreach with mtrxszref_foreach_method
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_row_cloref
  {a:vt@ype}
(
  M: mtrxszref(a), fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_row_method
  {a:vt@ype}
(
  M: mtrxszref(a))(fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload .foreach_row with mtrxszref_foreach_row_method
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_col_cloref
  {a:vt@ype}
(
  M: mtrxszref(a), fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_col_method
  {a:vt@ype}
(
  M: mtrxszref(a))(fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload .foreach_col with mtrxszref_foreach_col_method
//
(* ****** ****** *)

(* end of [matrixref.sats] *)

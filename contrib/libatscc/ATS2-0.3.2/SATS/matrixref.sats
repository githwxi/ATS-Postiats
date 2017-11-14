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
  matrixref(a, m, n), int(m), int(n)
, ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
//
fun
matrixref_forall_cloref
  {a:vt@ype}{m,n:int}
(
  matrixref(a, m, n), int(m), int(n)
, ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
matrixref_foreach_cloref
  {a:vt@ype}{m,n:int}
(
  matrixref(a, m, n), int(m), int(n)
, fwork: (natLt(m), natLt(n)) -<cloref1> void
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
matrixref_tabulate_cloref
  {a:vt@ype}{m,n:nat}
(
  int(m), int(n), fopr: (natLt(m), natLt(n)) -<cloref1> a
) : matrixref(a, m, n) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
cbind_matrixref_matrixref
  {a:t@ype}{m0,n1,n2:int}
( M1: matrixref(a, m0, n1)
, M2: matrixref(a, m0, n2)
, m0: int(m0), n1: int(n1), n2: int(n2)): matrixref(a, m0, n1+n2) = "mac#%"
fun
rbind_matrixref_matrixref
  {a:t@ype}{m1,m2,n0:int}
( M1: matrixref(a, m1, n0)
, M2: matrixref(a, m2, n0)
, m1: int(m1), m2: int(m2), n0: int(n0)): matrixref(a, m1+m2, n0) = "mac#%"
//
overload cbind with cbind_matrixref_matrixref
overload rbind with rbind_matrixref_matrixref
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
mtrxszref_get_matrixref
  {a:t0p}
(
  MSZ: mtrxszref(a)
) : [m:nat;n:nat] matrixref(a, m, n) = "mac#%"
//
(* ****** ****** *)
//
fun
mtrxszref_make_matrixref
  {a:t0p}{m,n:int}
  (matrixref(a, m, n), int(m), int(n)): mtrxszref(a) = "mac#%"
// end of [mtrxszref_make_matrixref]
//
(* ****** ****** *)
//
fun
mtrxszref_get_at
{a:t0p}
(MSZ: mtrxszref(a), i: int, j: int): a = "mac#%"
fun
mtrxszref_set_at
{a:t0p}
(MSZ: mtrxszref(a), i: int, j: int, x: a): void = "mac#%"
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
  MSZ: mtrxszref(a)
, ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
mtrxszref_exists_method
  {a:t@ype}
(
  MSZ: mtrxszref(a)
)
(
  ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
//
overload
.exists with mtrxszref_exists_method of 100
//
(* ****** ****** *)
//
fun
mtrxszref_forall_cloref
  {a:t@ype}
( MSZ: mtrxszref(a)
, ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
fun
mtrxszref_forall_method
  {a:t@ype}
(
  MSZ: mtrxszref(a)
)
(
  ftest: (Nat, Nat) -<cloref1> bool
) : bool = "mac#%" // end-of-function
//
overload
.forall with mtrxszref_forall_method of 100
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_cloref
  {a:vt@ype}
( MSZ: mtrxszref(a)
, fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_method
  {a:vt@ype}
(
  MSZ: mtrxszref(a)
)
(
  fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload
.foreach with mtrxszref_foreach_method of 100
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_row_cloref
  {a:vt@ype}
( MSZ: mtrxszref(a)
, fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_row_method
  {a:vt@ype}
(
  MSZ: mtrxszref(a)
)
(
  fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload
.foreach_row with mtrxszref_foreach_row_method of 100
//
(* ****** ****** *)
//
fun
mtrxszref_foreach_col_cloref
  {a:vt@ype}
( MSZ: mtrxszref(a)
, fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
fun
mtrxszref_foreach_col_method
  {a:vt@ype}
(
  MSZ: mtrxszref(a)
)
(
  fwork: (Nat, Nat) -<cloref1> void
) : void = "mac#%" // end-of-function
//
overload
.foreach_col with mtrxszref_foreach_col_method of 100
//
(* ****** ****** *)
//
fun
mtrxszref_tabulate_cloref
  {a:vt0p}{m,n:nat}
( nrow: int(m), ncol: int(n)
, fopr: (natLt(m), natLt(n)) -<cloref1> (a)): mtrxszref(a) = "mac#%"
//
(* ****** ****** *)

(* end of [matrixref.sats] *)

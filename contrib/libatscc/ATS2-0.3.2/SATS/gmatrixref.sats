(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)

abstype
gmatrixref(a:t@ype, m:int, n:int)

(* ****** ****** *)
//
fun
gmatrixref_make_matrixref
  {a:t@ype}{m,n:nat}
(
  matrixref(a, m, n), m: int(m), n: int(n)
) : gmatrixref(a, m, n) = "mac#%"
//
(* ****** ****** *)
//
fun
gmatrixref_make_subregion
  {a:t@ype}
  {m0,n0:int}
  {i0,j0,m,n:nat |
   i0+m <= m0; j0+n <= n0}
(
  gmatrixref(a, m0, n0)
, i0: int(i0), j0: int(j0), m: int(m), n: int(n)
) : gmatrixref(a, m, n) = "mac#%"
//
(* ****** ****** *)
//
fun
gmatrixref_get_at
  {a:t@ype}
  {m,n:int}
(
  gmatrixref(a, m, n), i: natLt(m), j: natLt(n)
) : a = "mac#%" // end-of-function
//
fun
gmatrixref_set_at
  {a:t@ype}
  {m,n:int}
(
  gmatrixref(a, m, n), i: natLt(m), j: natLt(n), x: a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)

overload [] with gmatrixref_get_at of 100
overload [] with gmatrixref_set_at of 100

(* ****** ****** *)
//
fun
gmatrixref_exists_cloref
  {a:t@ype}{m,n:int}
(
  gmatrixref(a, m, n), ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
fun
gmatrixref_forall_cloref
  {a:t@ype}{m,n:int}
(
  gmatrixref(a, m, n), ftest: (natLt(m), natLt(n)) -<cloref1> bool
) : bool = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
gmatrixref_foreach_cloref
  {a:t@ype}{m,n:int}
(
  gmatrixref(a, m, n), fwork: (natLt(m), natLt(n)) -<cloref1> void
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)

(* end of [gmatrixref.sats] *)

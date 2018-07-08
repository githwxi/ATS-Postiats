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
assume
gmatrixref
(
  a, m, n
) = // gmatrixref
[ m0,n0:int;i0,j0:nat
| i0+m <= m0; j0+n <= n0
] $tup(
    matrixref(a, m0, n0)
  , int(m0), int(n0), int(i0), int(j0), int(m), int(n)
  ) (* $tup *)
//
(* ****** ****** *)
//
implement
gmatrixref_make_matrixref
  (M, m, n) = $tup(M, m, n, 0, 0, m, n)
//
(* ****** ****** *)
//
implement
gmatrixref_make_subregion
  (GM, i0, j0, m, n) =
(
  $tup(GM.0, GM.1, GM.2, (GM.3)+i0, (GM.4)+j0, m, n)
)
//
(* ****** ****** *)
//
implement
gmatrixref_get_at
  (GM, i, j) =
  matrixref_get_at(GM.0, (GM.3)+i, GM.2, (GM.4)+j)
implement
gmatrixref_set_at
  (GM, i, j, x) =
  matrixref_set_at(GM.0, (GM.3)+i, GM.2, (GM.4)+j, x)
//
(* ****** ****** *)
//
implement
gmatrixref_exists_cloref
  (GM, f) =
(
  int2_exists_cloref(GM.3, GM.4, $UN.cast{cfun2(int,int,bool)}(f))
)
implement
gmatrixref_forall_cloref
  (GM, f) =
(
  int2_forall_cloref(GM.3, GM.4, $UN.cast{cfun2(int,int,bool)}(f))
)
//
(* ****** ****** *)
//
implement
gmatrixref_foreach_cloref
  (GM, f) =
(
  int2_foreach_cloref(GM.3, GM.4, $UN.cast{cfun2(int,int,void)}(f))
)
//
(* ****** ****** *)

(* end of [matrixref.dats] *)

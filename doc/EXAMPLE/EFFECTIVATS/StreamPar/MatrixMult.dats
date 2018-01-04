(* ****** ****** *)
//
// HX: For StreamPar
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"libats/BUCS520/StreamPar/mydepies.hats"
#include
"libats/BUCS520/StreamPar/mylibies.hats"
//
(* ****** ****** *)
//
#staload
FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
extern
fun
streamize_int_cross
  {m,n:nat}
  (m: int(m), n:int(n)): stream_vt(@(natLt(m), natLt(n)))
//
(* ****** ****** *)
(*
//
extern
fun
{a:vt@ype}
{b:vt@ype}
{r:vt@ype}
streampar_mapfold_cloref
( fws: fworkshop
, xs0: stream_vt(INV(a))
, res: r, map: cfun(a, b), fold: cfun(b, r, r)): (r)
//
*)
(* ****** ****** *)
//
extern
fun
{a:t0p}
mat_addby_mul
  {p,q,r:nat}
( W: $FWS.fworkshop
, A: matrixref(a, p, r)
, B: matrixref(a, p, q)
, C: matrixref(a, q, r)
, p: int(p), q: int(q), r: int(r)
): void // end of [mat_addby_mul]
//
(* ****** ****** *)

implement
{a}(*tmp*)
mat_addby_mul
{p, q, r}
(W, A, B, C, p, q, r) = let
//
val
add=gadd_val_val<a>
val
mul=gmul_val_val<a>
//
overload + with add
overload * with mul
//
fun
f2{k:nat | k <= q}
( i: natLt(p)
, j: natLt(r), k: int(k), x: a): a =
if
(k >= q)
then (x)
else f2(i, j, k+1, x+(B[i,q,k]*C[k,r,j]))
//
in
$StreamPar.streampar_foreach_cloref<(natLt(p),natLt(r))>
  ( W
  , streamize_int_cross(p, r)
  , lam(@(i,j)) => A[i,r,j] := f2(i, j, 0, A[i,r,j]))
end // end of [mat_addby_mul]

(* ****** ****** *)

(* end of [MatrixMult.dats] *)

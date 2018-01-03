(* ****** ****** *)
//
// HX: For StreamPar
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
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
  {p,q,r:int}
( p: int(p)
, q: int(q)
, r: int(r)
, A: matrix(a, p, r)
, B: matrix(a, p, q)
, C: matrix(a, q, r)): void
//
(* ****** ****** *)

implement
{a}(*tmp*)
mat_addby_mul
{p, q, r}
(p, q, r, A, B, C) = let
//
fun
f2(i: natLt(p), j: natLt(q)): void =
int_foldleft_
//
//
end // end of [mat_addby_mul]

(* ****** ****** *)

(* end of [MatrixMult.dats] *)

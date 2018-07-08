(* ****** ****** *)
//
// HX:
// For testing StreamPar
//
(* ****** ****** *)

%{^
//
#include <pthread.h>
//
#ifdef ATS_MEMALLOC_GCBDW
#undef GC_H
#define GC_THREADS
#include <gc/gc.h>
#endif // #if(ATS_MEMALLOC_GCBDW)
//
%} // end of [%{^]

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
fun{}
streamize_int_cross
  {m,n:nat}
(
 m: int(m), n: int(n)
) : stream_vt(@(natLt(m), natLt(n)))
//
(* ****** ****** *)

implement
{}(*tmp*)
streamize_int_cross
  (m, n) = let
//
typedef int2 = (int, int)
//
fun
aux1
(
 i: int
) : stream_vt(int2) = $ldelay
(
if
i < m
then !(aux2(i, 0))
else stream_vt_nil((*void*))
)
and
aux2
(
 i: int, j: int
) : stream_vt(int2) = $ldelay
(
if
(j >= n)
then
!(aux1(i+1))
else
stream_vt_cons((i, j), aux2(i, j+1))
)
//
in
  $UN.castvwtp0(aux1(0))
end // end of [streamize_int_cross]

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
( fws
, A, B, C
, p, q, r) = let
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
  ( fws
  , streamize_int_cross(p, r)
  , lam(@(i,j)) => A[i,r,j] := f2(i, j, 0, A[i,r,j]))
end // end of [mat_addby_mul]

(* ****** ****** *)
//
implement
main0() = () where
{
//
val n = 1000
val M = i2sz(n)
val N = i2sz(n)
//
val A =
matrixref_make_elt<int>(M, N, 0)
val B =
matrixref_make_elt<int>(M, N, 1)
val C =
matrixref_make_elt<int>(M, N, 2)
//
#define NW 2
//
val
fws =
$FWS.fworkshop_create_exn()
//
val
nadded =
$FWS.fworkshop_add_nworker(fws, NW)
val () =
prerrln!
("the number of workers = ", nadded)
//
(*
val () =
fprint_matrixref_sep
(stdout_ref, A, M, N, ",", "\n")
val () =
fprintln!(stdout_ref)
val () =
fprint_matrixref_sep
(stdout_ref, B, M, N, ",", "\n")
val () =
fprintln!(stdout_ref)
val () =
fprint_matrixref_sep
(stdout_ref, C, M, N, ",", "\n")
val () =
fprintln!(stdout_ref)
*)
//
val () =
mat_addby_mul<int>(fws, A, B, C, n, n, n)
//
(*
val () =
fprint_matrixref_sep
(stdout_ref, A, M, N, ",", "\n")
val () =
fprintln!(stdout_ref)
*)
//
} (* end of [main0] *)
//
(* ****** ****** *)

(* end of [MatMult.dats] *)

(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_PHParray_"
//
(* ****** ****** *)
//
// PHP datatypes
//
#staload "./../basics_php.sats"
//
(* ****** ****** *)
//
fun
PHParray_nil
  {a:t0p}(): PHParray(a) = "mac#%"
fun
PHParray_sing
  {a:t0p}(x: a): PHParray(a) = "mac#%"
fun
PHParray_pair
  {a:t0p}(x1: a, x2: a): PHParray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParray_size
  {a:t0p}(A0: PHParray(a)): intGte(0) = "mac#%"
//
overload size with PHParray_size of 100
overload .size with PHParray_size of 100
//
(* ****** ****** *)
//
fun
PHParray_get_at
  {a:t0p}(A: PHParray(a), i: int): a = "mac#%"
//
overload [] with PHParray_get_at of 100
//
(* ****** ****** *)
//
fun
PHParray2list
  {a:t0p}(A: PHParray(a)): List0(a) = "mac#%"
fun
PHParray2list_rev
  {a:t0p}(A: PHParray(a)): List0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParray2list_map
  {a:t0p}{b:t0p}
  (A: PHParray(a), fopr: cfun(a, b)): List0(b) = "mac#%"
fun
PHParray2list_map_rev
  {a:t0p}{b:t0p}
  (A: PHParray(a), fopr: cfun(a, b)): List0(b) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParray_streamize_elt
  {a:t0p}(A: PHParray(a)): stream_vt(a) = "mac#%"
//
(* ****** ****** *)

(* end of [PHParray.sats] *)

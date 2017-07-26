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
PHParray_get_at
  {a:t0p}(A: PHParray(a), i: int): a = "mac#%"
//
overload [] with PHParray_get_at of 100
//
(* ****** ****** *)

(* end of [PHParray.sats] *)

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
//
(* ****** ****** *)
//
// Python datatypes
//
#staload "./../basics_php.sats"
//
(* ****** ****** *)
//
fun
PHParray_nil{a:t0p}(): PHParray(a) = "mac#"
fun
PHParray_sing{a:t0p}(x: a): PHParray(a) = "mac#"
fun
PHParray_pair{a:t0p}(x1: a, x2: a): PHParray(a) = "mac#"
//
(* ****** ****** *)

(* end of [PHParray.sats] *)

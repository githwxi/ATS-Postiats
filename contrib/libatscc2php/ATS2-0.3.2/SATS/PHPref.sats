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
PHPref_new{a:vt0p}(x: a): PHPref(a) = "mac#"
fun
PHPref_make_elt{a:vt0p}(x: a): PHPref(a) = "mac#"
//
(* ****** ****** *)
//
fun
PHPref_get_elt{a:t0p}(ref: PHPref(a)): a = "mac#"
fun
PHPref_set_elt{a:t0p}(ref: PHPref(a), x0: a): void = "mac#"
//
fun
PHPref_exch_elt{a:vt0p}(ref: PHPref(a), x0: a): (a) = "mac#"
//
(* ****** ****** *)

overload [] with PHPref_get_elt
overload [] with PHPref_set_elt

(* ****** ****** *)

(* end of [PHPref.sats] *)

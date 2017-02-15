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
PHParref_nil
  {a:vt0p}(): PHParref(a) = "mac#%"
//
fun
PHParref_sing
  {a:vt0p}(x: a): PHParref(a) = "mac#%"
//
fun
PHParref_pair
  {a:vt0p}(x1: a, x2: a): PHParref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_is_nil
  {a:vt0p}(PHParref(a)): bool = "mac#%"
//
fun
PHParref_isnot_nil
  {a:vt0p} (PHParref(a)): bool = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_make_elt{a:t0p}
  (asz: intGte(0), x0: a): PHParref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_size{a:vt0p}(PHParref(a)): intGte(0) = "mac#%"
fun
PHParref_length{a:vt0p}(PHParref(a)): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_get_at
  {a:t0p}(A: PHParref(a), i: int): a = "mac#%"
//
fun
PHParref_set_at
  {a:t0p}(A: PHParref(a), i: int, x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_unset
  {a:t0p}(A: PHParref(a), index: int): void = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_extend{a:t0p}(A: PHParref(a), x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_copy{a:t0p}(PHParref(a)): PHParref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_values{a:t0p}(PHParref(a)): PHParref(a) = "mac#%"
//
(* ****** ****** *)

(* end of [PHParref.sats] *)

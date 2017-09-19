(* ****** ****** *)
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
ATS_STATIC_PREFIX "_ats2phppre_PHParref_"
//
(* ****** ****** *)
//
#staload
"./../basics_php.sats" // PHP datatypes
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
  {a:vt0p}(PHParref(a)): bool = "mac#%"
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
PHParref_make_list
  {a:t0p}(xs: List(INV(a))): PHParref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_size
  {a:vt0p}(PHParref(a)): intGte(0) = "mac#%"
fun
PHParref_length
  {a:vt0p}(PHParref(a)): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_get_at
  {a:t0p}(A: PHParref(a), i: int): a = "mac#%"
//
fun
PHParref_set_at
  {a:t0p}
  (A: PHParref(a), i: int, x: a): void = "mac#%"
//
(* ****** ****** *)

overload [] with PHParref_get_at of 100
overload [] with PHParref_set_at of 100

(* ****** ****** *)
//
fun
PHParref_unset
  {a:t0p}
  (A: PHParref(a), index: int): void = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_extend
  {a:t0p}(A: PHParref(a), x0: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_copy
  {a:t0p}(A0: PHParref(a)): PHParref(a) = "mac#%"
fun
PHParref_values
  {a:t0p}(A0: PHParref(a)): PHParref(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref2array
  {a:t0p}(A0: PHParref(a)): PHParray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref2list
  {a:t0p}(A: PHParref(a)): List0(a) = "mac#%"
fun
PHParref2list_rev
  {a:t0p}(A: PHParref(a)): List0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_streamize_elt
  {a:t0p}(A: PHParref(a)): stream_vt(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PHParref_join
  {a:t0p}(A: PHParref(a)): string = "mac#%"
fun
PHParref_join_sep
  {a:t0p}(A: PHParref(a), sep: string): string = "mac#%"
//
(* ****** ****** *)

(* end of [PHParref.sats] *)

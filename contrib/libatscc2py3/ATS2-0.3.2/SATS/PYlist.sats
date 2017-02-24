(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)
//
// Python datatypes
//
#staload "./../basics_py.sats"
//
(* ****** ****** *)
//
fun
PYlist_nil
  {a:vt0p}(): PYlist(a) = "mac#%"
//
fun
PYlist_sing
  {a:vt0p}(x: a): PYlist(a) = "mac#%"
//
fun
PYlist_pair
  {a:vt0p}(x1: a, x2: a): PYlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_cons
  {a:vt0p}(x0: a, xs: PYlist(a)): void = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_make_elt
  {a:t0p}{n:nat}(n: int(n), x0: a): PYlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_is_nil
  {a:vt0p}(xs: PYlist(a)): bool = "mac#%"
//
fun
PYlist_is_cons
  {a:vt0p}(xs: PYlist(a)): bool = "mac#%"
//
fun
PYlist_isnot_nil
  {a:vt0p}(xs: PYlist(a)): bool = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_length{a:vt0p}(PYlist(a)): int = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_get_at
  {a:t0p}(xs: PYlist(a), i: int): a = "mac#%"
fun
PYlist_set_at
  {a:t0p}(xs: PYlist(a), i: int, x0: a): void = "mac#%"
//
fun
PYlist_exch_at
  {a:vt0p}(xs: PYlist(a), i: int, x0: a): (a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_copy
  {a:t@ype}(PYlist(a)): PYlist(a) = "mac#%"
//
(* ****** ****** *)
//
// HX-2015-07:
// Note that [append] and [extend] are used
// in precisely the opposite manner as in ATS
//
fun
PYlist_append
  {a:vt0p}(xs1: PYlist(a), x2: a): void = "mac#%"
//
fun
PYlist_extend
  {a:t@ype}(xs1: PYlist(a), xs2: PYlist(a)): void = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_pop_0
  {a:vt0p}(xs: PYlist(a)): (a) = "mac#%"
fun
PYlist_pop_1
  {a:vt0p}(xs: PYlist(a), i: intGte(0)): (a) = "mac#%"
//
symintr PYlist_pop
overload PYlist_pop with PYlist_pop_0
overload PYlist_pop with PYlist_pop_1
//  
(* ****** ****** *)
//
fun
PYlist_insert{a:vt0p}
  (xs: PYlist(a), i: intGte(0), x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_reverse{a:vt0p} (xs: PYlist(a)): void = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_map
  {a:t0p}{b:t0p}
  (xs: PYlist(a), f: (a) -> b): PYlist(b) = "mac#%"
//
fun
PYlist_map2
  {a1,a2:t0p}{b:t0p}
(
  xs1: PYlist(a1), xs2: PYlist(a2), f: (a1, a2) -> b
) : PYlist(b) = "mac#%" // end of [PYlist_map2]
//
(* ****** ****** *)
//
fun
PYlist_filter{a:t0p}
  (xs: PYlist(a), p: (a) -> bool): PYlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_reduce
  {a:t0p}{b:t0p}
  (xs: PYlist(b), ini: a, f: (a, b) -> a): (a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist2list{a:t0p} (xs: PYlist(a)): List0(a) = "mac#%"
fun
PYlist2list_rev{a:t0p} (xs: PYlist(a)): List0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PYlist_string_join(xs: PYlist(string)): string = "mac#%"
//
(* ****** ****** *)
//
// HX-2016-05-25:
// Implemented in [list.dats]
//
fun
PYlist_oflist{a:t0p}(xs: List(INV(a))): PYlist(a) = "mac#%"
fun
PYlist_oflist_rev{a:t0p}(xs: List(INV(a))): PYlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p}
PYlist_sort_1(xs: PYlist(a)): void // = "mac#%"
fun
PYlist_sort_2{a:t0p}
  (xs: PYlist(a), cmp: (a, a) -<cloref1> int): void = "mac#%"
//
(* ****** ****** *)
//
// Some function overloading
//
(* ****** ****** *)
//
overload [] with PYlist_get_at
overload [] with PYlist_set_at
//
(* ****** ****** *)

overload .pop with PYlist_pop
overload .push with PYlist_append

(* ****** ****** *)

overload length with PYlist_length

(* ****** ****** *)

(* end of [PYlist.sats] *)

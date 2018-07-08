(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
//
(* ****** ****** *)
//
// Clojure datatypes
//
staload "./../basics_clj.sats"
//
(* ****** ****** *)
//
fun
CLJlist_nil
  {a:t0p}(): CLJlist(a) = "mac#%"
//
fun
CLJlist_cons
  {a:t0p}
(
  x0: a, xs: CLJlist(INV(a))
) : CLJlist(a) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
CLJlist_sing
  {a:t0p}(x: a): CLJlist(a) = "mac#%"
//
fun
CLJlist_pair
  {a:t0p}(x1: a, x2: a): CLJlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun
CLJlist_make_elt
  {a:t0p}{n:nat}
  (n: int(n), x0: a): CLJlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun
CLJlist_is_nil
  {a:t0p}(CLJlist(INV(a))): bool = "mac#%"
//
fun
CLJlist_is_cons
  {a:t0p}(CLJlist(INV(a))): bool = "mac#%"
//
fun
CLJlist_isnot_nil
  {a:t0p}(CLJlist(INV(a))): bool = "mac#%"
//
(* ****** ****** *)
//
fun
CLJlist_length
  {a:t0p}(xs: CLJlist(INV(a))): int = "mac#%"
//
(* ****** ****** *)
//
fun
CLJlist2list
  {a:t0p}(CLJlist(INV(a))): List0(a) = "mac#%"
fun
CLJlist2list_rev
  {a:t0p}(CLJlist(INV(a))): List0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
CLJlist_oflist
  {a:t0p}(xs: List(INV(a))): CLJlist(a) = "mac#%"
fun
CLJlist_oflist_rev
  {a:t0p}(xs: List(INV(a))): CLJlist(a) = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p}
CLJlist_sort_1
  (xs: CLJlist(INV(a))): CLJlist(a)
fun
CLJlist_sort_2{a:t0p}
(
  xs: CLJlist(INV(a)), cmp: (a, a) -<cloref1> int
) : CLJlist(a) = "mac#%" // end-of-function
//
(* ****** ****** *)

(* end of [CLJlist.sats] *)

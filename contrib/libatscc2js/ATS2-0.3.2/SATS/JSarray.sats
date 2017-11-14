(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)

#staload "./../basics_js.sats"

(* ****** ****** *)
//
macdef
Array = $extval(JSobj, "Array")
//
(* ****** ****** *)
//
fun
JSarray_nil
  {a:vt0p}(): JSarray(a) = "mac#%"
fun
JSarray_sing
  {a:vt0p}(a): JSarray(a) = "mac#%"
fun
JSarray_pair
  {a:vt0p}(a, a): JSarray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_make_list
  {a:t0p}(List(INV(a))): JSarray(a) = "mac#%"
fun
JSarray_make_list_vt
  {a:vt0p}(List_vt(INV(a))): JSarray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_get_at
  {a:t0p}(JSarray(a), int): a = "mac#%"
fun
JSarray_set_at
  {a:t0p}(JSarray(a), int, a): void = "mac#%"
//
fun
JSarray_exch_at
  {a:vt0p}(JSarray(a), int, x0: a): (a) = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_length{a:vt0p}(JSarray(a)): int = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_pop{a:vt0p}(A: JSarray(a)): a = "mac#%"
fun
JSarray_push{a:vt0p}(A: JSarray(a), x: a): int = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_shift{a:vt0p}(A: JSarray(a)): (a) = "mac#%"
fun
JSarray_unshift{a:vt0p}(A: JSarray(a), x0: a): int = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_reverse{a:vt0p}(A: JSarray(a)): void = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_copy{a:t@ype}(JSarray(a)): JSarray(a) = "mac#%"
//
fun
JSarray_copy_arrayref
  {a:t@ype}{n:int}
  (A: arrayref(a, n), asz: int(n)): JSarray(a) = "mac#"
//
(* ****** ****** *)
//
fun
JSarray_concat{a:t@ype}
  (A1: JSarray(a), A2: JSarray(a)): JSarray(a) = "mac#%"
//
(* ****** ****** *)
//
// HX: these are based on [splice]
//
fun
JSarray_insert_at
  {a:vt0p}(JSarray(a), int, a): void = "mac#%"
//
fun
JSarray_takeout_at
  {a:vt0p}(JSarray(a), ofs: int): (a) = "mac#%"
//
fun
JSarray_remove_at
  {a:t@ype}(JSarray(a), ofs: int): void = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_tabulate_cloref
  {a:vt0p}{n:nat}
  (int(n), cfun(natLt(n), a)): JSarray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
JSarray_join
  {a:t@ype}(JSarray(a)): string = "mac#%"
fun
JSarray_join_sep
  {a:t@ype}(JSarray(a), sep: string): string = "mac#%"
//
(* ****** ****** *)
//
fun{a:t0p}
JSarray_sort_1(A: JSarray(a)): void
fun
JSarray_sort_2{a:t0p}
  (A: JSarray(a), cmp: (a, a) -<cloref1> int): void = "mac#%"
//
(* ****** ****** *)
//
// Some function overloading
//
(* ****** ****** *)
//
overload [] with JSarray_get_at
overload [] with JSarray_set_at
//
(* ****** ****** *)
//
overload .pop with JSarray_pop
overload .push with JSarray_push
//
(* ****** ****** *)

overload length with JSarray_length

(* ****** ****** *)

(* end of [JSarray.sats] *)

(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-11-17:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)

staload "./../basics_pl.sats"

(* ****** ****** *)
//
fun
PLarray_nil{a:vt0p}(): PLarray(a) = "mac#%"
fun
PLarray_sing{a:vt0p}(a): PLarray(a) = "mac#%"
fun
PLarray_pair{a:vt0p}(a, a): PLarray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PLarray_get_at
  {a:t@ype}(PLarray(a), int): a = "mac#%"
fun
PLarray_set_at
  {a:t@ype}(PLarray(a), int, a): void = "mac#%"
//
fun
PLarray_exch_at
  {a:vt@ype}(PLarray(a), int, x0: a): (a) = "mac#%"
//
(* ****** ****** *)
//
fun
PLarray_length{a:vt0p}(PLarray(a)): int = "mac#%"
//
(* ****** ****** *)
//
symintr PLarray_pop_0
//
fun
PLarray_pop_0
  {a:vt0p}(A: PLarray(a)): a = "mac#%"
fun
PLarray_pop_1
  {a:vt0p}(A: PLarray(a), i: int): a = "mac#%"
//
overload PLarray_pop with PLarray_pop_0
overload PLarray_pop with PLarray_pop_1
//
(* ****** ****** *)
//
fun
PLarray_push
  {a:vt0p}(A: PLarray(a), x: a): int = "mac#%"
//
(* ****** ****** *)
//
fun
PLarray_extend{a:vt0p}(PLarray(a), a): void = "mac#%"
//
(* ****** ****** *)

fun
PLarray_reverse{a:vt0p}(PLarray(a)): void = "mac#%"

(* ****** ****** *)
//
fun
PLarray_copy{a:t0p}(PLarray(a)): PLarray(a) = "mac#%"
fun
PLarray_revcopy{a:t0p}(PLarray(a)): PLarray(a) = "mac#%"
//
(* ****** ****** *)
//
fun
PLarray_append_2
  {a:t0p}(PLarray(a), PLarray(a)): PLarray(a) = "mac#%"
fun
PLarray_append_3
  {a:t0p}(PLarray(a), PLarray(a), PLarray(a)): PLarray(a) = "mac#%"
//
symintr PLarray_append
overload PLarray_append with PLarray_append_2
overload PLarray_append with PLarray_append_3
//
(* ****** ****** *)
//
// Some function overloading
//
(* ****** ****** *)
//
overload [] with PLarray_get_at
overload [] with PLarray_set_at
//
(* ****** ****** *)
//
overload .pop with PLarray_pop
overload .push with PLarray_push
//
(* ****** ****** *)

overload length with PLarray_length

(* ****** ****** *)

(* end of [PLarray.sats] *)

(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
abstype
funarray_t0ype_int_type(a:t@ype+, n:int)
//
typedef
funarray(a:t0p, n:int) = funarray_t0ype_int_type(a, n)
//
(* ****** ****** *)
//
praxi
lemma_funarray_param
  {a:t0p}{n:int}
  (A: funarray(INV(a), n)): [n >= 0] void
//
(* ****** ****** *)
//
fun
funarray_make_nil
  {a:t0p}((*void*)): funarray(a, 0) = "mac#%"
//
(* ****** ****** *)
//
fun
funarray_size
  {a:t0p}{n:int}(A: funarray(INV(a), n)): int(n) = "mac#%"
//
(* ****** ****** *)
//
fun
funarray_get_at
  {a:t0p}{n:int}(A: funarray(INV(a), n), i: natLt(n)): (a) = "mac#%"
fun
funarray_set_at
  {a:t0p}{n:int}
  (A: funarray(INV(a), n), i: natLt(n), x: a): funarray(a, n) = "mac#%"
//
(* ****** ****** *)
//
fun
funarray_insert_l
  {a:t0p}{n:int}
  (A: funarray(INV(a), n), x: a): funarray(a, n+1) = "mac#%"
fun
funarray_insert_r
  {a:t0p}{n:int}
  (A: funarray(INV(a), n), n: int(n), x: a): funarray(a, n+1) = "mac#%"
//
(* ****** ****** *)
//
fun
funarray_remove_l
  {a:t0p}{n:pos}
  (A: funarray(INV(a), n)): $tup(funarray(a, n-1), a) = "mac#%"
fun
funarray_remove_r
  {a:t0p}{n:pos}
  (A: funarray(INV(a), n), n: int(n)): $tup(funarray(a, n-1), a) = "mac#%"
//
(* ****** ****** *)

(* end of [funarray.sats] *)

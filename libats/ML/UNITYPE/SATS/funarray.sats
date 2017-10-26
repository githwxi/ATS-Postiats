(* ****** ****** *)
//
#staload
"./../../SATS/basis.sats"
//
(* ****** ****** *)

#staload FA =
"libats/SATS/funarray.sats"

(* ****** ****** *)
//
abstype
funarray_type
typedef
funarray = funarray_type
//
(*
typedef
funarray = $FA.funarray(gvalue)
*)
//
(* ****** ****** *)
//
fun
funarray_size
  (xs: funarray):<> intGte(0)
//
overload size with funarray_size
//
(* ****** ****** *)
//
fun
funarray_is_nil(funarray): bool
fun
funarray_is_cons(funarray): bool
//
overload iseqz with funarray_is_nil
overload isneqz with funarray_is_cons
//
(* ****** ****** *)
//
fun funarray_nil():<> funarray
fun funarray_make_nil():<> funarray
//
(* ****** ****** *)
//
fun
funarray_get_at_exn
  (A: funarray, i: int):<> gvalue
fun
funarray_set_at_exn
  (A: &funarray >> _, i: int, x: gvalue): void
//
overload [] with funarray_get_at_exn
overload [] with funarray_set_at_exn
//
(* ****** ****** *)
//
fun
funarray_get_at_opt{n:int}
  (A: funarray, i: int):<> Option_vt(gvalue)
fun
funarray_set_at_opt
  (A: &funarray >> _, i: int, x: gvalue): bool
//
(* ****** ****** *)

(* end of [funarray.sats] *)

(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../../basics.sats"
*)

(* ****** ****** *)
//
fun
array0_make_elt
  {a:t@ype}{n:nat}
  (asz: int(n), x0: a): array0(a) = "mac#%"
//
(* ****** ****** *)
//
fun
array0_size
  {a:vt0p}(A: array0(a)): intGte(0) = "mac#%"
fun
array0_length
  {a:vt0p}(A: array0(a)): intGte(0) = "mac#%"
//
(* ****** ****** *)
//
fun
array0_get_at
  {a:t0p}(A: array0(a), i: int): a = "mac#%"
//
fun
array0_set_at
  {a:t0p}(A: array0(a), i: int, x0: a): void = "mac#%"
//
fun
array0_exch_at
  {a:vt0p}(A: array0(a), i: int, x0: a): (a) = "mac#%"
//
(* ****** ****** *)
//
overload [] with array0_get_at of 100
overload [] with array0_set_at of 100
//
overload size with array0_size of 100
overload length with array0_length of 100
//
overload .size with array0_size of 100
overload .length with array0_length of 100
//
(* ****** ****** *)
//
fun
array0_exists
  {a:vt0p}
(
A0: array0(a), pred: Nat -<cloref1> bool
) : bool = "mac#%" // array0_exists
fun
array0_exists_method
  {a:vt0p}
  (A: array0(a))
  (pred: Nat -<cloref1> bool): bool = "mac#%"
//
overload .exists with array0_exists_method
//
(* ****** ****** *)
//
fun
array0_forall
  {a:vt0p}
(
A0: array0(a), pred: Nat -<cloref1> bool
) : bool = "mac#%" // array0_forall
fun
array0_forall_method
  {a:vt0p}
  (A: array0(a))
  (pred: Nat -<cloref1> bool): bool = "mac#%"
//
overload .forall with array0_forall_method
//
(* ****** ****** *)
//
fun
array0_find_index
  {a:vt0p}
(
A0: array0(a), pred: Nat -<cloref1> bool
) : intGte(~1) = "mac#" // array0_find_index
//
(* ****** ****** *)
//
fun
array0_app
  {a:t0p}
(
  xs: array0(a), fwork: cfun(int, void)
) : void = "mac#%" // end-of-function
fun
array0_foreach
  {a:vt0p}
  (A: array0(a), fwork: Nat -<cloref1> void): void = "mac#%"
fun
array0_foreach_method
  {a:vt0p}
  (A: array0(a))(fwork: Nat -<cloref1> void): void = "mac#%"
//
overload .foreach with array0_foreach_method
//
(* ****** ****** *)

(* end of [array0.sats] *)

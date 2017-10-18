(* ****** ****** *)
(*
** libatscc-common
*)
(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
fun{}
list_vt_is_nil
  {a:vt0p}{n:int}
  (xs: !list_vt(a, n)): bool(n==0)
fun{}
list_vt_is_cons
  {a:vt0p}{n:int}
  (xs: !list_vt(a, n)): bool(n > 0)
//
overload iseqz with list_vt_is_nil of 100
overload isneqz with list_vt_is_cons of 100
//
(* ****** ****** *)
//
fun
list_vt_length
  {a:vt0p}{n:int}
  (xs: !list_vt(INV(a), n)): int(n) = "mac#%"
//
overload length with list_vt_length of 100
//
(* ****** ****** *)
//
fun
list_vt_snoc
  {a:vt0p}{n:int}
  (xs: list_vt(INV(a), n), x0: a): list_vt(a, n+1) = "mac#%"
//
fun
list_vt_extend
  {a:vt0p}{n:int}
  (xs: list_vt(INV(a), n), x0: a): list_vt(a, n+1) = "mac#%"
//
(* ****** ****** *)
//
fun
list_vt_append
  {a:vt0p}{i,j:int}
  (list_vt(INV(a), i), list_vt(a, j)): list_vt(a, i+j)= "mac#%"
//
overload + with list_vt_append of 100 // infix
//
(* ****** ****** *)
//
fun
list_vt_reverse
  {a:vt0p}{n:int}
  (list_vt(INV(a), n)): list_vt(a, n) = "mac#%"
//
fun
list_vt_reverse_append
  {a:vt0p}{i,j:int}
  (list_vt(INV(a), i), list_vt(a, j)): list_vt(a, i+j) = "mac#%"
//
overload reverse with list_vt_reverse of 100
overload revappend with list_vt_reverse_append of 100
//
(* ****** ****** *)

(* end of [list_vt.sats] *)

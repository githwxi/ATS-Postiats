datasort
array = (*abstract*)

(* ****** ****** *)

sortdef stamp = int
abstype T (x:stamp)

(* ****** ****** *)

stacst ahead : array -> stamp
stacst atail : array -> array
stacst acons : (stamp, array) -> array
stacst atake : (array, int) -> array // take the first n elements
stacst adrop : (array, int) -> array // drop the first n elements

(* ****** ****** *)

stacst array_get_at : (array, int) -> stamp // select
stacst array_set_at : (array, int, stamp) -> array // update
//
stadef select = array_get_at
stadef update = array_set_at
//
(* ****** ****** *)

dataview
array_v (A:array, addr, int) =
  | {l:addr}
    array_v_nil (A, l, 0) of ()
  | {A:array}{x:stamp}{l:addr}{n:int}
    array_v_cons (acons (x, A), l, n+1) of (T(x) @ l, array_v (A, l+1, n))
// end of [array_v]

(* ****** ****** *)
//
extern
fun array_get_at
  {A:array}{l:addr}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(A, l, n) | p: ptr(l), i: int i
) : T(select(A, i))
//
(* ****** ****** *)

extern
fun array_get_0
  {A:array}{l:addr}
  {n:int}{i:nat | i < n}
  (pf: !array_v(A, l, n) | p: ptr(l)): T(select(A, 0))
(*
implement
array_get_0
  (pf | p) = x0 where
{
  prval array_v_cons (pf1, pf2) = pf
  val x0 = !p
  prval () = pf := array_v_cons (pf1, pf2)
}
*)

(* ****** ****** *)

extern
prfun array_v_split
  {A:array}{l:addr}
  {n:int}{i:nat | i < n}
  (pf: array_v(A, l, n), i: int (i)):
  (array_v (atake(A, i), l, i), array_v (adrop(A,i), l+i, n-i))

(* ****** ****** *)

(* end of [array.sats] *)

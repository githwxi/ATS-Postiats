(* ****** ****** *)
//
// array-indexed lists
//
(* ****** ****** *)
//
sortdef stamp = int
datasort array = (* abstract *)
//
(* ****** ****** *)
//
(*
//
ahead(A) = A[0]
//
atail(A)[i] = A[i+1] for i >= 0
//
acons(x, A) = A2 such that
A2[0] = x and A2[i] = A[i-1] for i >= 1
//
*)
stacst ahead : array -> stamp
stacst atail : array -> array
stacst acons : (stamp, array) -> array
//
(* ****** ****** *)
//
stacst array_get_at : (array, int) -> stamp // select
stacst array_set_at : (array, int, stamp) -> array // update
//
stadef select = array_get_at
stadef update = array_set_at
//
(* ****** ****** *)
//
abstype T(x:stamp)
//
datatype
alist (array, int) =
  | {A:array} alist_nil (A, 0)
  | {A:array}{x:stamp}{n:nat}
    glist_cons (acons (x, A), n+1) of (T(x), alist (A, n))
//
(* ****** ****** *)

extern
fun alist_nth
  {A:array}{n:int}{i:nat | i < n}
  (xs: alist (A, n), i: int (i)): T (select(A, i))
// end of [alist_nth]

(* ****** ****** *)

implement
alist_nth (xs, i) = let
//
val+glist_cons (x, xs) = xs
//
in
  if i > 0 then alist_nth (xs, i-1) else x
end // end of [alist_nth]

(* ****** ****** *)

(* end of [alist.dats] *)

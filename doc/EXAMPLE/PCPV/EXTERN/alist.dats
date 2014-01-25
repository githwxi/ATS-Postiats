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
extern
fun lte_T_T{x1,x2:stamp} (T(x1), T(x2)): bool (x1 <= x2)
overload <= with lte_T_T
//
(* ****** ****** *)
//
datatype
alist (array, int) =
  | {A:array} alist_nil (A, 0)
  | {A:array}{x:stamp}{n:nat}
    alist_cons (acons (x, A), n+1) of (T(x), alist (A, n))
//
(* ****** ****** *)

extern
fun alist_nth
  {A:array}{n:int}{i:nat | i < n}
  (xs: alist (A, n), i: int (i)): T (select(A, i))
// end of [alist_nth]

(* ****** ****** *)

(*
implement
alist_nth (xs, i) = let
//
val+alist_cons (x, xs) = xs
//
in
  if i > 0 then alist_nth (xs, i-1) else x
end // end of [alist_nth]
*)

(* ****** ****** *)

stacst equal : (array, array, int) -> bool

(* ****** ****** *)

stacst append : (array, int, array) -> array

(* ****** ****** *)

extern
fun alist_append
  {A1,A2:array}{n1,n2:nat}
(
  xs1: alist (A1, n1), xs2: alist (A2, n2)
) : alist (append(A1, n1, A2), n1+n2)

(* ****** ****** *)

(*
implement
alist_append
  (xs1, xs2) = let
in
//
case+ xs1 of
| alist_nil () => xs2
| alist_cons (x1, xs1) =>
    alist_cons (x1, alist_append (xs1, xs2))
  // end of [alist_cons]
//
end // end of [alist_append]
*)

(* ****** ****** *)

(* end of [alist.dats] *)

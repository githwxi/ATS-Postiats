(* ****** ****** *)

staload "./infseq.sats"

(* ****** ****** *)
//
// array-indexed lists
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
list (infseq, int) =
  | {xs:infseq} alist_nil (xs, 0)
  | {xs:infseq}{x:stamp}{n:nat}
    list_cons (cons (x, xs), n+1) of (T(x), list (xs, n))
//
(* ****** ****** *)

extern
fun list_nth
  {xs:infseq}{n:int}{i:nat | i < n}
  (xs: list (xs, n), i: int (i)): T (select(xs, i))
// end of [list_nth]

(* ****** ****** *)

(*
implement
list_nth (xs, i) = let
//
val+list_cons (x, xs) = xs
//
in
  if i > 0 then list_nth (xs, i-1) else x
end // end of [list_nth]
*)

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

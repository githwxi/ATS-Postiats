(* ****** ****** *)
//
// stampseq-indexed lists
//
(* ****** ****** *)

staload "./list.sats"

(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)

implement
list_nth (xs, i) = let
//
val+list_cons (x, xs) = xs
//
in
  if i > 0 then list_nth (xs, i-1) else x
end // end of [list_nth]

(* ****** ****** *)

implement
list_append
  (xs1, xs2) = let
in
//
case+ xs1 of
| list_nil () => xs2
| list_cons (x1, xs1) =>
    list_cons (x1, list_append (xs1, xs2))
  // end of [list_cons]
//
end // end of [list_append]

(* ****** ****** *)

(* end of [list.dats] *)

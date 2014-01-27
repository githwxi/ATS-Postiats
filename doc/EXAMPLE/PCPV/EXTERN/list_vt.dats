(* ****** ****** *)
//
// stampseq-indexed lists
//
(* ****** ****** *)

staload "./list_vt.sats"

(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)

implement
list_vt_nth (xs, i) = let
//
val+list_vt_cons (x, xs) = xs
//
in
  if i > 0 then list_vt_nth (xs, i-1) else x
end // end of [list_vt_nth]

(* ****** ****** *)

implement
list_vt_append
  {xs,ys}{m,n}(xs, ys) = let
//
fun loop
  {xs:stmsq}{m:nat} .<m>.
(
  xs: &list_vt (xs, m) >> list_vt (append(xs,m,ys,n), m+n), ys:  list_vt (ys, n)
) :<!wrt> void = let
in
//
case+ xs of
| @list_vt_cons
    (x, xs1) => let
    val () = loop (xs1, ys); prval () = fold@ (xs) in (*none*)
  end // end of [list_vt_cons]
| ~list_vt_nil () => (xs := ys)
//
end (* end of [loop] *)
//
var res = xs
val () = loop (res, ys)
//
in
  res
end // end of [list_vt_append]

(* ****** ****** *)

(* end of [list_vt.dats] *)

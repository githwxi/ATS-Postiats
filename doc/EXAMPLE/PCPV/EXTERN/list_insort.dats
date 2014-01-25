(* ****** ****** *)

staload "./list.sats"
staload "./infseq.sats"

(* ****** ****** *)
//
extern
fun insort
  {xs:infseq}{x0:stamp}{n:nat}
  {a:stamp | a <= x0; lte (a, xs, n)}
(
  xs: list (xs, n), x0: T(x0)
) : [ys:infseq | lte (a, ys, n); sorted(ys, n)] list (ys, n+1)
//
(* ****** ****** *)

(*
implement
insort (xs, x0) =
(
case+ xs of
| list_nil () => list_cons (x0, list_nil)
| list_cons (x, xs1) =>
    if x0 <= x
      then list_cons (x0, xs)
      else list_cons (x, insort{..}{..}{..}{a} (x0, xs1))
    // end of [if]
)
*)

(* ****** ****** *)

(* end of [list_insort.dats] *)

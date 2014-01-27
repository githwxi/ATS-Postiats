(* ****** ****** *)

staload "./list.sats"
staload "./stampseq.sats"

(* ****** ****** *)

(*
dataprop
LTE (x0:stamp,xs:stmsq,n:int) = {lte (x0, xs, n)} LTE of ()
dataprop
LTE2 (xs:stmsq, m: int, ys:stmsq, n: int) = {a:stamp} LTE2 of (LTE (a, xs, m) -> LTE (a, ys, n))
*)

(* ****** ****** *)

typedef listord (xs:stmsq,n:int) = [sorted(xs,n)] list (xs, n)

(* ****** ****** *)
//
extern
fun insord
  {x0:stamp}
  {xs:stmsq}{n:nat}
(
  x0: T(x0), xs: listord (xs, n)
) : [i:int] listord (insert(xs, i, x0), n+1)
//
(* ****** ****** *)

implement
insord (x0, xs) =
(
case+ xs of
| list_nil () =>
    #[0 | list_cons (x0, list_nil)]
| list_cons (x, xs1) =>
  (
    if x0 <= x
      then
        #[0 | list_cons (x0, xs)]
      else let
        val [i:int] ys1 = insord (x0, xs1)
      in
        #[i+1 | list_cons (x, ys1)]
      end // end of [if]
    // end of [if]
  )
) (* end of [insort] *)

(* ****** ****** *)

extern
fun sort
  {xs:stmsq}{n:int}
  (xs: list (xs, n)): [ys:stmsq] listord (ys, n)

implement
sort (xs) =
(
case+ xs of
| list_nil () => list_nil ()
| list_cons (x, xs1) => insord (x, sort(xs1))
) (* end of [sort] *)

(* ****** ****** *)

(* end of [list_insort.dats] *)

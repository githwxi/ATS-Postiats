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

absprop SORTED (xs:stmsq, n:int)

extern
praxi
SORTED_elim
  {xs:stmsq}{n:int}
  (pf: SORTED(xs, n)): [sorted(xs, n)] void
//
extern
praxi
SORTED_nil(): SORTED (nil, 0)
extern
praxi
SORTED_sing{x:stamp}(): SORTED (sing(x), 1)
extern
praxi
SORTED_cons
  {x:stamp}
  {xs:stmsq}{n:pos}
  {x <= select(xs,0)}
  (pf: SORTED (xs, n)): SORTED (cons(x, xs), n+1)
//
extern
praxi
SORTED_uncons
  {x:stamp}{xs:stmsq}{n:pos}
  (pf: SORTED (cons(x, xs), n)): [x <= select(xs,0)] SORTED (xs, n-1)
//
(* ****** ****** *)
//
extern
fun insord
  {x0:stamp}
  {xs:stmsq}{n:nat}
(
  pf: SORTED(xs, n) | x0: T(x0), xs: list (xs, n)
) : [i:nat]
(
  SORTED (insert(xs, i, x0), n+1) | list (insert(xs, i, x0), n+1)
)
//
(* ****** ****** *)

implement
insord (pf | x0, xs) =
(
case+ xs of
| list_nil () =>
    #[0 | (SORTED_sing() | list_cons (x0, list_nil))]
| list_cons (x, xs1) =>
  (
    if x0 <= x
      then
        #[0 | (SORTED_cons (pf) | list_cons (x0, xs))]
      else let
        val [i:int] (pfres | ys1) = insord (pf | x0, xs1)
      in
        #[i+1 | (SORTED_cons (pfres) | list_cons (x, ys1))]
      end // end of [if]
    // end of [if]
  )
) (* end of [insort] *)

(* ****** ****** *)

extern
fun sort
  {xs:stmsq}{n:int}
  (xs: list (xs, n)): [ys:stmsq] (SORTED (ys, n) | list (ys, n))

implement
sort (xs) =
(
case+ xs of
| list_nil () =>
    (SORTED_nil() | list_nil())
| list_cons (x, xs1) => let
    val (pf1 | ys1) = sort (xs1) in insord (pf1 | x, ys1)
  end // end of [list_cons]
) (* end of [sort] *)

(* ****** ****** *)

(* end of [list_insort.dats] *)

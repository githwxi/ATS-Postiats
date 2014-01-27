(* ****** ****** *)
//
// HX-2014-01-25:
// infseq-indexed arrays
//
(* ****** ****** *)

staload "./array.sats"
staload "./stampseq.sats"

(* ****** ****** *)

extern
fun insord
  {l:addr}
  {xs:stmsq}
  {n:int}{n1:int}
  {i:nat | i <= n1; n1 < n}
  {sorted(remove(xs, i), n1)}
(
  pf: array_v (l, xs, n) | p: ptr(l+i), i: int(i)
) : [ys:stmsq | sorted(xs, n1+1)] (array_v (l, ys, n) | void)

(* ****** ****** *)

implement
insord (pf | p, i) = let
in
//
if i > 0
then let
  val x = array_ptrget (pf | p)
  val p1 = p - 1
  val x1 = array_ptrget (pf | p1)
in
  if x1 <= x
    then (pf | ())
    else let
      val () =
        array_ptrswap (pf | p, p1) in insord (pf | p1, i-1)
      // end of [val]
    end (* else *)
  // end of [if]
end (*then*)
else (pf | ())
//
end // end of [insord]

(* ****** ****** *)

(* end of [array_insort.dats] *)

//
// Selection sort
//

(* ****** ****** *)
//
// HX-2012-07-22:
// A glorious implementation of selection-sort in ATS :)
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

staload "./program-1-2.sats"

(* ****** ****** *)

implement{a}
SelectionSort$cmp (x1, x2) = gcompare_ref<a> (x1, x2)

(* ****** ****** *)

implement{a}
SelectionSort
  {n} (A, n) = let
//
stadef tsz = sizeof(a)
//
prval () = lemma_array_param (A)
//
fun findmin
  {l1,l2,l3:addr;n1,n2,n3:nat |
   l2==l1+n1*tsz;l3==l2+n2*tsz;n2>0} .<n3>.
(
  pf1: array_v (a, l1, n1)
, pf2: array_v (a, l2, n2) // the first element is the current min
, pf3: array_v (a, l3, n3)
| p1: ptr l1, p2: ptr l2, p3: ptr l3
, n3: size_t n3
) :<!wrt>
(
  array_v (a, l1, n1+n2+n3) | void
) = let
in
//
if n3 > 0 then let
  prval (pf21, pf22) = array_v_uncons (pf2)
  prval (pf31, pf32) = array_v_uncons (pf3)
  val sgn = SelectionSort$cmp<a> (!p2, !p3)
  prval pf2 = array_v_cons (pf21, pf22)
in
  if sgn > 0 then let
    prval pf1 =
      array_v_unsplit (pf1, pf2)
    // end of [prval]
    prval pf2 = array_v_sing (pf31)
  in
    findmin (pf1, pf2, pf32 | p1, p3, ptr_succ<a> (p3), pred(n3))
  end else let
    prval pf2 = array_v_extend (pf2, pf31)
  in
    findmin (pf1, pf2, pf32 | p1, p2, ptr_succ<a> (p3), pred(n3))
  end // end of [if]
end else let
  prval pf2 = array_v_unsplit (pf2, pf3)
in
  if p1 < p2 then let
//
    extern praxi lemma
      {x,y:int | x*y != 0} (): [x != 0; y != 0] void
    prval () = lemma {n1,tsz} () // n1 != 0; tsz != 0
//
    prval (pf11, pf12) = array_v_uncons (pf1)
    prval (pf21, pf22) = array_v_uncons (pf2)
    val () = ptr_exch<a> (pf11 | p1, !p2)
    prval pf1 = array_v_cons (pf11, pf12)
    prval pf2 = array_v_cons (pf21, pf22)
  in
    (array_v_unsplit (pf1, pf2) | ())
  end else
    (array_v_unsplit (pf1, pf2) | ())
  // end of [if]
end // end of [if]
//
end // end of [findmin]
//
fun loop
  {l:addr}{n:nat} .<n>.
(
  pf: !array_v (a, l, n) | p: ptr l, n: size_t n
) :<!wrt> void = let
in
//
if n >= 2 then let
  prval (pf1, pf2) = array_v_uncons (pf)
  val p1 = ptr_succ<a> (p) and n1 = pred(n)
  val (pfmin | ()) = findmin (
    array_v_nil(), array_v_sing(pf1), pf2 | p, p, p1, n1
  ) // end of [val]
  prval (pf1, pf2) = array_v_uncons (pfmin)
  val () = loop (pf2 | p1, n1)
  prval () = pf := array_v_cons (pf1, pf2)
in
  // nothing
end else () // end of [if]
//
end // end of [loop]
//
in
  loop (view@(A) | addr@(A), n)
end // end of [SelectionSort]

(* ****** ****** *)

(* end of [program-1-2.dats] *)

(* ****** ****** *)
//
// HX-2014-01-25:
// infseq-indexed arrays
//
(* ****** ****** *)

staload "./array.sats"

(* ****** ****** *)

staload "./infseq.sats"

(* ****** ****** *)

local

prfun
lemma
  {xs:infseq}{l:addr}
  {n:int}{i:nat | i <= n} .<i>.
(
  pf: array_v(xs, l, n), i: int (i)
) : (
  array_v (take(xs, i), l, i)
, array_v (drop(xs, i), l+i, n-i)
) = let
in
//
if i = 0
then
  (array_v_nil (), pf)
else let
  prval array_v_cons (pf1, pf2) = pf
  prval (pf21, pf22) = array_v_split (pf2, i-1)
in
  (array_v_cons (pf1, pf21), pf22)
end // end of [else]
//
end // end of [lemma]

in (* in-of-local *)

primplement
array_v_split (pf, i) = lemma (pf, i)

end // end of [local]

(* ****** ****** *)

extern
fun add_ptr_int
  {l:addr}{i:int} (ptr l, int i):<> ptr (l+i)
overload + with add_ptr_int

(* ****** ****** *)

implement
array_get_at
  (pf | p, i) = x where
{
//
prval (pf1, pf2) = array_v_split (pf, i)
prval array_v_cons (pf21, pf22) = pf2
//
val x = !(p+i)
//
prval ((*void*)) =
  pf := array_v_unsplit (pf1, array_v_cons (pf21, pf22))
//
} (* end of [array_get_at] *)

(* ****** ****** *)

(* end of [array.dats] *)

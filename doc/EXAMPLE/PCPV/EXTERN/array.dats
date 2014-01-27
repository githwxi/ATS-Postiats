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
  {l:addr}{xs:infseq}
  {n:int}{i:nat | i <= n} .<i>.
(
  pf: array_v(l, xs, n), i: int (i)
) : (
  array_v (l, take(xs, i), i)
, array_v (l+i, drop(xs, i), n-i)
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

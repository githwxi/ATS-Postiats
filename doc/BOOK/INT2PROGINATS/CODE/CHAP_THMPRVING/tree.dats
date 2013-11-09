(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)

datasort tree = E of () | B of (tree, tree)

dataprop SZ (tree, int) =
  | SZE (E (), 0) of ()
  | {tl,tr:tree}{sl,sr:nat}
    SZB (B (tl, tr), 1+sl+sr) of (SZ (tl, sl), SZ (tr, sr))
// end of [SZ]

dataprop HT (tree, int) =
  | HTE (E (), 0) of ()
  | {tl,tr:tree}{hl,hr:nat}
    HTB (B (tl, tr), 1+max(hl,hr)) of (HT (tl, hl), HT (tr, hr))
// end of [HT]

dataprop POW2 (int, int) =
  | POW2bas (0, 1)
  | {n:nat}{p:int} POW2ind (n+1, p+p) of POW2 (n, p)
// end of [POW2]

extern
prfun
lemma_tree_size_height
  {t:tree}{s,h:nat}{p:int} (
  pf1: SZ (t, s), pf2: HT (t, h), pf3: POW2 (h, p)
) : [p > s] void // end of [prfun]

(* ****** ****** *)

prfun pow2_istot
  {h:nat} .<h>. (): [p:int] POW2 (h, p) =
  sif h > 0 then POW2ind (pow2_istot {h-1} ()) else POW2bas ()
// end of [pow2_istot]

prfun pow2_pos
  {h:nat}{p:int} .<h>.
  (pf: POW2 (h, p)): [p > 0] void =
  case+ pf of
  | POW2ind (pf1) => pow2_pos (pf1) | POW2bas () => ()
// end of [pow2_pos]

prfun pow2_inc
  {h1,h2:nat | h1 <= h2}{p1,p2:int} .<h2>.
  (pf1: POW2 (h1, p1), pf2: POW2 (h2, p2)): [p1 <= p2] void =
  case+ pf1 of
  | POW2ind (pf11) => let
      prval POW2ind (pf21) = pf2 in pow2_inc (pf11, pf21)
    end
  | POW2bas () => pow2_pos (pf2)
// end of [pow2_inc]

(* ****** ****** *)

primplmnt
lemma_tree_size_height
  (pf1, pf2, pf3) = let
//
prfun lemma
  {t:tree}{s,h:nat}{p:int} .<t>.
(
  pf1: SZ (t, s), pf2: HT (t, h), pf3: POW2 (h, p)
) : [p > s] void =
  scase t of
  | B (tl, tr) => let
      prval SZB (pf1l, pf1r) = pf1
      prval HTB{tl,tr}{hl,hr} (pf2l, pf2r) = pf2
      prval POW2ind (pf31) = pf3
      prval pf3l = pow2_istot {hl} ()
      prval pf3r = pow2_istot {hr} ()
      prval () = lemma (pf1l, pf2l, pf3l)
      prval () = lemma (pf1r, pf2r, pf3r)
      prval () = pow2_inc (pf3l, pf31)
      prval () = pow2_inc (pf3r, pf31)
    in
      // nothing
    end // end of [B]
  | E () => let
      prval SZE () = pf1
      prval HTE () = pf2
      prval POW2bas () = pf3
   in
     // nothing
   end // end of [E]
//
in
  lemma (pf1, pf2, pf3)
end // end of [lemma_tree_size_height]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [tree.dats] *)

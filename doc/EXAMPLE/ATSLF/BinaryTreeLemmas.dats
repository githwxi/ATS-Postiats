(*
**
** Some properties on binary trees
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: November, 2008
**
*)

(*
** It is ported to ATS2 on 2012-06-12 by Hongwei Xi
*)

(* ****** ****** *)

datasort bt = E of () | B of (bt, bt)

(* ****** ****** *)

// size
dataprop btsz (bt, int) =
  | {t1,t2:bt} {n1,n2:nat}
    btsz_B (B (t1, t2), n1+n2+1) of (btsz (t1, n1), btsz (t2, n2))
  | btsz_E (E (), 0)

// height
dataprop btht (bt, int) =
  | {t1,t2:bt} {n1,n2:nat}
    btht_B (B (t1, t2), max (n1,n2)+1) of (btht (t1, n1), btht (t2, n2))
  | btht_E (E (), 0)

// shortest path
dataprop btsp (bt, int) =
  | {t1,t2:bt} {n1,n2:nat}
    btsp_B (B (t1, t2), min (n1,n2)+1) of (btsp (t1, n1), btsp (t2, n2))
  | btsp_E (E (), 0)

(* ****** ****** *)

prfun btht_isfun {t:bt} {n1,n2:nat} .<t>.
  (pf1: btht (t, n1), pf2: btht (t, n2)): [n1==n2] void =
  case+ (pf1, pf2) of
  | (btht_B (pf11, pf12), btht_B (pf21, pf22)) => let
      prval () = btht_isfun (pf11, pf21) and () = btht_isfun (pf12, pf22)
    in
      // empty
    end // end of [btht_B, btht_B]
  | (btht_E (), btht_E ()) => ()
// end of [btht_isfun]

(* ****** ****** *)

//
// EXP2 is declared in $ATSHOME/prelude/SATS/arith.sats
//

prfun bintree_SZ_HT_lemma {t:bt} {s,n,p:nat} .<t>.
  (pf1: btsz (t, s), pf2: btht (t, n), pf3: EXP2 (n, p)): [s < p] void =
  case+ pf1 of
  | btsz_E () => let
      prval btht_E () = pf2; prval EXP2bas () = pf3 in ()
    end // end of [btsz_E]
  | btsz_B (pf11, pf12) => let
      prval btht_B (pf21, pf22) = pf2; prval EXP2ind (pf30) = pf3
      prval pf30_1 = exp2_istot ()
      prval () = exp2_is_mono (pf30_1, pf30)
      prval () = bintree_SZ_HT_lemma (pf11, pf21, pf30_1)
      prval pf30_2 = exp2_istot ()
      prval () = exp2_is_mono (pf30_2, pf30)
      prval () = bintree_SZ_HT_lemma (pf12, pf22, pf30_2)
    in
      // empty
    end // end of [btsz_B]
// end of [bintree_SZ_HT_lemma]

(* ****** ****** *)

prfun bintree_SZ_SP_lemma {t:bt} {s,n,p:nat} .<t>.
  (pf1: btsz (t, s), pf2: btsp (t, n), pf3: EXP2 (n, p)): [p <= s+1] void =
  case+ pf1 of
  | btsz_E () => let
      prval btsp_E () = pf2; prval EXP2bas () = pf3 in ()
    end // end of [btsz_E]
  | btsz_B (pf11, pf12) => let
      prval btsp_B (pf21, pf22) = pf2; prval EXP2ind (pf30) = pf3
      prval pf30_1 = exp2_istot ()
      prval () = exp2_is_mono (pf30, pf30_1)
      prval () = bintree_SZ_SP_lemma (pf11, pf21, pf30_1)
      prval pf30_2 = exp2_istot ()
      prval () = exp2_is_mono (pf30, pf30_2)
      prval () = bintree_SZ_SP_lemma (pf12, pf22, pf30_2)
    in
      // empty
    end // end of [btsz_B]
// end of [bintree_SZ_SP_lemma]

(* ****** ****** *)

dataprop isAVL (bt) =
  | {t1,t2:bt} {n1,n2:nat | n1 <= n2+1; n2 <= n1+1}
    isAVL_B (B (t1, t2)) of (isAVL t1, isAVL t2, btht (t1, n1), btht (t2, n2))
  | isAVL_E (E ())
// end of [isAVL]

(* ****** ****** *)

(*
**
** this lemma proves that AVL trees are balanced
**
*)

prfun
bintree_AVL_SP_HT_lemma
  {t:bt}{sp,ht:nat} .<t>.
(
  pf_avl: isAVL (t)
, pf_sp: btsp (t, sp), pf_ht: btht (t, ht)
) : [ht <= sp + sp] void = (
  case+ pf_avl of
  | isAVL_B (pf1_avl, pf2_avl, pf1_ht, pf2_ht) => let
      prval btsp_B (pf1_sp, pf2_sp) = pf_sp
      prval btht_B (pf1_ht_alt, pf2_ht_alt) = pf_ht
      prval () = btht_isfun (pf1_ht, pf1_ht_alt)
      prval () = btht_isfun (pf2_ht, pf2_ht_alt)
      prval () = bintree_AVL_SP_HT_lemma (pf1_avl, pf1_sp, pf1_ht)
      prval () = bintree_AVL_SP_HT_lemma (pf2_avl, pf2_sp, pf2_ht)
    in
      // empty
    end // end of [isAVL_B]
  | isAVL_E () => let
      prval btsp_E () = pf_sp and btht_E () = pf_ht
    in
      // empty
    end // end of [isAVL_E]
) (* end of [bintree_AVL_SP_HT] *)

(* ****** ****** *)

(* end of [BinaryTreeLemmas.dats] *)

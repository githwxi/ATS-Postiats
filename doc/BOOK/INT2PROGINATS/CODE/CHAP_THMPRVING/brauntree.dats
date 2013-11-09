(*
** Some code used in INT2PROGINATS
*)

(* ****** ****** *)

datasort tree = E of () | B of (tree, tree)

(* ****** ****** *)

dataprop
SZ (tree, int) =
  | SZE (E (), 0) of ()
  | {tl,tr:tree}{sl,sr:nat}
    SZB (B (tl, tr), 1+sl+sr) of (SZ (tl, sl), SZ (tr, sr))
// end of [SZ]

(* ****** ****** *)

dataprop
HT (tree, int) =
  | HTE (E (), 0) of ()
  | {tl,tr:tree}{hl,hr:nat}
    HTB (B (tl, tr), 1+max(hl,hr)) of (HT (tl, hl), HT (tr, hr))
// end of [HT]

(* ****** ****** *)

extern
prfun SZ_istot
  {t:tree}{n1,n2:int}
  (pf1: SZ (t, n1), pf2: SZ (t, n2)): [n1==n2] void

(* ****** ****** *)

dataprop isBraun (tree) =
  | isBraunE (E) of ()
  | {tl,tr:tree}
    {sl,sr:nat | sr <= sl; sl <= sr + 1}
    isBraunB (
      B(tl, tr)) of (isBraun tl, isBraun tr, SZ (tl, sl), SZ (tr, sr)
    ) // end of [isBraunB]
// end of [isBraun]

(* ****** ****** *)

extern
prfun lemma_existence {n:nat} (): [t:tree] (isBraun (t), SZ (t, n))

primplmnt
lemma_existence{n} () = let
  prfun lemma {n:nat} .<n>.
    (): [t:tree] (isBraun (t), SZ (t, n)) =
    sif n > 0 then let
      stadef nl = n / 2
      stadef nr = n - 1 - nl
      val (pfl1, pfl2) = lemma {nl} ()
      and (pfr1, pfr2) = lemma {nr} ()
    in
      (isBraunB (pfl1, pfr1, pfl2, pfr2), SZB (pfl2, pfr2))
    end else
      (isBraunE (), SZE ())
    // end of [sif]
in
  lemma {n} ()
end // end of [lemma_existence]

(* ****** ****** *)

dataprop EQ (tree, tree) =
  | EQE (E, E) of ()
  | {t1l,t1r:tree}{t2l,t2r:tree}
    EQB (B (t1l, t1r), B (t2l, t2r)) of (EQ (t1l, t2l), EQ (t1r, t2r))
// end of [EQ]

(* ****** ****** *)

extern
prfun
lemma_unicity
  {n:nat}{t1,t2:tree}
(
  pf1: isBraun t1, pf2: isBraun t2, pf3: SZ (t1, n), pf4: SZ (t2, n)
) : EQ (t1, t2) // end of [lemma_unicity]

(* ****** ****** *)

primplmnt
lemma_unicity
  (pf1, pf2, pf3, pf4) = let
  prfun lemma{n:nat}{t1,t2:tree} .<n>.
  (
    pf1: isBraun t1, pf2: isBraun t2, pf3: SZ (t1, n), pf4: SZ (t2, n)
  ) : EQ (t1, t2) =
    sif n > 0 then let
      prval SZB (pf3l, pf3r) = pf3
      prval SZB (pf4l, pf4r) = pf4
      prval isBraunB (pf1l, pf1r, pf1lsz, pf1rsz) = pf1
      prval isBraunB (pf2l, pf2r, pf2lsz, pf2rsz) = pf2
      prval () = SZ_istot (pf1lsz, pf3l) and () = SZ_istot (pf1rsz, pf3r)
      prval () = SZ_istot (pf2lsz, pf4l) and () = SZ_istot (pf2rsz, pf4r)
      prval pfeql = lemma (pf1l, pf2l, pf3l, pf4l)
      prval pfeqr = lemma (pf1r, pf2r, pf3r, pf4r)
    in
      EQB (pfeql, pfeqr)
    end else let
      prval SZE () = pf3 and SZE () = pf4
      prval isBraunE () = pf1 and isBraunE () = pf2
    in
      EQE ()
    end // end of [sif]
in
  lemma (pf1, pf2, pf3, pf4)
end // end of [lemma_unicity]

(* ****** ****** *)

(*
primplmnt
lemma_unicity
  (pf1, pf2, pf3, pf4) = let
  prfun lemma{n:nat}{t1,t2:tree} .<t1>.
  (
    pf1: isBraun t1, pf2: isBraun t2, pf3: SZ (t1, n), pf4: SZ (t2, n)
  ) : EQ (t1, t2) =
    case+ (pf1, pf2) of
    | (isBraunE (), isBraunE ()) => EQE ()
    | (isBraunB (pf11, pf12, pf13, pf14),
       isBraunB (pf21, pf22, pf23, pf24)) => let
//
        prval SZB (pf31, pf32) = pf3
        prval SZB (pf41, pf42) = pf4
//
        prval () = SZ_istot (pf13, pf31)
        prval () = SZ_istot (pf23, pf41)
//
        prval () = SZ_istot (pf14, pf32)
        prval () = SZ_istot (pf24, pf42)
//
        prval pfeq1 = lemma (pf11, pf21, pf31, pf41)
        prval pfeq2 = lemma (pf12, pf22, pf32, pf42)
      in
        EQB (pfeq1, pfeq2)
      end
    | (isBraunE _, isBraunB _) =/=> let
        prval SZE _ = pf3 and SZB _ = pf4 in (*none*)
      end
    | (isBraunB _, isBraunE _) =/=> let
        prval SZB _ = pf3 and SZE _ = pf4 in (*none*)
      end
in
  lemma (pf1, pf2, pf3, pf4)
end // end of [lemma_unicity]
*)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [brauntree.dats] *)

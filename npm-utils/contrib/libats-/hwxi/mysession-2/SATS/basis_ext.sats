(* ****** ****** *)
(*
** For mconj and mdisj
*)
(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
abstype
chmconj(ss1:type, ss2:type)
abstype
chmdisj(ss1:type, ss2:type)
//
stadef mconj = chmconj and mdisj = chmdisj
//
(* ****** ****** *)

fun{}
chanpos_mconj
  {ssa,ssb:type}
(
  chp: !chanpos(mconj(ssa, ssb)) >> chanpos(ssa)
) : chanpos(ssb) // endfun

fun{}
channeg_mconj
  {ssa,ssb:type}
(
  chn: !channeg(mconj(ssa, ssb)) >> channeg(ssa), fchn: channeg(ssb) -<lincloptr> void
) : void // end of [channeg_mconj]

(* ****** ****** *)

fun{}
channeg_mdisj
  {ssa,ssb:type}
(
  chn: !channeg(mdisj(ssa, ssb)) >> channeg(ssa)
) : channeg(ssb) // endfun

fun{}
chanpos_mdisj
  {ssa,ssb:type}
(
  chp: !chanpos(mdisj(ssa, ssb)) >> chanpos(ssa), fchp: chanpos(ssb) -<lincloptr> void
) : void // end of [chanpos_mdisj]

(* ****** ****** *)

(* end of [basis_ext.sats] *)

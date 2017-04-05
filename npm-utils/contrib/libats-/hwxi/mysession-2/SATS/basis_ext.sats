(* ****** ****** *)
(*
** For mconj/mdisj
*)
(* ****** ****** *)

staload "./basis.sats"

(* ****** ****** *)
//
abstype
chmconj(ssa:type, ssb:type)
abstype
chmdisj(ssa:type, ssb:type)
//
stadef mconj = chmconj and mdisj = chmdisj
//
(* ****** ****** *)

fun{}
chanpos_mconj_elim
  {ssa,ssb:type}
(
  chp: !chanpos(mconj(ssa, ssb)) >> chanpos(ssa)
) : chanpos(ssb) // endfun

fun{}
channeg_mconj_elim
  {ssa,ssb:type}
(
  chn: !channeg(mconj(ssa, ssb)) >> channeg(ssa), chp: chanpos(ssb)
) : void // end of [channeg_mconj]

(* ****** ****** *)
//
fun{}
channeg_mconj_make
  {ssa,ssb:type}
  (channeg(ssa), channeg(ssb)): channeg(mconj(ssa, ssb))
//
(* ****** ****** *)

(* end of [basis_ext.sats] *)

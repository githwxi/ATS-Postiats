(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: April, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_effect.sats"
staload "pats_syntax.sats"
staload "pats_staexp1.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
e1xp_app (
  loc, e_fun, loc_arg, es_arg
) = '{
  e1xp_loc= loc, e1xp_node= E1XPapp (e_fun, loc_arg, es_arg)
} // end of [e1xp_app]

implement
e1xp_char (loc, c) = '{
  e1xp_loc= loc, e1xp_node= E1XPchar c
} // end of [e1xp_char]

implement
e1xp_float (loc, f) = '{
  e1xp_loc= loc, e1xp_node= E1XPfloat (f: string)
} // end of [e1xp_float]

implement
e1xp_ide (loc, id) = '{
  e1xp_loc= loc, e1xp_node= E1XPide (id: symbol)
} // end of [e1xp_ide]

implement
e1xp_int (loc, int) = '{
  e1xp_loc= loc, e1xp_node= E1XPint (int: string)
} // end of [e1xp_int]

implement
e1xp_list (loc, es) = '{
  e1xp_loc= loc, e1xp_node= E1XPlist (es: e1xplst)
} // end of [e1xp_list]

implement
e1xp_none (loc) = '{
  e1xp_loc= loc, e1xp_node= E1XPnone ()
} // end of [e1xp_none]

implement
e1xp_string (loc, str) = '{
  e1xp_loc= loc, e1xp_node= E1XPstring (str)
} // end of [e1xp_string]

implement
e1xp_undef (loc) = '{
  e1xp_loc= loc, e1xp_node= E1XPundef ()
} // end of [e1xp_undef]

(* ****** ****** *)

implement e1xp_true  (loc) = e1xp_int (loc, "1")
implement e1xp_false (loc) = e1xp_int (loc, "0")

(* ****** ****** *)

implement v1al_true = V1ALint 1
implement v1al_false = V1ALint 0

(* ****** ****** *)

implement
effcst_contain
  (efc, eff) = case+ efc of
  | EFFCSTall () => true
  | EFFCSTnil () => false
  | EFFCSTset (efs, evs)  => effset_ismem (efs, eff)
// end of [effcst_contain]

implement
effcst_contain_ntm efc = effcst_contain (efc, effect_ntm)

(* ****** ****** *)

(*
** HX: functions for constructing sorts
*)

macdef MINUSGT = $SYM.symbol_MINUSGT
overload = with $SYM.eq_symbol_symbol

fn s0rtq_is_none (q: s0rtq): bool =
  case+ q.s0rtq_node of S0RTQnone () => true | _ => false
// end of [s0rtq_is_none]

(* ****** ****** *)

implement
s1rt_arrow (loc) = let
  val q = s0rtq_none (loc) in '{
  s1rt_loc= loc, s1rt_node= S1RTqid (q, MINUSGT)
} end // end of [s1rt_arrow]

(* '->' is a special sort constructor *)
implement
s1rt_is_arrow (s1t) =
  case+ s1t.s1rt_node of
  | S1RTqid (q, id) =>
      if s0rtq_is_none q then id = MINUSGT else false
    // end of [S1RTqid]
  | _ => false
// end of [s1rt_is_arrow]

(* ****** ****** *)

implement
s1rt_app (
  loc, s1t_fun, s1ts_arg
) = '{
  s1rt_loc= loc, s1rt_node= S1RTapp (s1t_fun, s1ts_arg)
} // end of [s1rt_app]

implement
s1rt_fun (loc, s1t1, s1t2) = let
  val s1ts = list_cons (s1t1, list_cons (s1t2, list_nil))
in '{
  s1rt_loc= loc, s1rt_node= S1RTapp (s1rt_arrow (loc), s1ts)
} end // end of [s1rt_fun]

implement
s1rt_ide (loc, id) = let
  val q = s0rtq_none (loc) in '{
  s1rt_loc= loc, s1rt_node= S1RTqid (q, id)
} end // end of [s1rt_ide]

implement
s1rt_list
  (loc, s1ts) = case+ s1ts of
  | list_cons (s1t, list_nil ()) => s1t // singleton elimination
  | _ => '{
      s1rt_loc= loc, s1rt_node= S1RTlist s1ts
    } // end of [_]
// end of [s1rt_list]

implement
s1rt_qid (loc, q, id) = '{
  s1rt_loc= loc,  s1rt_node= S1RTqid (q, id)
} // end of [s1rt_qid]

(*
implement
s1rt_tup (loc, s1ts) = '{
  s1rt_loc= loc, s1rt_node= S1RTtup s1ts
} // end of [s1rt_tup]
*)

implement
s1rt_type (loc, knd) = '{
  s1rt_loc= loc, s1rt_node= S1RTtype (knd)
}

(* ****** ****** *)

implement
s1rtpol_make (loc, s1t, pol) = '{
  s1rtpol_loc= loc, s1rtpol_srt= s1t, s1rtpol_pol= pol
} // end of [s1rtpol_make]

(* ****** ****** *)

implement
d1atsrtcon_make
  (loc, name, arg) = '{
  d1atsrtcon_loc= loc, d1atsrtcon_sym= name, d1atsrtcon_arg= arg
} // end of [d1atsrtcon_make]

implement
d1atsrtdec_make
  (loc, name, conlst) = '{
  d1atsrtdec_loc= loc, d1atsrtdec_sym= name, d1atsrtdec_con= conlst
} // end of [d1atsrtdec_make]

(* ****** ****** *)

implement
s1arg_make (loc, sym, res) = '{
  s1arg_loc= loc, s1arg_sym= sym, s1arg_srt= res
}

(* ****** ****** *)

implement
a1srt_make (loc, sym, srt) = '{
  a1srt_loc= loc, a1srt_sym= sym, a1srt_srt= srt
}
implement
a1msrt_make (loc, arg) = '{
  a1msrt_loc= loc, a1msrt_arg= arg
}

(* ****** ****** *)

implement
s1rtext_srt (loc, s1t) = '{
  s1rtext_loc= loc, s1rtext_node= S1TEsrt (s1t)
}

implement
s1rtext_sub (loc, sym, s1te, s1ps) = '{
  s1rtext_loc= loc, s1rtext_node= S1TEsub (sym, s1te, s1ps)
}

(* ****** ****** *)

implement
s1qua_prop (loc, s1p) = '{
  s1qua_loc= loc, s1qua_node= S1Qprop (s1p)
}

implement
s1qua_vars (loc, ids, s1te) = '{
  s1qua_loc= loc, s1qua_node= S1Qvars (ids, s1te)
}

(* ****** ****** *)

implement
s1exp_int (loc, int) = '{
  s1exp_loc= loc, s1exp_node= S1Eint (int)
}
implement
s1exp_char (loc, char) = '{
  s1exp_loc= loc, s1exp_node= S1Echar (char)
}

implement
s1exp_extype (loc, name, arg) = '{
  s1exp_loc= loc, s1exp_node= S1Eextype (name, arg)
}

implement
s1exp_ide (loc, id) = let
  val sq = s0taq_none (loc) in s1exp_sqid (loc, sq, id)
end // end of [s1exp_ide]

implement
s1exp_sqid (loc, sq, id) = '{
  s1exp_loc= loc, s1exp_node= S1Esqid (sq, id)
}

implement
s1exp_app (
  loc, _fun, loc_arg, _arg
) = '{
  s1exp_loc= loc, s1exp_node= S1Eapp (_fun, loc_arg, _arg)
} // end of [s1exp_app]

implement
s1exp_lam (loc, arg, res, body) = '{
  s1exp_loc= loc, s1exp_node= S1Elam (arg, res, body)
}

implement
s1exp_imp (
  loc, ft, is_lin, is_prf, efc
) = '{
  s1exp_loc= loc, s1exp_node= S1Eimp (ft, is_lin, is_prf, efc)
}

(* ****** ****** *)

implement
s1exp_list
  (loc, s1es) = case+ s1es of
//
// HX: singleton elimination is performed
//
  | list_cons (s1e, list_nil ()) => s1e
  | _ => '{
      s1exp_loc= loc, s1exp_node= S1Elist (~1(*npf*), s1es)
    } // end of [_]
// end of [s1exp_list]

implement
s1exp_list2
  (loc, s1es1, s1es2) =  let
  val npf = list_vt_length s1es1
  val s1es = list_vt_append (s1es1, s1es2)
  val s1es = l2l (s1es)
in '{
  s1exp_loc= loc, s1exp_node= S1Elist (npf, s1es)
} end // end of [s1exp_list2]

implement
s1exp_npf_list (loc, npf, s1es) =
  if npf >= 0 then '{
    s1exp_loc= loc, s1exp_node= S1Elist (npf, s1es)
  } else s1exp_list (loc, s1es)
// end of [s1exp_npf_list]

(* ****** ****** *)

implement
s1exp_top (loc, knd, s1e) = '{
  s1exp_loc= loc, s1exp_node= S1Etop (knd, s1e)
}

implement
s1exp_invar (loc, knd, s1e) = '{
  s1exp_loc= loc, s1exp_node= S1Einvar (knd, s1e)
}
implement
s1exp_trans (loc, s1e1, s1e2) = '{
  s1exp_loc= loc, s1exp_node= S1Etrans (s1e1, s1e2)
}

implement
s1exp_tyarr (loc, s1e_elt, s1es_dim) = '{
  s1exp_loc= loc, s1exp_node= S1Etyarr (s1e_elt, s1es_dim)
}

implement
s1exp_tytup (
  loc, knd, npf, s1es
) = '{
  s1exp_loc= loc, s1exp_node= S1Etytup (knd, npf, s1es)
}

implement
s1exp_tyrec (
  loc, knd, npf, ls1es
) = '{
  s1exp_loc= loc, s1exp_node= S1Etyrec (knd, npf, ls1es)
} // end of [s1exp_tyrec]

implement
s1exp_tyrec_ext (
  loc, name, npf, ls1es
) = '{
  s1exp_loc= loc, s1exp_node= S1Etyrec_ext (name, npf, ls1es)
} // end of [s1exp_tyrec_ext]

(* ****** ****** *)

implement
s1exp_exi (loc, knd, s1qs, s1e) = '{
  s1exp_loc= loc, s1exp_node= S1Eexi (knd, s1qs, s1e)
}

implement
s1exp_uni (loc, s1qs, s1e) = '{
  s1exp_loc= loc, s1exp_node= S1Euni (s1qs, s1e)
}

(* ****** ****** *)

implement
s1exp_ann (loc, s1e, s1t) = '{
  s1exp_loc= loc, s1exp_node= S1Eann (s1e, s1t)
}

(* ****** ****** *)

implement labs1exp_make (l, s1e) = L0ABELED (l, s1e)

(* ****** ****** *)

implement
q1marg_make (loc, arg) = '{
  q1marg_loc= loc, q1marg_arg= arg
} // end of [q1marg_make]

(* ****** ****** *)

implement
s1exparg_one (loc) = '{
  s1exparg_loc= loc, s1exparg_node= S1EXPARGone ()
}
implement
s1exparg_all (loc) = '{
  s1exparg_loc= loc, s1exparg_node= S1EXPARGall ()
}
implement
s1exparg_seq (loc, xs) = '{
  s1exparg_loc= loc, s1exparg_node= S1EXPARGseq (xs)
}

(* ****** ****** *)

implement
s1rtdef_make (
  loc, sym, s1te
) = '{
  s1rtdef_loc= loc
, s1rtdef_sym= sym
, s1rtdef_def= s1te
} // end of [s1rtdef_make]

(* ****** ****** *)

implement
s1tacst_make (
  loc, sym, arg, res
) = '{
  s1tacst_loc= loc
, s1tacst_sym= sym
, s1tacst_arg= arg
, s1tacst_res= res
} // end of [s1tacst_make]

implement
s1tacon_make (
  loc, sym, arg, def
) = '{
  s1tacon_loc= loc
, s1tacon_sym= sym
, s1tacon_arg= arg
, s1tacon_def= def
} // end of [s1tacon_make]

implement
s1tavar_make (
  loc, sym, srt
) = '{
  s1tavar_loc= loc
, s1tavar_sym= sym
, s1tavar_srt= srt
} // end of [s1tavar_make]

(* ****** ****** *)

implement
s1expdef_make (
  loc, id, arg, res, def
) = '{
  s1expdef_loc= loc
, s1expdef_sym= id
, s1expdef_arg= arg
, s1expdef_res= res
, s1expdef_def= def
} // end of [s1expdef_make]

implement
s1aspdec_make (
  loc, qid, arg, res, def
) = '{
  s1aspdec_loc= loc
, s1aspdec_qid= qid
, s1aspdec_arg= arg
, s1aspdec_res= res
, s1aspdec_def= def
} // end of [s1aspdec_make]

(* ****** ****** *)

implement
d1cstdec_make (
  loc, fil, id, s1e, extdef
) = '{
  d1cstdec_loc= loc
, d1cstdec_fil= fil
, d1cstdec_sym= id
, d1cstdec_typ= s1e
, d1cstdec_extdef= extdef
} // end of [d1cstdec_make]

(* ****** ****** *)

implement
d1atcon_make (
  loc, id, qua, npf, arg, ind
) = '{
  d1atcon_loc= loc
, d1atcon_sym= id
, d1atcon_qua= qua
, d1atcon_npf= npf
, d1atcon_arg= arg
, d1atcon_ind= ind
} // end of [d1atcon_make]

implement
d1atdec_make (loc, fil, id, arg, con) = '{
  d1atdec_loc= loc
, d1atdec_fil= fil
, d1atdec_sym= id
, d1atdec_arg= arg
, d1atdec_con= con
} // end of [d1atdec_make]

implement
e1xndec_make (loc, fil, id, qua, npf, arg) = '{
  e1xndec_loc= loc
, e1xndec_fil= fil
, e1xndec_sym= id
, e1xndec_qua= qua
, e1xndec_npf= npf
, e1xndec_arg= arg
} // end of [e1xndec_make]

(* ****** ****** *)

(* end of [pats_staexp1.dats] *)

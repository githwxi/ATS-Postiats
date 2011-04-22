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

staload "pats_syntax.sats"
staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"

(* ****** ****** *)

implement
p1at_any (loc) = '{
  p1at_loc= loc, p1at_node= P1Tany ()
}
implement
p1at_anys (loc) = '{
  p1at_loc= loc, p1at_node= P1Tanys ()
}

implement
p1at_ide (loc, id) = let
  val dq = d0ynq_none (loc) in p1at_dqid (loc, dq, id)
end // end of [p1at_ide]
implement
p1at_dqid (loc, dq, id) = '{
  p1at_loc= loc, p1at_node= P1Tdqid (dq, id)
}

implement
p1at_ref (loc, id) = '{
  p1at_loc= loc, p1at_node= P1Tref (id)
}

implement
p1at_int (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tint (x)
}
implement
p1at_char (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tchar (x)
}
implement
p1at_float (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tfloat (x)
}
implement
p1at_string (loc, x) = '{
  p1at_loc= loc, p1at_node= P1Tstring (x)
}
implement
p1at_empty (loc) = '{
  p1at_loc= loc, p1at_node= P1Tempty ()
}

implement
p1at_app_dyn (
  loc, _fun, loc_arg, npf, _arg
) = '{
  p1at_loc= loc
, p1at_node= P1Tapp_dyn (_fun, loc_arg, npf, _arg)
} // end of [p1at_app_dyn]

implement
p1at_app_sta
  (loc, _fun, _arg) = '{
  p1at_loc= loc, p1at_node= P1Tapp_sta (_fun, _arg)
} // end of [p1at_app_sta]

implement
p1at_list (loc, npf, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Tlist (npf, p1ts)
}

implement
p1at_lst (loc, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Tlst (p1ts)
}
implement
p1at_tup (loc, knd, npf, p1ts) = '{
  p1at_loc= loc, p1at_node= P1Ttup (knd, npf, p1ts)
}
implement
p1at_rec (loc, knd, npf, lp1ts) = '{
  p1at_loc= loc, p1at_node= P1Trec (knd, npf, lp1ts)
}

implement
p1at_free (loc, p1t) = '{
  p1at_loc= loc, p1at_node= P1Tfree (p1t)
}
implement
p1at_as (loc, id, p1t) = '{
  p1at_loc= loc, p1at_node= P1Tas (id, p1t)
}
implement
p1at_refas (loc, id, p1t) = '{
  p1at_loc= loc, p1at_node= P1Trefas (id, p1t)
}

implement
p1at_exist (loc, arg, p1t) = '{
  p1at_loc= loc, p1at_node= P1Texist (arg, p1t)
}
implement
p1at_svararg (loc, arg) = '{
  p1at_loc= loc, p1at_node= P1Tsvararg (arg)
}

implement
p1at_ann (loc, p1t, ann) = '{
  p1at_loc= loc, p1at_node= P1Tann (p1t, ann)
}

(* ****** ****** *)

implement
i1nvarg_make (
  loc, id, os1e
) = '{
  i1nvarg_loc= loc, i1nvarg_sym= id, i1nvarg_typ= os1e
} // end of [i1nvarg_make]

implement
i1nvresstate_make
  (s1qs, arg) = '{
  i1nvresstate_qua= s1qs, i1nvresstate_arg= arg
}

implement
i1nvresstate_nil =
  i1nvresstate_make (list_nil (), list_nil ())
// end of [i1nvresstate_nil]

(* ****** ****** *)
//
// HX: dynamic expressions
//
(* ****** ****** *)

implement
d1exp_ide (loc, id) = let
  val dq = d0ynq_none (loc) in d1exp_dqid (loc, dq, id)
end // end of [d1exp_ide]

implement
d1exp_dqid (loc, dq, id) = '{
  d1exp_loc= loc, d1exp_node= D1Edqid (dq, id)
}
implement
d1exp_opid (loc, id) = let
  val dq = d0ynq_none (loc) in d1exp_dqid (loc, dq, id)
end // end of [d1exp_opid]

implement
d1exp_char (loc, x) = '{
  d1exp_loc= loc, d1exp_node= D1Echar (x)
}
implement
d1exp_float (loc, x) = '{
  d1exp_loc= loc, d1exp_node= D1Efloat (x)
}
implement
d1exp_string (loc, x) = '{
  d1exp_loc= loc, d1exp_node= D1Estring (x)
}
implement
d1exp_cstsp (loc, x) = '{
  d1exp_loc= loc, d1exp_node= D1Ecstsp (x)
}
implement
d1exp_empty (loc) = '{
  d1exp_loc= loc, d1exp_node= D1Eempty ()
}
implement
d1exp_top (loc) = '{
  d1exp_loc= loc, d1exp_node= D1Etop ()
}

(* ****** ****** *)

implement
d1exp_extval (loc, _type, _code) = '{
  d1exp_loc= loc, d1exp_node= D1Eextval (_type, _code)
}

(* ****** ****** *)

implement
d1exp_loopexn (loc, knd) = '{
  d1exp_loc= loc, d1exp_node= D1Eloopexn (knd)
}

(* ****** ****** *)

implement
d1exp_foldat (loc, s1as, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Efoldat (s1as, d1e)
}
implement
d1exp_freeat (loc, s1as, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Efreeat (s1as, d1e)
}

implement
d1exp_let (loc, d1cs, body) = '{
  d1exp_loc= loc, d1exp_node= D1Elet (d1cs, body)
}

implement
d1exp_list (loc, npf, d1es) = '{
  d1exp_loc= loc, d1exp_node= D1Elist (npf, d1es)
}

(* ****** ****** *)

implement
d1exp_app_sta (loc, d1e, s1as) = '{
  d1exp_loc= loc, d1exp_node= D1Eapp_sta (d1e, s1as)
} // end of [d1exp_app_sta]

implement
d1exp_app_dyn
  (loc, d1e, loc_arg, npf, d1es) = '{
  d1exp_loc= loc, d1exp_node= D1Eapp_dyn (d1e, loc_arg, npf, d1es)
} // end of [d1exp_app_dyn]

implement
d1exp_idextapp
  (loc, id, ns, d1es) = '{ // for syndef
  d1exp_loc= loc, d1exp_node= D1Eidextapp (id, ns, d1es)
} // end of [d1exp_idextapp]

(* ****** ****** *)

implement
d1exp_ifhead (
  loc, inv, _cond, _then, _else
) = '{
  d1exp_loc= loc
, d1exp_node= D1Eifhead (inv, _cond, _then, _else)
} // end of [d1exp_ifhead]

implement
d1exp_sifhead (
  loc, inv, _cond, _then, _else
) = '{
  d1exp_loc= loc
, d1exp_node= D1Esifhead (inv, _cond, _then, _else)
} // end of [d1exp_sifhead]

implement
d1exp_casehead (
  loc, inv, d1e, c1las
) = '{
  d1exp_loc= loc
, d1exp_node= D1Ecasehead (inv, d1e, c1las)
} // end of [d1exp_casehead]

implement
d1exp_scasehead (
  loc, inv, s1e, c1las
) = '{
  d1exp_loc= loc
, d1exp_node= D1Escasehead (inv, s1e, c1las)
} // end of [d1exp_scasehead]

(* ****** ****** *)

implement
d1exp_lst (loc, knd, elt, d1es) = '{
  d1exp_loc= loc, d1exp_node= D1Elst (knd, elt, d1es)
}
implement
d1exp_tup (loc, knd, npf, d1es) = '{
  d1exp_loc= loc, d1exp_node= D1Etup (knd, npf, d1es)
}
implement
d1exp_rec (loc, knd, npf, ld1es) = '{
  d1exp_loc= loc, d1exp_node= D1Erec (knd, npf, ld1es)
}
implement
d1exp_seq (loc, d1es) = '{
  d1exp_loc= loc, d1exp_node= D1Eseq (d1es)
}

(* ****** ****** *)

implement
d1exp_lam_dyn (loc, lin, p1t, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Elam_dyn (lin, p1t, d1e)
} // end of [d1exp_lam_dyn]

implement
d1exp_laminit_dyn (loc, lin, p1t, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Elaminit_dyn (lin, p1t, d1e)
} // end of [d1exp_laminit_dyn]

implement
d1exp_lam_met (loc, loc_arg, s1es, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Elam_met (loc_arg, s1es, d1e)
}
implement
d1exp_lam_sta_ana (loc, loc_arg, s1as, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Elam_sta_ana (loc_arg, s1as, d1e)
}
implement
d1exp_lam_sta_syn (loc, loc_arg, s1qs, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Elam_sta_syn (loc_arg, s1qs, d1e)
}

implement
d1exp_fix (loc, knd, id, d1e) = '{
  d1exp_loc= loc, d1exp_node= D1Efix (knd, id, d1e)
}

(* ****** ****** *)

implement
d1exp_raise (loc, d1e) = '{
  d1exp_loc= loc, d1exp_node=D1Eraise (d1e)
}
implement
d1exp_delay (loc, knd, d1e) = '{
  d1exp_loc= loc, d1exp_node=D1Edelay (knd, d1e)
}

implement
d1exp_ptrof (loc, d1e) = '{
  d1exp_loc= loc, d1exp_node=D1Eptrof (d1e)
}
implement
d1exp_viewat (loc, d1e) = '{
  d1exp_loc= loc, d1exp_node=D1Eviewat (d1e)
}

implement
d1exp_sel (loc, knd, d1e, d1l) = '{
  d1exp_loc= loc, d1exp_node= D1Esel (knd, d1e, d1l)
}

(* ****** ****** *)

implement
d1exp_trywith (loc, inv, d1e, c1las) = '{
  d1exp_loc= loc, d1exp_node= D1Etrywith (inv, d1e, c1las)
}

implement
d1exp_for (
  loc, inv, ini, test, post, body
) = '{
  d1exp_loc= loc, d1exp_node=D1Efor (inv, ini, test, post, body)
} // end of [d1exp_for]

implement
d1exp_while
  (loc, inv, test, body) = '{
  d1exp_loc= loc, d1exp_node=D1Ewhile (inv, test, body)
} // end of [d1exp_while]

(* ****** ****** *)

implement
d1exp_ann_effc (loc, d1e, efc) = '{
  d1exp_loc= loc, d1exp_node= D1Eann_effc (d1e, efc)
}

implement
d1exp_ann_funclo (loc, d1e, fc) = '{
  d1exp_loc= loc, d1exp_node= D1Eann_funclo (d1e, fc)
}
implement
d1exp_ann_funclo_opt (loc, d1e, fc) = begin
  case+ d1e.d1exp_node of
  | D1Eann_funclo _ => d1e | _ => d1exp_ann_funclo (loc, d1e, fc)
end // end of [d1exp_ann_funclo_opt]

implement
d1exp_ann_type (loc, d1e, s1e) = '{
  d1exp_loc= loc, d1exp_node= D1Eann_type (d1e, s1e)
}

(* ****** ****** *)

implement
d1exp_is_metric (d1e) = begin
  case+ d1e.d1exp_node of
  | D1Elam_dyn (_, _, d1e) => d1exp_is_metric d1e
  | D1Elam_met _ => true
  | D1Elam_sta_ana (_, _, d1e) => d1exp_is_metric d1e
  | D1Elam_sta_syn (_, _, d1e) => d1exp_is_metric d1e
  | _ => false
end // end of [d1exp_is_metric]

(* ****** ****** *)

implement d1lab_lab (loc, lab) = '{
  d1lab_loc= loc, d1lab_node= D1LABlab lab
}
implement d1lab_ind (loc, ind) = '{
  d1lab_loc= loc, d1lab_node= D1LABind ind
}

(* ****** ****** *)
//
// HX: declarations
//
(* ****** ****** *)

implement
m1acdef_make
  (loc, id, arg, def) = '{
  m1acdef_loc= loc
, m1acdef_sym= id, m1acdef_arg= arg, m1acdef_def= def
} // end of [m1acdef_make]

(* ****** ****** *)

implement
v1aldec_make
  (loc, p1t, d1e, ann) = '{
  v1aldec_loc= loc
, v1aldec_pat= p1t
, v1aldec_def= d1e
, v1aldec_ann= ann
} // end of [v1aldec_make]

implement
f1undec_make
  (loc, id, loc_id, d1e, ann) = '{
  f1undec_loc= loc
, f1undec_sym= id
, f1undec_sym_loc= loc_id
, f1undec_def= d1e
, f1undec_ann= ann
} // end of [f1undec_make]

implement v1ardec_make
  (loc, knd, id, loc_id, os1e, wth, od1e) = '{
  v1ardec_loc= loc
, v1ardec_knd= knd
, v1ardec_sym= id
, v1ardec_sym_loc= loc_id
, v1ardec_typ= os1e
, v1ardec_wth= wth // i0deopt
, v1ardec_ini= od1e
} // end of [v1ardec_make]

(* ****** ****** *)

implement
d1ecl_none (loc) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cnone ()
} // end of [d1ecl_none]

implement
d1ecl_list (loc, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Clist (ds)
} // end of [d1ecl_list]

(* ****** ****** *)

implement
d1ecl_symintr (loc, ids) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csymintr (ids)
}

implement
d1ecl_symelim (loc, ids) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csymelim (ids)
}

implement
d1ecl_overload (loc, id, qid) = '{
  d1ecl_loc= loc, d1ecl_node= D1Coverload (id, qid)
}

(* ****** ****** *)

implement
d1ecl_e1xpdef (loc, id, def) = '{
  d1ecl_loc= loc, d1ecl_node= D1Ce1xpdef (id, def)
}
implement
d1ecl_e1xpundef (loc, id) = '{
  d1ecl_loc= loc, d1ecl_node= D1Ce1xpundef (id)
}

(* ****** ****** *)

implement
d1ecl_datsrts (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdatsrts (xs)
}

implement
d1ecl_srtdefs (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csrtdefs (xs)
}

(* ****** ****** *)

implement
d1ecl_stacsts (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstacsts (xs)
}

implement
d1ecl_stacons (loc, knd, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstacons (knd, xs)
}

implement
d1ecl_stavars (loc, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cstavars (xs)
}

(* ****** ****** *)

implement
d1ecl_sexpdefs (loc, knd, xs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csexpdefs (knd, xs)
}

implement
d1ecl_saspdec (loc, x) = '{
  d1ecl_loc= loc, d1ecl_node= D1Csaspdec (x)
}

(* ****** ****** *)

implement
d1ecl_datdecs (
  loc, knd, d1cs_datdec, d1cs_sexpdef
) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdatdecs (knd, d1cs_datdec, d1cs_sexpdef)
} // end of [d1ecl_datdecs]

implement
d1ecl_exndecs (loc, d1cs) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cexndecs (d1cs)
}

(* ****** ****** *)

implement
d1ecl_classdec (loc, id, sup) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cclassdec (id, sup)
}

(* ****** ****** *)

implement
d1ecl_dcstdecs (loc, dck, qarg, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cdcstdecs (dck, qarg, ds)
} // end of [d1ecl_dcstdecs]

(* ****** ****** *)

implement
d1ecl_extcode
  (loc, knd, pos, code) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cextcode (knd, pos, code)
} // end of [d1ecl_extcode]

(* ****** ****** *)

implement
d1ecl_macdefs (loc, knd, isrec, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cmacdefs (knd, isrec, ds)
}

(* ****** ****** *)

implement
d1ecl_valdecs
  (loc, knd, isrec, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cvaldecs (knd, isrec, ds)
}
implement
d1ecl_fundecs
  (loc, knd, qarg, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cfundecs (knd, qarg, ds)
}
implement
d1ecl_vardecs (loc, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cvardecs (ds)
}

(* ****** ****** *)

implement
d1ecl_include (loc, ds) = '{
  d1ecl_loc= loc, d1ecl_node= D1Cinclude (ds)
} // end of [d1ecl_include]

(* ****** ****** *)

implement
d1ecl_local (loc, ds_head, ds_body) = '{
  d1ecl_loc= loc, d1ecl_node= D1Clocal (ds_head, ds_body)
}

(* ****** ****** *)

(* end of [pats_dynexp1.dats] *)

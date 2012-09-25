(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: July, 2012
//
(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"
staload "pats_hidynexp.sats"

(* ****** ****** *)

implement
hipat_get_type (hip) = hip.hipat_type

(* ****** ****** *)

implement
hipatlst_is_unused
  (hips) = let
//
fun f (hip: hipat): bool =
  case+ hip.hipat_node of HIPany () => true | _ => false
//
in
  list_forall_fun (hips, f)
end // end of [hipatlst_is_unused]

(* ****** ****** *)

implement
hipat_make_node
  (loc, hse, node) = '{
  hipat_loc= loc, hipat_type= hse, hipat_node= node
} // end of [hipat_make_node]

implement
hipat_any (loc, hse) =
  hipat_make_node (loc, hse, HIPany ())
// end of [hipat_any]

implement
hipat_var (loc, hse, d2v) =
  hipat_make_node (loc, hse, HIPvar (d2v))
// end of [hipat_var]

(* ****** ****** *)

implement
hipat_con (
  loc, hse, pck, d2c, hips, hse_sum
) = hipat_make_node (loc, hse, HIPcon (pck, d2c, hips, hse_sum))

implement
hipat_con_any
  (loc, hse, pck, d2c) =
  hipat_make_node (loc, hse, HIPcon_any (pck, d2c))
// end of [hipat_con_any]

(* ****** ****** *)

implement
hipat_int
  (loc, hse, i) =
  hipat_make_node (loc, hse, HIPint (i))
// end of [hipat_int]

implement
hipat_bool
  (loc, hse, b) =
  hipat_make_node (loc, hse, HIPbool (b))
// end of [hipat_bool]

implement
hipat_char
  (loc, hse, c) =
  hipat_make_node (loc, hse, HIPchar (c))
// end of [hipat_char]

implement
hipat_string
  (loc, hse, str) =
  hipat_make_node (loc, hse, HIPstring (str))
// end of [hipat_string]

implement
hipat_float
  (loc, hse, rep) =
  hipat_make_node (loc, hse, HIPfloat (rep))
// end of [hipat_float]

(* ****** ****** *)

implement
hipat_i0nt
  (loc, hse, tok) =
  hipat_make_node (loc, hse, HIPi0nt (tok))
// end of [hipat_i0nt]

implement
hipat_f0loat
  (loc, hse, tok) =
  hipat_make_node (loc, hse, HIPf0loat (tok))
// end of [hipat_f0loat]

(* ****** ****** *)

implement
hipat_empty
  (loc, hse) =
  hipat_make_node (loc, hse, HIPempty ())
// end of [hipat_empty]

(* ****** ****** *)

implement
hipat_rec (
  loc, hse, knd, lhips, hse_rec
) =
  hipat_make_node (loc, hse, HIPrec (knd, lhips, hse_rec))
// end of [hipat_rec]

implement
hipat_lst
  (loc, hse, hse_elt, hips) =
  hipat_make_node (loc, hse, HIPlst (hse_elt, hips))
// end of [hipat_lst]

(* ****** ****** *)

implement
hipat_refas
  (loc, hse, d2v, hip) =
  hipat_make_node (loc, hse, HIPrefas (d2v, hip))
// end of [hipat_refas]

(* ****** ****** *)

implement
hipat_ann
  (loc, hse, hip, hse_ann) =
  hipat_make_node (loc, hse, HIPann (hip, hse_ann))
// end of [hipat_ann]

(* ****** ****** *)

implement
hidexp_make_node
  (loc, hse, node) = '{
  hidexp_loc= loc, hidexp_type= hse, hidexp_node= node
} // end of [hidexp_make_node]

(* ****** ****** *)

implement
hidexp_var
  (loc, hse, d2v) =
  hidexp_make_node (loc, hse, HDEvar (d2v))
// end of [hidexp_var]

implement
hidexp_cst
  (loc, hse, d2c) =
  hidexp_make_node (loc, hse, HDEcst (d2c))
// end of [hidexp_cst]

(* ****** ****** *)

implement
hidexp_bool
  (loc, hse, b) =
  hidexp_make_node (loc, hse, HDEbool (b))
// end of [hidexp_bool]

implement
hidexp_char
  (loc, hse, c) =
  hidexp_make_node (loc, hse, HDEchar (c))
// end of [hidexp_char]

implement
hidexp_string
  (loc, hse, str) =
  hidexp_make_node (loc, hse, HDEstring (str))
// end of [hidexp_string]

(* ****** ****** *)

implement
hidexp_i0nt
  (loc, hse, tok) =
  hidexp_make_node (loc, hse, HDEi0nt (tok))
// end of [hidexp_i0nt]

implement
hidexp_f0loat
  (loc, hse, tok) =
  hidexp_make_node (loc, hse, HDEf0loat (tok))
// end of [hidexp_f0loat]

(* ****** ****** *)

implement
hidexp_extval
  (loc, hse, name) =
  hidexp_make_node (loc, hse, HDEextval (name))
// end of [hidexp_extval]

(* ****** ****** *)

implement
hidexp_let (loc, hse, hids, hde) =
  hidexp_make_node (loc, hse, HDElet (hids, hde))
// end of [hidexp_let]

(* ****** ****** *)

implement
hidexp_app
  (loc, hse, hse_fun, _fun, _arg) =
  hidexp_make_node (loc, hse, HDEapp (hse_fun, _fun, _arg))
// end of [hidexp_app]

(* ****** ****** *)

implement
hidexp_if
  (loc, hse, _cond, _then, _else) =
  hidexp_make_node (loc, hse, HDEif (_cond, _then, _else))
// end of [hidexp_if]

(* ****** ****** *)

implement
hidexp_case
  (loc, hse, knd, hdes, hcls) =
  hidexp_make_node (loc, hse, HDEcase (knd, hdes, hcls))
// end of [hidexp_case]

(* ****** ****** *)

implement
hidexp_rec
  (loc, hse, knd, lhses, hse_rec) =
  hidexp_make_node (loc, hse, HDErec (knd, lhses, hse_rec))
// end of [hidexp_rec]

implement
hidexp_seq
  (loc, hse, hdes) =
  hidexp_make_node (loc, hse, HDEseq (hdes))
// end of [hidexp_seq]

(* ****** ****** *)

implement
hidexp_assgn_var
  (loc, hse, d2v_l, hils, hde_r) =
  hidexp_make_node (loc, hse, HDEassgn_var (d2v_l, hils, hde_r))
// end of [hidexp_assgn_var]

implement
hidexp_assgn_ptr
  (loc, hse, hde_l, hils, hde_r) =
  hidexp_make_node (loc, hse, HDEassgn_ptr (hde_l, hils, hde_r))
// end of [hidexp_assgn_ptr]

(* ****** ****** *)

implement
hidexp_arrpsz
  (loc, hse, hse_elt, hdes, asz) =
  hidexp_make_node (loc, hse, HDEarrpsz (hse_elt, hdes, asz))
// end of [hidexp_arrpsz]

(* ****** ****** *)

implement
hidexp_lam
  (loc, hse, hips_arg, hde_body) =
  hidexp_make_node (loc, hse, HDElam (hips_arg, hde_body))
// end of [hidexp_lam]

(* ****** ****** *)

implement
hidexp_tmpcst
  (loc, hse, d2c, t2mas) =
  hidexp_make_node (loc, hse, HDEtmpcst (d2c, t2mas))
// end of [hidexp_tmpcst]

implement
hidexp_tmpvar
  (loc, hse, d2v, t2mas) =
  hidexp_make_node (loc, hse, HDEtmpvar (d2v, t2mas))
// end of [hidexp_tmpvar]

(* ****** ****** *)

implement
hilab_lab (loc, lab) = '{
  hilab_loc= loc, hilab_node = HILlab (lab)
}
implement
hilab_ind (loc, ind) = '{
  hilab_loc= loc, hilab_node = HILind (ind)
}

(* ****** ****** *)

implement
higmat_make
  (loc, ghde, ghip) = '{
  higmat_loc= loc
, higmat_exp= ghde
, higmat_pat= ghip
} // end of [higmat_make]

implement
hiclau_make
  (loc, hips, gua, seq, neg, body) = '{
  hiclau_loc= loc
, hiclau_pat= hips
, hiclau_gua= gua
, hiclau_seq= seq
, hiclau_neg= neg
, hiclau_body= body
} // end of [hiclau_make]

(* ****** ****** *)

implement
hiimpdec_make (
  loc, d2c, imparg, tmparg, def
) = '{
  hiimpdec_loc= loc
, hiimpdec_cst= d2c
, hiimpdec_imparg= imparg
, hiimpdec_tmparg= tmparg
, hiimpdec_def= def
} // end of [hiimpdec_make]

(* ****** ****** *)

implement
hifundec_make
  (loc, d2v, def) = '{
  hifundec_loc= loc
, hifundec_var= d2v
, hifundec_def= def
} // end of [hifundec_make]

implement
hivaldec_make
  (loc, pat, def) = '{
  hivaldec_loc= loc
, hivaldec_pat= pat
, hivaldec_def= def
} // end of [hivaldec_make]

implement
hivardec_make (
  loc, knd, d2v, d2vw, type, ini
) = '{
  hivardec_loc= loc
, hivardec_knd= knd
, hivardec_dvar_ptr= d2v
, hivardec_dvar_view= d2vw
, hivardec_type= type
, hivardec_ini= ini
} // end of [hivardec_make]

(* ****** ****** *)

implement
hidecl_make_node
  (loc, node) = '{
  hidecl_loc= loc, hidecl_node= node
} // end of [hidecl_make_node]

implement
hidecl_none (loc) =
  hidecl_make_node (loc, HIDnone ())
// end of [hidecl_none]

implement
hidecl_list (loc, hids) =
  hidecl_make_node (loc, HIDlist (hids))
// end of [hidecl_list]

(* ****** ****** *)

implement
hidecl_impdec
  (loc, knd, himpdec) =
  hidecl_make_node (loc, HIDimpdec (knd, himpdec))
// end of [hidecl_impdec]

(* ****** ****** *)

implement
hidecl_fundecs
  (loc, knd, decarg, hfds) =
  hidecl_make_node (loc, HIDfundecs (knd, decarg, hfds))
// end of [hidecl_fundecs]

(* ****** ****** *)

implement
hidecl_valdecs (loc, knd, hvds) =
  hidecl_make_node (loc, HIDvaldecs (knd, hvds))
// end of [hidecl_valdecs]

implement
hidecl_valdecs_rec (loc, knd, hvds) =
  hidecl_make_node (loc, HIDvaldecs_rec (knd, hvds))
// end of [hidecl_valdecs_rec]

(* ****** ****** *)

implement
hidecl_vardecs (loc, hvds) =
  hidecl_make_node (loc, HIDvardecs (hvds))
// end of [hidecl_vardecs]

(* ****** ****** *)

implement
hidecl_staload (
  loc, fname, flag, loaded, fenv
) = hidecl_make_node (
  loc, HIDstaload (fname, flag, loaded, fenv)
) // end of [hidecl_staload]

(* ****** ****** *)

implement
hidecl_local (loc, head, body) =
  hidecl_make_node (loc, HIDlocal (head, body))
// end of [hidecl_local]

(* ****** ****** *)

(* end of [pats_hidynexp.dats] *)

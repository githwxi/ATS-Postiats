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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

implement
hipat_get_type (hip) = hip.hipat_type

(* ****** ****** *)

implement
labhipatlst_is_unused
  (lhips) = let
//
fun f (
  lhip: labhipat
) : bool = let
  val LABHIPAT (_, hip) = lhip
in
  case+ hip.hipat_node of HIPany () => true | _ => false
end // end of [f]
//
in
  list_forall_fun (lhips, f)
end // end of [labhipatlst_is_unused]

(* ****** ****** *)

implement
hipat_make_node (
  loc, hse, node
) = '{
  hipat_loc= loc
, hipat_type= hse, hipat_node= node, hipat_asvar= None(*d2v*)
} // end of [hipat_make_node]

(* ****** ****** *)

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
  loc, hse, pck, d2c, hse_sum, lhips
) = hipat_make_node
  (loc, hse, HIPcon (pck, d2c, hse_sum, lhips))
// end of [hipat_con]

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
hidexp_get_type (hde) = hde.hidexp_type
implement
hidexplst_get_type (hdes) = let
  val hses =
    list_map_fun (hdes, hidexp_get_type) in list_of_list_vt (hses)
  // end of [val]
end // end of [hidexplst_get_type]

(* ****** ****** *)

implement
hidexp_make_node
  (loc, hse, node) = '{
  hidexp_loc= loc, hidexp_type= hse, hidexp_node= node
} // end of [hidexp_make_node]

(* ****** ****** *)

implement
hidexp_cst
  (loc, hse, d2c) =
  hidexp_make_node (loc, hse, HDEcst (d2c))
// end of [hidexp_cst]

implement
hidexp_var
  (loc, hse, d2v) =
  hidexp_make_node (loc, hse, HDEvar (d2v))
// end of [hidexp_var]

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
hidexp_cstsp (loc, hse, x) = 
  hidexp_make_node (loc, hse, HDEcstsp (x))
// end of [hidexp_cstsp]

(* ****** ****** *)

implement
hidexp_top (loc, hse) = 
  hidexp_make_node (loc, hse, HDEtop ())
// end of [hidexp_top]

implement
hidexp_empty (loc, hse) = 
  hidexp_make_node (loc, hse, HDEempty ())
// end of [hidexp_empty]

(* ****** ****** *)

implement
hidexp_extval
  (loc, hse, name) =
  hidexp_make_node (loc, hse, HDEextval (name))
// end of [hidexp_extval]

(* ****** ****** *)

implement
hidexp_castfn
  (loc, hse, d2c, arg) =
  hidexp_make_node (loc, hse, HDEcastfn (d2c, arg))
// end of [hidexp_castfn]

(* ****** ****** *)

implement
hidexp_con (
  loc, hse, d2c, hse_sum, lhdes
) = hidexp_make_node
  (loc, hse, HDEcon (d2c, hse_sum, lhdes))
// end of [hidexp_con]

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
hidexp_foldat (loc, hse) =
  hidexp_make_node (loc, hse, HDEfoldat ())

implement
hidexp_freeat (loc, hse, hde) =
  hidexp_make_node (loc, hse, HDEfreeat (hde))
// end of [hidexp_freeat]

(* ****** ****** *)

implement
hidexp_let (loc, hse, hids, hde) =
  hidexp_make_node (loc, hse, HDElet (hids, hde))
// end of [hidexp_let]

(* ****** ****** *)

implement
hidexp_app
  (loc, hse, hse_fun, _fun, _arg) =
  hidexp_make_node (loc, hse, HDEapp (_fun, hse_fun, _arg))
// end of [hidexp_app]

implement
hidexp_app2 (
  loc0, hse, hse_fun, _fun, _arg
) = let
//
val opt = (
  case+ _fun.hidexp_node of
  | HDEcst (d2c) =>
      if d2cst_is_castfn (d2c) then Some_vt (d2c) else None_vt
  | _ => None_vt ()
) : Option_vt (d2cst)
//
in
//
case+ opt of
| ~Some_vt (d2c) => let
    val hde = (
      case+ _arg of
      | list_cons (hse, _) => hse
      | list_nil () => let
          val loc = _fun.hidexp_loc
          val hse = hisexp_void_type ()
        in
          hidexp_empty (loc, hse)
        end // end of [list_nil]
    ) : hidexp // end of [val]
  in
    hidexp_castfn (loc0, hse, d2c, hde)
  end // end of [Some_vt]
| ~None_vt () =>
    hidexp_app (loc0, hse, hse_fun, _fun, _arg)
  // end of [None_vt]
//
end // end of [hidexp_app2]

(* ****** ****** *)

implement
hidexp_if
  (loc, hse, _cond, _then, _else) =
  hidexp_make_node (loc, hse, HDEif (_cond, _then, _else))
// end of [hidexp_if]

implement
hidexp_sif
  (loc, hse, _cond, _then, _else) =
  hidexp_make_node (loc, hse, HDEsif (_cond, _then, _else))
// end of [hidexp_sif]

(* ****** ****** *)

implement
hidexp_case
  (loc, hse, knd, hdes, hcls) =
  hidexp_make_node (loc, hse, HDEcase (knd, hdes, hcls))
// end of [hidexp_case]

(* ****** ****** *)

implement
hidexp_lst
  (loc, hse, lin, hse_elt, hdes) =
  hidexp_make_node (loc, hse, HDElst (lin, hse_elt, hdes))
// end of [hidexp_lst]

implement
hidexp_rec
  (loc, hse, knd, lhdes, hse_rec) =
  hidexp_make_node (loc, hse, HDErec (knd, lhdes, hse_rec))
// end of [hidexp_rec]

implement
hidexp_seq
  (loc, hse, hdes) =
  hidexp_make_node (loc, hse, HDEseq (hdes))
// end of [hidexp_seq]

(* ****** ****** *)

implement
hidexp_selab
  (loc, hse, hde, hse_flt, hils) =
  hidexp_make_node (loc, hse, HDEselab (hde, hse_flt, hils))
// end of [hidexp_selab]

(* ****** ****** *)

implement
hidexp_ptrofvar
  (loc, hse, d2v) =
  hidexp_make_node (loc, hse, HDEptrofvar (d2v))
// end of [hidexp_ptrofvar]

implement
hidexp_ptrofsel
  (loc, hse, hde, s2rt, hils) =
  hidexp_make_node (loc, hse, HDEptrofsel (hde, s2rt, hils))
// end of [hidexp_ptrofsel]

(* ****** ****** *)

implement
hidexp_refarg
  (loc, hse, refval, freeknd, hde) =
  hidexp_make_node (loc, hse, HDErefarg (refval, freeknd, hde))
// end of [hidexp_refarg]

(* ****** ****** *)

implement
hidexp_sel_var
  (loc, hse, d2v, hse_rt, hils) =
  hidexp_make_node (loc, hse, HDEsel_var (d2v, hse_rt, hils))
// end of [hidexp_sel_var]

implement
hidexp_sel_ptr
  (loc, hse, hde, hse_rt, hils) =
  hidexp_make_node (loc, hse, HDEsel_ptr (hde, hse_rt, hils))
// end of [hidexp_sel_ptr]

(* ****** ****** *)

implement
hidexp_assgn_var
  (loc, hse, d2v_l, hse_rt, hils, hde_r) =
  hidexp_make_node (loc, hse, HDEassgn_var (d2v_l, hse_rt, hils, hde_r))
// end of [hidexp_assgn_var]

implement
hidexp_assgn_ptr
  (loc, hse, hde_l, hse_rt, hils, hde_r) =
  hidexp_make_node (loc, hse, HDEassgn_ptr (hde_l, hse_rt, hils, hde_r))
// end of [hidexp_assgn_ptr]

(* ****** ****** *)

implement
hidexp_xchng_var
  (loc, hse, d2v_l, hse_rt, hils, hde_r) =
  hidexp_make_node (loc, hse, HDExchng_var (d2v_l, hse_rt, hils, hde_r))
// end of [hidexp_xchng_var]

implement
hidexp_xchng_ptr
  (loc, hse, hde_l, hse_rt, hils, hde_r) =
  hidexp_make_node (loc, hse, HDExchng_ptr (hde_l, hse_rt, hils, hde_r))
// end of [hidexp_xchng_ptr]

(* ****** ****** *)

implement
hidexp_arrpsz
  (loc, hse, hse_elt, hdes, asz) =
  hidexp_make_node (loc, hse, HDEarrpsz (hse_elt, hdes, asz))
// end of [hidexp_arrpsz]

implement
hidexp_arrinit
  (loc, hse, hse_elt, asz, hdes_elt) =
  hidexp_make_node (loc, hse, HDEarrinit (hse_elt, asz, hdes_elt))
// end of [hidexp_arrinit]

(* ****** ****** *)

implement
hidexp_raise
  (loc, hse, hde_exn) =
  hidexp_make_node (loc, hse, HDEraise (hde_exn))
// end of [hidexp_raise]

(* ****** ****** *)

implement
hidexp_lam
  (loc, hse, hips_arg, hde_body) =
  hidexp_make_node (loc, hse, HDElam (hips_arg, hde_body))
// end of [hidexp_lam]

(* ****** ****** *)

implement
hidexp_loop
  (loc, hse, init, test, post, body) =
  hidexp_make_node (loc, hse, HDEloop (init, test, post, body))
// end of [hidexp_loop]

implement
hidexp_loopexn
  (loc, hse, knd) =
  hidexp_make_node (loc, hse, HDEloopexn (knd))
// end of [hidexp_loopexn]

(* ****** ****** *)

implement
hidexp_err (loc, hse) = hidexp_make_node (loc, hse, HDEerr ())

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
hifundec_make
  (loc, d2v, s2vs, def) = '{
  hifundec_loc= loc
, hifundec_var= d2v
, hifundec_imparg= s2vs
, hifundec_def= def
, hifundec_funlab= None ()
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
hiimpdec_make (
  loc, d2c, imparg, tmparg, def
) = '{
  hiimpdec_loc= loc
, hiimpdec_cst= d2c
, hiimpdec_imparg= imparg
, hiimpdec_tmparg= tmparg
, hiimpdec_def= def
, hiimpdec_funlab= None ()
} // end of [hiimpdec_make]

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
hidecl_extcode
  (loc, knd, pos, code) =
  hidecl_make_node (loc, HIDextcode (knd, pos, code))
// end of [hidecl_extcode]

(* ****** ****** *)

implement
hidecl_datdecs
  (loc, knd, s2cs) =
  hidecl_make_node (loc, HIDdatdecs (knd, s2cs))
// end of [hidecl_datdecs]

implement
hidecl_exndecs
  (loc, d2cs) =
  hidecl_make_node (loc, HIDexndecs (d2cs))
// end of [hidecl_exndecs]

(* ****** ****** *)

implement
hidecl_dcstdecs
  (loc, knd, d2cs) =
  hidecl_make_node (loc, HIDdcstdecs (knd, d2cs))
// end of [hidecl_dcstdecs]

(* ****** ****** *)

implement
hidecl_impdec
  (loc, knd, himp) =
  hidecl_make_node (loc, HIDimpdec (knd, himp))
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

local
//
staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"
//
staload TRENV2 = "./pats_trans2_env.sats"
//
in // in of [local]

implement
filenv_get_tmpcstdecmapopt (fenv) = let
  val p = $TRENV2.filenv_getref_tmpcstdecmap (fenv) in $UN.ptrget<tmpcstdecmapopt> (p)
end // end of [filenv_get_tmpcstdecmapopt]

end // end of [local]

(* ****** ****** *)

implement
tmpcstdecmap_find
  (map, d2c) = let
  val opt = d2cstmap_search (map, d2c)
in
//
case+ opt of
| ~Some_vt (impdecs) => impdecs | ~None_vt () => list_nil ()
//
end // end of [tmpcstdecmap_find]

implement
tmpcstdecmap_insert
  (map, d2c, x) = let
  val xs = tmpcstdecmap_find (map, d2c)
  val _(*found*) = d2cstmap_insert (map, d2c, list_cons (x, xs))
in
  // nothing
end // end of [tmpcstdecmap_insert]

(* ****** ****** *)

extern typedef "hipat_t" = hipat
extern typedef "hifundec_t" = hifundec
extern typedef "hiimpdec_t" = hiimpdec

%{$

ats_void_type
patsopt_hipat_set_asvar (
  ats_ptr_type hip, ats_ptr_type opt
) {
  ((hipat_t)hip)->atslab_hipat_asvar = opt ; return ;
} // end of [patsopt_hipat_set_asvar]

ats_ptr_type
patsopt_hifundec_getref_funlabopt
  (ats_ptr_type fundec) {
  return &((hifundec_t)fundec)->atslab_hifundec_funlab ;
} // end of [patsopt_hifundec_getref_funlabopt]

ats_ptr_type
patsopt_hiimpdec_getref_funlabopt
  (ats_ptr_type impdec) {
  return &((hiimpdec_t)impdec)->atslab_hiimpdec_funlab ;
} // end of [patsopt_hiimpdec_getref_funlabopt]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_hidynexp.dats] *)

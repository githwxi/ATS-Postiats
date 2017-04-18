(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: July, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)
//
staload
S2E = "./pats_staexp2.sats"
typedef s2cst = $S2E.s2cst
//
staload
S2C = "./pats_stacst2.sats"
//
staload
D2E = "./pats_dynexp2.sats"
typedef d2cst = $D2E.d2cst
//
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
  case+ hip.hipat_node of HIPany _ => true | _ => false
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
hipat_any (loc, hse, d2v) =
  hipat_make_node (loc, hse, HIPany (d2v))
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
hipat_intrep
  (loc, hse, rep) =
  hipat_make_node (loc, hse, HIPintrep (rep))
// end of [hipat_intrep]

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
hipat_float
  (loc, hse, rep) =
  hipat_make_node (loc, hse, HIPfloat (rep))
// end of [hipat_float]

implement
hipat_string
  (loc, hse, str) =
  hipat_make_node (loc, hse, HIPstring (str))
// end of [hipat_string]

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
hipat_lst
(
  loc
, lin, hse_lst, hse_elt, hips
) = let
//
val s2c =
(
if lin = 0
  then $S2C.s2cstref_get_cst ($S2C.the_list_t0ype_int_type)
  else $S2C.s2cstref_get_cst ($S2C.the_list_vt0ype_int_vtype)
) : s2cst
//
val-Some(xx) =
  $S2E.s2cst_get_islst (s2c)
//
val d2c_nil = xx.0 and d2c_cons = xx.1
//
val pck =
(
  if lin = 0 then $D2E.PCKcon else $D2E.PCKfree
) : $D2E.pckind
//
val l0 = $LAB.label_make_int (0)
val l1 = $LAB.label_make_int (1)
//
val lhse0 = HSLABELED (l0, None, hse_elt)
val lhse1 = HSLABELED (l1, None, hse_lst)
val lhses_arg = list_pair (lhse0, lhse1)
val hse_sum = hisexp_tysum (d2c_cons, lhses_arg)
//
fun auxlst
(
  hips: hipatlst
) :<cloref1> hipat = let
in
//
case+ hips of
//
| list_cons
    (hip0, hips) => let
    val hip1 = auxlst (hips)
    val lhip0 = LABHIPAT (l0, hip0)
    val lhip1 = LABHIPAT (l1, hip1)
    val lhips_arg = list_pair (lhip0, lhip1)
  in
    hipat_con (loc, hse_lst, pck, d2c_cons, hse_sum, lhips_arg)
  end // end of [list_cons]
//
| list_nil () => hipat_con_any (loc, hse_lst, pck, d2c_nil)
//
end // end of [auxlst]
//
in
  auxlst (hips)
end // end of [hipat_lst]

(* ****** ****** *)

implement
hipat_rec (
  loc, hse, knd, pck, lhips, hse_rec
) =
(
hipat_make_node
  (loc, hse, HIPrec(knd, pck, lhips, hse_rec))
) // end of [hipat_rec]

implement
hipat_rec2
(
  loc0, hse0, knd, pck, lhips, hse_rec
) = let
//
val isflt =
  (if knd = 0 then true else false): bool
//
in
//
if
isflt
then (
case lhips of
| list_cons
    (lx, list_nil ()) =>
    let val+LABHIPAT(l, x) = lx in x end
  // end of [list_cons]
| _ (*notsing*) =>
    hipat_rec(loc0, hse0, knd, pck, lhips, hse_rec)
) (* end of [then] *)
else (
  hipat_rec (loc0, hse0, knd, pck, lhips, hse_rec)
) (* end of [else] *)
//
end // end of [hipat_rec2]

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
hidexp_int
  (loc, hse, i) =
  hidexp_make_node (loc, hse, HDEint (i))
// end of [hidexp_int]

implement
hidexp_intrep
  (loc, hse, rep) =
  hidexp_make_node (loc, hse, HDEintrep (rep))
// end of [hidexp_intrep]

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
hidexp_float
  (loc, hse, rep) =
  hidexp_make_node (loc, hse, HDEfloat (rep))
// end of [hidexp_float]

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
  hidexp_make_node (loc, hse, HDEf0loat(tok))
// end of [hidexp_f0loat]

(* ****** ****** *)

implement
hidexp_cstsp
  (loc, hse, x) = 
  hidexp_make_node (loc, hse, HDEcstsp(x))
// end of [hidexp_cstsp]

(* ****** ****** *)

implement
hidexp_tyrep
  (loc, hse, x) = 
  hidexp_make_node (loc, hse, HDEtyrep(x))
// end of [hidexp_cstsp]

(* ****** ****** *)

implement
hidexp_top(loc, hse) = 
  hidexp_make_node (loc, hse, HDEtop())
// end of [hidexp_top]

implement
hidexp_empty(loc, hse) = 
  hidexp_make_node (loc, hse, HDEempty())
// end of [hidexp_empty]

implement
hidexp_ignore
  (loc, hse, hde) = 
  hidexp_make_node (loc, hse, HDEignore(hde))
// end of [hidexp_ignore]

(* ****** ****** *)

implement
hidexp_castfn
  (loc, hse, d2c, arg) =
  hidexp_make_node (loc, hse, HDEcastfn(d2c, arg))
// end of [hidexp_castfn]

(* ****** ****** *)

implement
hidexp_extval
  (loc, hse, name) =
  hidexp_make_node (loc, hse, HDEextval(name))
// end of [hidexp_extval]

implement
hidexp_extfcall
  (loc, hse, _fun, _arg) =
  hidexp_make_node (loc, hse, HDEextfcall(_fun, _arg))
// end of [hidexp_extfcall]

implement
hidexp_extmcall
  (loc, hse, _obj, _mtd, _arg) =
  hidexp_make_node (loc, hse, HDEextmcall(_obj, _mtd, _arg))
// end of [hidexp_extmcall]

(* ****** ****** *)
//
implement
hidexp_con (
  loc, hse, d2c, hse_sum, lhdes
) = hidexp_make_node(loc, hse, HDEcon (d2c, hse_sum, lhdes))
//
(* ****** ****** *)

implement
hidexp_tmpcst
  (loc, hse, d2c, t2mas) =
  hidexp_make_node (loc, hse, HDEtmpcst(d2c, t2mas))
// end of [hidexp_tmpcst]

implement
hidexp_tmpvar
  (loc, hse, d2v, t2mas) =
  hidexp_make_node (loc, hse, HDEtmpvar(d2v, t2mas))
// end of [hidexp_tmpvar]

(* ****** ****** *)

implement
hidexp_foldat (loc, hse) =
  hidexp_make_node (loc, hse, HDEfoldat())

implement
hidexp_freeat (loc, hse, hde) =
  hidexp_make_node (loc, hse, HDEfreeat(hde))
// end of [hidexp_freeat]

(* ****** ****** *)

implement
hidexp_let (loc, hse, hids, hde) =
  hidexp_make_node (loc, hse, HDElet(hids, hde))
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
      if $D2E.d2cst_is_castfn (d2c) then Some_vt (d2c) else None_vt
  | _ (*non-HDEcst*) => None_vt ()
) : Option_vt (d2cst)
//
in
//
case+ opt of
| ~Some_vt (d2c) => let
    val hde = (
      case+ _arg of
      | list_cons
          (hse, _) => hse
        // list_cons
      | list_nil () => let
          val loc = _fun.hidexp_loc
        in
          hidexp_empty (loc, hisexp_void_t0ype())
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

(* ****** ****** *)

implement
hidexp_rec
  (loc, hse, knd, lhdes, hse_rec) =
  hidexp_make_node (loc, hse, HDErec (knd, lhdes, hse_rec))
// end of [hidexp_rec]

implement
hidexp_rec2
(
  loc0, hse0, knd, lhdes, hse_rec
) = let
//
val isflt =
  (if knd = 0 then true else false): bool
//
in
//
if
isflt
then (
case+ lhdes of
| list_cons
  (
    lhde, list_nil()
  ) => let
    val+LABHIDEXP (l, hde) = lhde in hde
  end // end of [list_cons]
| _ (*non-sing*) =>
    hidexp_rec (loc0, hse0, knd, lhdes, hse_rec)
  // end of [non-sing]
) (* end of [then] *)
else hidexp_rec (loc0, hse0, knd, lhdes, hse_rec)
//
end (* end of [hidexp_rec2] *)

(* ****** ****** *)

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
hidexp_selvar
  (loc, hse, d2v, hse_rt, hils) =
  hidexp_make_node (loc, hse, HDEselvar (d2v, hse_rt, hils))
// end of [hidexp_selvar]

implement
hidexp_selptr
  (loc, hse, hde, hse_rt, hils) =
  hidexp_make_node (loc, hse, HDEselptr (hde, hse_rt, hils))
// end of [hidexp_selptr]

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
(
  loc, hse, hse_elt, hdes_elt, asz
) = hidexp_make_node
  (loc, hse, HDEarrpsz (hse_elt, hdes_elt, asz))
// end of [hidexp_arrpsz]

implement
hidexp_arrinit
(
  loc, hse, hse_elt, hde_asz, hdes_elt, asz
) = hidexp_make_node
  (loc, hse, HDEarrinit (hse_elt, hde_asz, hdes_elt, asz))
// end of [hidexp_arrinit]

(* ****** ****** *)

implement
hidexp_raise
  (loc, hse, hde_exn) =
  hidexp_make_node (loc, hse, HDEraise (hde_exn))
// end of [hidexp_raise]

(* ****** ****** *)
//
implement
hidexp_vcopyenv
  (loc, hse, d2v) =
  hidexp_make_node (loc, hse, HDEvar (d2v))
//
(* ****** ****** *)
//
implement
hidexp_tempenver
  (loc, hse, d2vs) =
  hidexp_make_node (loc, hse, HDEtempenver (d2vs))
//
(* ****** ****** *)

implement
hidexp_lam
(
  loc, hse, knd
, hips_arg, hde_body
) = hidexp_make_node
  (loc, hse, HDElam (knd, hips_arg, hde_body))
// end of [hidexp_lam]

(* ****** ****** *)

implement
hidexp_fix
  (loc, hse, knd, f_d2v, hde_def) =
  hidexp_make_node (loc, hse, HDEfix (knd, f_d2v, hde_def))
// end of [hidexp_fix]

(* ****** ****** *)
//
implement
hidexp_delay
  (loc, hse, hde) =
  hidexp_make_node (loc, hse, HDEdelay (hde))
// end of [hidexp_delay]
implement
hidexp_ldelay
  (loc, hse, _eval, _free) =
  hidexp_make_node (loc, hse, HDEldelay (_eval, _free))
// end of [hidexp_ldelay]
//
implement
hidexp_lazyeval
  (loc, hse, lin, hde) =
  hidexp_make_node (loc, hse, HDElazyeval (lin, hde))
// end of [hidexp_lazyeval]
//
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
hidexp_trywith
  (loc, hse, hde, hicls) =
  hidexp_make_node (loc, hse, HDEtrywith (hde, hicls))
// end of [hidexp_trywith]

(* ****** ****** *)

implement
hidexp_errexp
  (loc, hse) = hidexp_make_node (loc, hse, HDEerrexp ())
// end of [hidexp_errexp]

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
(
  loc, d2v, s2vs, def
) = '{
  hifundec_loc= loc
, hifundec_var= d2v
, hifundec_imparg= s2vs
, hifundec_def= def
, hifundec_hidecl= None ()
, hifundec_funlab= None ()
} // end of [hifundec_make]

(* ****** ****** *)

local

staload UN = "prelude/SATS/unsafe.sats"

in (* in of [local] *)

implement
hifundec_get_hideclopt
  (hfd) = $UN.cast{hideclopt}(hfd.hifundec_hidecl)
// end of [hifundec_get_hideclopt]

implement
hifundeclst_set_hideclopt
  (hfds, opt) = let
//
fun set
(
  hfd: hifundec, opt: hideclopt
) : void =
  $UN.ptrset<hideclopt> (hifundec_getref_hideclopt (hfd), opt)
//
fun auxlst
(
  hfds: hifundeclst, opt: hideclopt
) : void = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val () = set (hfd, opt) in auxlst (hfds, opt)
  end // end of [auxlst]
| list_nil () => ()
//
end // end of [auxlst]
//
in
  auxlst (hfds, opt)
end // end of [hifundeclst_set_hideclopt]

end // end of [local]

(* ****** ****** *)

implement
hivaldec_make
  (loc, pat, def) = '{
  hivaldec_loc= loc
, hivaldec_pat= pat
, hivaldec_def= def
} // end of [hivaldec_make]

implement
hivardec_make
(
  loc, knd
, d2v, d2vw, type, init
) = '{
  hivardec_loc= loc
, hivardec_knd= knd
, hivardec_dvar_ptr= d2v
, hivardec_dvar_view= d2vw
, hivardec_type= type
, hivardec_init= init
} // end of [hivardec_make]

(* ****** ****** *)

implement
hiimpdec_make
(
  loc, knd, d2c, imparg, tmparg, def
) = '{
  hiimpdec_loc= loc
, hiimpdec_knd= knd
, hiimpdec_cst= d2c
, hiimpdec_imparg= imparg
, hiimpdec_tmparg= tmparg
, hiimpdec_def= def
, hiimpdec_funlab= None ()
, hiimpdec_instrlst= None ()
} // end of [hiimpdec_make]

(* ****** ****** *)

implement
hidecl_make_node
  (loc, node) = '{
  hidecl_loc= loc, hidecl_node= node
} // end of [hidecl_make_node]

implement
hidecl_none (loc) =
  hidecl_make_node (loc, HIDnone())
// end of [hidecl_none]

implement
hidecl_list (loc, hids) =
  hidecl_make_node (loc, HIDlist(hids))
// end of [hidecl_list]

(* ****** ****** *)
//
implement
hidecl_saspdec (loc, d2c) =
  hidecl_make_node (loc, HIDsaspdec(d2c))
// end of [hidecl_saspdec]
implement
hidecl_reassume (loc, s2c) =
  hidecl_make_node (loc, HIDreassume(s2c))
// end of [hidecl_reassume]
//
(* ****** ****** *)

implement
hidecl_extype
  (loc, name, hse_def) =
  hidecl_make_node (loc, HIDextype(name, hse_def))
// end of [hidecl_extype]

implement
hidecl_extvar
  (loc, name, hde_def) =
  hidecl_make_node (loc, HIDextvar(name, hde_def))
// end of [hidecl_extvar]

implement
hidecl_extcode
  (loc, knd, pos, code) =
  hidecl_make_node (loc, HIDextcode(knd, pos, code))
// end of [hidecl_extcode]

(* ****** ****** *)

implement
hidecl_exndecs
  (loc, d2cs) =
  hidecl_make_node(loc, HIDexndecs(d2cs))
// end of [hidecl_exndecs]

implement
hidecl_datdecs
  (loc, knd, s2cs) =
  hidecl_make_node(loc, HIDdatdecs(knd, s2cs))
// end of [hidecl_datdecs]

(* ****** ****** *)

implement
hidecl_dcstdecs
  (loc, dck, d2cs) =
  hidecl_make_node (loc, HIDdcstdecs (dck, d2cs))
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
hidecl_include
  (loc, knd, hids) =
  hidecl_make_node (loc, HIDinclude (knd, hids))
// end of [hidecl_include]

(* ****** ****** *)

implement
hidecl_staload (
  loc, idopt, fname, flag, loaded, fenv
) = hidecl_make_node
  (loc, HIDstaload (idopt, fname, flag, loaded, fenv))
// end of [hidecl_staload]

implement
hidecl_staloadloc
  (loc, pfil, nspace, hids) =
  hidecl_make_node (loc, HIDstaloadloc (pfil, nspace, hids))
// end of [hidecl_staloadloc]

(* ****** ****** *)

implement
hidecl_dynload (loc, fil) =
  hidecl_make_node (loc, HIDdynload (fil))
// end of [hidecl_dynload]

(* ****** ****** *)

implement
hidecl_local (loc, head, body) =
  hidecl_make_node (loc, HIDlocal (head, body))
// end of [hidecl_local]

(* ****** ****** *)

local

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"
//
staload TRENV2 = "./pats_trans2_env.sats"

in (* in of [local] *)

implement
filenv_get_tmpcstimpmapopt (fenv) = let
  val p = $TRENV2.filenv_getref_tmpcstimpmap (fenv) in $UN.ptrget<tmpcstimpmapopt> (p)
end // end of [filenv_get_tmpcstimpmapopt]

implement
filenv_get_tmpvardecmapopt (fenv) = let
  val p = $TRENV2.filenv_getref_tmpvardecmap (fenv) in $UN.ptrget<tmpvardecmapopt> (p)
end // end of [filenv_get_tmpvardecmapopt]

end // end of [local]

(* ****** ****** *)

implement
tmpcstimpmap_find
  (map, d2c) = let
  val opt = $D2E.d2cstmap_search (map, d2c)
in
//
case+ opt of
| ~Some_vt (imps) => imps | ~None_vt () => list_nil ()
//
end // end of [tmpcstimpmap_find]

implement
tmpcstimpmap_insert
  (map, imp) = let
  val d2c = imp.hiimpdec_cst
  val imps = tmpcstimpmap_find (map, d2c)
  val _(*found*) =
    $D2E.d2cstmap_insert (map, d2c, list_cons (imp, imps))
in
  // nothing
end // end of [tmpcstimpmap_insert]

(* ****** ****** *)

implement
tmpvardecmap_find
  (map, d2v) = $D2E.d2varmap_search (map, d2v)
// end of [tmpvardecmap_find]

implement
tmpvardecmap_insert
  (map, hfd) = let
  val d2v = hfd.hifundec_var
  val _(*found*) = $D2E.d2varmap_insert (map, d2v, hfd)
in
  // nothing
end // end of [tmpvardecmap_insert]

implement
tmpvardecmap_inserts
  (map, hfds) = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val () =
    tmpvardecmap_insert (map, hfd)
  in
    tmpvardecmap_inserts (map, hfds)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [tmpvardecmap_inserts]

(* ****** ****** *)

extern typedef "hipat_t" = hipat
extern typedef "hifundec_t" = hifundec
extern typedef "hiimpdec_t" = hiimpdec

%{$

ats_void_type
patsopt_hipat_set_asvar
(
  ats_ptr_type hip, ats_ptr_type opt
) {
  ((hipat_t)hip)->atslab_hipat_asvar = opt ; return ;
} // end of [patsopt_hipat_set_asvar]

ats_ptr_type
patsopt_hifundec_getref_hideclopt
  (ats_ptr_type fundec)
{
  return &((hifundec_t)fundec)->atslab_hifundec_hidecl ;
} // end of [patsopt_hifundec_getref_hideclopt]

ats_ptr_type
patsopt_hifundec_getref_funlabopt
  (ats_ptr_type fundec)
{
  return &((hifundec_t)fundec)->atslab_hifundec_funlab ;
} // end of [patsopt_hifundec_getref_funlabopt]

ats_ptr_type
patsopt_hiimpdec_getref_funlabopt
  (ats_ptr_type impdec)
{
  return &((hiimpdec_t)impdec)->atslab_hiimpdec_funlab ;
} // end of [patsopt_hiimpdec_getref_funlabopt]

ats_ptr_type
patsopt_hiimpdec_getref_instrlstopt
  (ats_ptr_type impdec)
{
  return &((hiimpdec_t)impdec)->atslab_hiimpdec_instrlst ;
} // end of [patsopt_hiimpdec_getref_instrlstopt]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_hidynexp.dats] *)

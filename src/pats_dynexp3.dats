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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2011
//
(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

implement
p3at_any
  (loc, s2f, d2v) = '{
  p3at_loc= loc
, p3at_node= P3Tany (d2v)
, p3at_type= s2f
} // end of [p3at_any]

implement
p3at_var (
  loc, s2f, knd, d2v
) = '{
  p3at_loc= loc
, p3at_node= P3Tvar (knd, d2v)
, p3at_type= s2f
} // end of [p3at_var]

implement
p3at_con (
  loc, s2f, freeknd, d2c, npf, p3ts
) = '{
  p3at_loc= loc
, p3at_node= P3Tcon (freeknd, d2c, npf, p3ts)
, p3at_type= s2f
} // end of [p3at_con]

implement
p3at_int
  (loc, s2f, i) = '{
  p3at_loc= loc
, p3at_node= P3Tint (i)
, p3at_type= s2f
} // end of [p3at_int]
implement
p3at_intrep
  (loc, s2f, rep) = '{
  p3at_loc= loc
, p3at_node= P3Tintrep (rep)
, p3at_type= s2f
} // end of [p3at_intrep]

implement
p3at_bool
  (loc, s2f, b) = '{
  p3at_loc= loc
, p3at_node= P3Tbool (b)
, p3at_type= s2f
} // end of [p3at_bool]

implement
p3at_char
  (loc, s2f, c) = '{
  p3at_loc= loc
, p3at_node= P3Tchar (c)
, p3at_type= s2f
} // end of [p3at_char]

implement
p3at_string
  (loc, s2f, str) = '{
  p3at_loc= loc
, p3at_node= P3Tstring (str)
, p3at_type= s2f
} // end of [p3at_string]

//

implement
p3at_i0nt
  (loc, s2f, x) = '{
  p3at_loc= loc
, p3at_node= P3Ti0nt (x)
, p3at_type= s2f
} // end of [p3at_i0nt]

implement
p3at_f0loat
  (loc, s2f, x) = '{
  p3at_loc= loc
, p3at_node= P3Tf0loat (x)
, p3at_type= s2f
} // end of [p3at_f0loat]

//

implement
p3at_empty
  (loc, s2f) = '{
  p3at_loc= loc
, p3at_node= P3Tempty ()
, p3at_type= s2f
} // end of [p3at_empty]

implement
p3at_rec (
  loc, s2f, knd, npf, lp3ts
) = '{
  p3at_loc= loc
, p3at_node= P3Trec (knd, npf, lp3ts)
, p3at_type= s2f  
} // end of [p3at_rec]

implement
p3at_lst (
  loc, s2f, lin, p3ts
) = '{
  p3at_loc= loc
, p3at_node= P3Tlst (lin, p3ts)
, p3at_type= s2f
} // end of [p3at_lst]

implement
p3at_as (
  loc, s2f, refknd, d2v, p3t
) = '{
  p3at_loc= loc
, p3at_node= P3Tas (refknd, d2v, p3t)
, p3at_type= s2f
} // end of [p3at_as]

implement
p3at_exist (
  loc, s2f, s2vs, p3t
) = '{
  p3at_loc= loc
, p3at_node= P3Texist (s2vs, p3t)
, p3at_type= s2f
} // end of [p3at_exist]

implement
p3at_ann (
  loc, s2f, p3t, ann
) = '{
  p3at_loc= loc
, p3at_node= P3Tann (p3t, ann)
, p3at_type= s2f
} // end of [p3at_ann]

implement
p3at_err
  (loc, s2f) = '{
  p3at_loc= loc
, p3at_node= P3Terr ()
, p3at_type= s2f
} // end of [p3at_err]

(* ****** ****** *)

implement
d3exp_get_type (d3e) = d3e.d3exp_type
// end of [implement]

(* ****** ****** *)

implement
d3exp_var (
  loc, s2f, d2v
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Evar (d2v)
} // end of [d3exp_var]

(* ****** ****** *)

implement
d3exp_int
  (loc, s2f, i) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eint (i)
} // end of [d3exp_int]
implement
d3exp_intrep
  (loc, s2f, rep) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eintrep (rep)
} // end of [d3exp_intrep]

implement
d3exp_bool
  (loc, s2f, b) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ebool (b)
} // end of [d3exp_bool]

implement
d3exp_char
  (loc, s2f, c) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Echar (c)
} // end of [d3exp_char]

implement
d3exp_string
  (loc, s2f, str) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Estring (str)
} // end of [d3exp_string]

(* ****** ****** *)

implement
d3exp_i0nt
  (loc, s2f, x) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ei0nt (x)
} // end of [d3exp_i0nt]

implement
d3exp_f0loat
  (loc, s2f, x) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ef0loat (x)
} // end of [d3exp_f0loat]

(* ****** ****** *)

implement
d3exp_cstsp
  (loc, s2f, csp) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ecstsp (csp)
} // end of [d3exp_cstsp]

(* ****** ****** *)

implement
d3exp_empty
  (loc, s2f) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eempty ()
} // end of [d3exp_empty]

(* ****** ****** *)

implement
d3exp_extval
  (loc, s2f, rep) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eextval (rep)
} // end of [d3exp_extval]

(* ****** ****** *)

implement
d3exp_cst (
  loc, s2f, d2c
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ecst (d2c)
} // end of [d3exp_cst]

implement
d3exp_con (
  loc, s2f_res, d2c, npf, d3es_arg
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_res
, d3exp_node= D3Econ (d2c, npf, d3es_arg)
} // end of [d3exp_con]

(* ****** ****** *)

implement
d3exp_tmpcst (
  loc, s2f_res, d2c, t2mas
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_res
, d3exp_node= D3Etmpcst (d2c, t2mas)
} // end of [d3exp_tmpcst]

implement
d3exp_tmpvar (
  loc, s2f_res, d2v, t2mas
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_res
, d3exp_node= D3Etmpvar (d2v, t2mas)
} // end of [d3exp_tmpvar]

(* ****** ****** *)

implement
d3exp_item
  (loc, s2f, d2i) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eitem (d2i) // d2i: d2itm
} // end of [d3exp_item]

(* ****** ****** *)

implement
d3exp_let (
  loc, d3cs, d3e
) = let
  val s2f = d3exp_get_type (d3e)
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Elet (d3cs, d3e)
} end // end of [d3exp_let]

(* ****** ****** *)

implement
d3exp_app_sta
  (loc, s2f, d3e) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eapp_sta (d3e)
} // end of [d3exp_app_sta]

implement
d3exp_app_dyn (
  loc, s2f, s2fe, _fun, npf, _arg
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eapp_dyn (_fun, npf, _arg)
} // end of [d3exp_app_dyn]

(* ****** ****** *)

implement
d3exp_lst (
  loc, s2f_lst, lin, s2f_elt, d3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_lst
, d3exp_node= D3Elst (lin, s2f_elt, d3es)
} // end of [d3exp_lst]

implement
d3exp_tup (
  loc, s2f_tup, knd, npf, d3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_tup
, d3exp_node= D3Etup (knd, npf, d3es)
} // end of [d3exp_tup]

implement
d3exp_rec (
  loc, s2f_rec, knd, npf, ld3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_rec
, d3exp_node= D3Erec (knd, npf, ld3es)
} // end of [d3exp_rec]

implement
d3exp_seq (
  loc, s2f, d3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eseq (d3es)
} // end of [d3exp_seq]

(* ****** ****** *)

implement
d3exp_if (
  loc, s2e_if, _cond, _then, _else
) = '{
  d3exp_loc= loc
, d3exp_type= s2e_if
, d3exp_node= D3Eif (_cond, _then, _else)
} // end of [d3exp_if]

implement
d3exp_sif (
  loc, s2e_sif, _cond, _then, _else
) = '{
  d3exp_loc= loc
, d3exp_type= s2e_sif
, d3exp_node= D3Esif (_cond, _then, _else)
} // end of [d3exp_sif]

(* ****** ****** *)

implement
d3exp_case (
  loc, s2e_case, casknd, d3es, c3ls
) = let
in '{
  d3exp_loc= loc
, d3exp_type= s2e_case
, d3exp_node= D3Ecase (casknd, d3es, c3ls)
} end // end of [d3exp_case]

(* ****** ****** *)

implement
d3exp_selab (
  loc, s2f, d3e, d3ls
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eselab (d3e, d3ls)
} // end of [d3exp_selab]

(* ****** ****** *)

implement
d3exp_ptrof_var
  (loc, s2f, d2v) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eptrof_var (d2v)
} // end of [d3exp_ptrof_var]

implement
d3exp_viewat
  (loc, s2at, d3e, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2at
, d3exp_node= D3Eviewat (d3e, d3ls)
} // end of [d3exp_viewat]

(* ****** ****** *)

implement
d3exp_sel_var (
  loc, s2f, d2v, d3ls
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_var (d2v, d3ls)
} // end of [d3exp_sel_var]

implement
d3exp_sel_ptr
  (loc, s2f, d3e, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_ptr (d3e, d3ls)
} // end of [d3exp_sel_ptr]

implement
d3exp_sel_ref
  (loc, s2f, d3e, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_ref (d3e, d3ls)
} // end of [d3exp_sel_ref]

(* ****** ****** *)

implement
d3exp_assgn_var (
  loc, d2v_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_var (d2v_l, d3ls, d3e_r)
} end // end of [d3exp_assgn_var]

implement
d3exp_assgn_ptr (
  loc, d3e_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_ptr (d3e_l, d3ls, d3e_r)
} end // end of [d3exp_assgn_ptr]

implement
d3exp_assgn_ref (
  loc, d3e_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_ref (d3e_l, d3ls, d3e_r)
} end // end of [d3exp_assgn_ref]

(* ****** ****** *)

implement
d3exp_xchng_var (
  loc, d2v_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_var (d2v_l, d3ls, d3e_r)
} end // end of [d3exp_xchng_var]

implement
d3exp_xchng_ptr (
  loc, d3e_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_ptr (d3e_l, d3ls, d3e_r)
} end // end of [d3exp_xchng_ptr]

implement
d3exp_xchng_ref (
  loc, d3e_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_ref (d3e_l, d3ls, d3e_r)
} end // end of [d3exp_xchng_ref]

(* ****** ****** *)

implement
d3exp_refarg (
  loc, s2e, refval, freeknd, d3e
) = '{
  d3exp_loc= loc
, d3exp_type= s2e
, d3exp_node= D3Erefarg (refval, freeknd, d3e)
} // end of [d3exp_refarg]

(* ****** ****** *)

implement
d3exp_arrinit (
  loc, s2e_arr, elt, asz, d3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2e_arr
, d3exp_node= D3Earrinit (elt, asz, d3es)
} // end of [d3exp_arrinit]

implement
d3exp_arrsize (
  loc, s2f_arrsz, d3es, asz
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_arrsz
, d3exp_node= D3Earrsize (d3es, asz)
} // end of [d3exp_arrsize]

(* ****** ****** *)

implement
d3exp_effmask (
  loc, s2fe, d3e
) = let
  val s2f = d3exp_get_type (d3e)
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eeffmask (s2fe, d3e)
} end // end of [d3exp_effmask]

(* ****** ****** *)

implement
d3exp_lam_dyn (
  loc, s2f_fun, lin, npf, arg, body
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_fun
, d3exp_node= D3Elam_dyn (lin, npf, arg, body)
} // end of [d3exp_lam_dyn]

implement
d3exp_laminit_dyn (
  loc, s2f_fun, lin, npf, arg, body
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_fun
, d3exp_node= D3Elaminit_dyn (lin, npf, arg, body)
} // end of [d3exp_laminit_dyn]

implement
d3exp_lam_sta (
  loc, s2f_uni, s2vs, s2ps, body
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_uni
, d3exp_node= D3Elam_sta (s2vs, s2ps, body)
} // end of [d3exp_lam_sta]

implement
d3exp_lam_met (
  loc, s2es_met, d3e_body
) = '{
  d3exp_loc= loc
, d3exp_type= d3e_body.d3exp_type
, d3exp_node= D3Elam_met (s2es_met, d3e_body)
} // end of [d3exp_lam_met]

(* ****** ****** *)

implement
d3exp_loopexn
  (loc, s2f, knd) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eloopexn (knd)
} // end of [d3exp_loopexn]

(* ****** ****** *)

implement
d3exp_ann_type
  (loc, d3e, s2f) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eann_type (d3e, s2f)
} // end of [d3exp_ann_type]

(* ****** ****** *)

implement
d3exp_err (loc) = let
  val s2f = s2exp_t0ype_err ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eerr ()
} end // end of [d3exp_err]

(* ****** ****** *)

implement
d3lab_lab
  (loc, lab) = '{
  d3lab_loc= loc, d3lab_node= D3LABlab (lab)
} // end of [d3lab_lab]

implement
d3lab_ind
  (loc, ind) = '{
  d3lab_loc= loc, d3lab_node= D3LABind (ind)
} // end of [d3lab_ind]

(* ****** ****** *)

implement
m3atch_make
  (loc, d3e, op3t) = '{
  m3atch_loc= loc, m3atch_exp= d3e, m3atch_pat= op3t
} // end of [m3atch_make]

implement
c3lau_make (
  loc, p3ts, gua, seq, neg, d3e
) = '{
  c3lau_loc= loc
, c3lau_pat= p3ts
, c3lau_gua= gua
, c3lau_seq= seq, c3lau_neg= neg
, c3lau_body= d3e
} // end of [c3lau_make]

(* ****** ****** *)

implement
i3mpdec_make (
  loc, d2c, imparg, tmparg, d3e
) = '{
  i3mpdec_loc= loc
, i3mpdec_cst= d2c
, i3mpdec_imparg= imparg
, i3mpdec_tmparg= tmparg
, i3mpdec_def= d3e
} // end of [i3mpdec_make]

(* ****** ****** *)

implement
f3undec_make
  (loc, d2v, d3e) = '{
  f3undec_loc= loc
, f3undec_var= d2v
, f3undec_def= d3e
} // end of [f3undec_make]

(* ****** ****** *)

implement
v3aldec_make
  (loc, p3t, def) = '{
  v3aldec_loc= loc
, v3aldec_pat= p3t
, v3aldec_def= def
} // end of [v3aldec_make]

(* ****** ****** *)

fun d3ecl_make (
  loc: location, node: d3ecl_node
) : d3ecl = '{
  d3ecl_loc= loc, d3ecl_node= node
} // end of [d3ecl_make]

(* ****** ****** *)

implement
d3ecl_none
  (loc) = d3ecl_make (loc, D3Cnone ())
// end of [d3ecl_none]
implement
d3ecl_list
  (loc, xs) = d3ecl_make (loc, D3Clist (xs))
// end of [d3ecl_list]

(* ****** ****** *)

implement
d3ecl_datdec
  (loc, knd, s2cs) =
  d3ecl_make (loc, D3Cdatdec (knd, s2cs))
// end of [d3ecl_datdet]

(* ****** ****** *)

implement
d3ecl_dcstdec
  (loc, knd, d2cs) =
  d3ecl_make (loc, D3Cdcstdec (knd, d2cs))
// end of [d3ecl_dcstdec]

(* ****** ****** *)

implement
d3ecl_impdec
  (loc, d3c) =
  d3ecl_make (loc, D3Cimpdec (d3c))
// end of [d3ecl_impdec]

(* ****** ****** *)

implement
d3ecl_fundecs (
  loc, funknd, decarg, d3cs
) =
  d3ecl_make (loc, D3Cfundecs (funknd, decarg, d3cs))
// end of [d3ecl_fundecs]

(* ****** ****** *)

implement
d3ecl_valdecs
  (loc, knd, d3cs) =
  d3ecl_make (loc, D3Cvaldecs (knd, d3cs))
// end of [d3ecl_valdecs]

implement
d3ecl_valdecs_rec
  (loc, knd, d3cs) =
  d3ecl_make (loc, D3Cvaldecs_rec (knd, d3cs))
// end of [d3ecl_valdecs_rec]

(* ****** ****** *)

implement
d3ecl_staload (
  loc, fil, flag, loaded, fenv
) =
  d3ecl_make (loc, D3Cstaload (fil, flag, loaded, fenv))
// endof [d3ecl_staload]

(* ****** ****** *)

extern typedef "p3at_t" = p3at
extern typedef "d3exp_t" = d3exp

%{$

ats_void_type
patsopt_p3at_set_type (
  ats_ptr_type p3t, ats_ptr_type s2f
) {
  ((p3at_t)p3t)->atslab_p3at_type = s2f ; return ;
} // end of [patsopt_p3at_set_type]

ats_void_type
patsopt_d3exp_set_type (
  ats_ptr_type d3e, ats_ptr_type s2f
) {
  ((d3exp_t)d3e)->atslab_d3exp_type = s2f ; return ;
} // end of [patsopt_d3exp_set_type]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_dynexp3.dats] *)

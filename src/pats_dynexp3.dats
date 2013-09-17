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
// Start Time: October, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
//
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"
//
(* ****** ****** *)

implement
p3at_make_node
  (loc, s2f, node) = '{
  p3at_loc= loc
, p3at_node= node
, p3at_type= s2f
, p3at_dvaropt= None ()
, p3at_type_left= None ()
} // end of [p3at_make_node]

implement
p3at_any
  (loc, s2f, d2v) =
  p3at_make_node (loc, s2f, P3Tany (d2v))
// end of [p3at_any]

implement
p3at_var
  (loc, s2f, d2v) =
  p3at_make_node (loc, s2f, P3Tvar (d2v))
// end of [p3at_var]

implement
p3at_con
  (loc, s2f, pck, d2c, npf, p3ts) =
  p3at_make_node (loc, s2f, P3Tcon (pck, d2c, npf, p3ts))
// end of [p3at_con]

implement
p3at_int
  (loc, s2f, i) = p3at_make_node (loc, s2f, P3Tint (i))
// end of [p3at_int]
implement
p3at_intrep
  (loc, s2f, rep) = p3at_make_node (loc, s2f, P3Tintrep (rep))
// end of [p3at_intrep]

implement
p3at_bool
  (loc, s2f, b) = p3at_make_node (loc, s2f, P3Tbool (b))
// end of [p3at_bool]

implement
p3at_char
  (loc, s2f, c) = p3at_make_node (loc, s2f, P3Tchar (c))
// end of [p3at_char]

implement
p3at_float
  (loc, s2f, rep) = p3at_make_node (loc, s2f, P3Tfloat (rep))
// end of [p3at_float]

implement
p3at_string
  (loc, s2f, str) = p3at_make_node (loc, s2f, P3Tstring (str))
// end of [p3at_string]

implement
p3at_i0nt
  (loc, s2f, x) = p3at_make_node (loc, s2f, P3Ti0nt (x))
// end of [p3at_i0nt]

implement
p3at_f0loat
  (loc, s2f, x) = p3at_make_node (loc, s2f, P3Tf0loat (x))
// end of [p3at_f0loat]

implement
p3at_empty
  (loc, s2f) = p3at_make_node (loc, s2f, P3Tempty ())
// end of [p3at_empty]

implement
p3at_rec (
  loc, s2f, knd, npf, lp3ts
) = p3at_make_node (loc, s2f, P3Trec (knd, npf, lp3ts))

implement
p3at_lst (
  loc, s2f, lin, s2e_elt, p3ts
) = p3at_make_node (loc, s2f, P3Tlst (lin, s2e_elt, p3ts))

implement
p3at_refas (
  loc, s2f, d2v, p3t
) = p3at_make_node (loc, s2f, P3Trefas (d2v, p3t))

implement
p3at_exist (
  loc, s2f, s2vs, p3t
) = p3at_make_node (loc, s2f, P3Texist (s2vs, p3t))

implement
p3at_vbox (
  loc, s2f, d2v
) = p3at_make_node (loc, s2f, P3Tvbox (d2v))

implement
p3at_ann (
  loc, s2f, p3t, ann
) = p3at_make_node (loc, s2f, P3Tann (p3t, ann))

implement
p3at_err
  (loc, s2f) = p3at_make_node (loc, s2f, P3Terr ())
// end of [p3at_err]

(* ****** ****** *)

implement
p3at_get_type (p3t) = p3t.p3at_type
implement
p3at_get_dvaropt (p3t) = p3t.p3at_dvaropt
implement
p3at_get_type_left (p3t) = p3t.p3at_type_left

(* ****** ****** *)

implement
p3at_is_prf (p3t) = let
  val s2e = p3at_get_type (p3t) in s2exp_is_prf (s2e)
end // end of [p3at_is_prf]

(* ****** ****** *)

implement
p3at_is_lincon (p3t) =
  case+ p3t.p3at_node of
  | P3Tcon (pck, _, _, _) => pck = PCKlincon
  | _ => false
// end of [p3at_is_lincon]

implement
p3at_is_unfold (p3t) =
  case+ p3t.p3at_node of
  | P3Tcon (pck, _, _, _) => pck = PCKunfold
  | _ => false
// end of [p3at_is_unfold]

(* ****** ****** *)

implement
d3exp_get_type (d3e) = d3e.d3exp_type
// end of [implement]

implement
d3explst_get_type (d3es) = let
  val s2es = list_map_fun (d3es, d3exp_get_type)
in
  list_of_list_vt (s2es)
end // end of [d3explst_get_type]

(* ****** ****** *)

implement
d3exp_is_prf (d3e) = let
  val s2e = d3exp_get_type (d3e) in s2exp_is_prf (s2e)
end // end of [d3exp_is_prf]

(* ****** ****** *)

implement
d3exp_cst (
  loc, s2f, d2c
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Ecst (d2c)
} // end of [d3exp_cst]

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

(* ****** ****** *)

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
d3exp_float
  (loc, s2f, rep) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Efloat (rep)
} // end of [d3exp_float]

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
d3exp_top
  (loc, s2f) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Etop ()
} // end of [d3exp_top]

implement
d3exp_empty
  (loc, s2f) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eempty ()
} // end of [d3exp_empty]

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
d3exp_extval
  (loc, s2f, name) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eextval (name)
} // end of [d3exp_extval]

implement
d3exp_extfcall
  (loc, s2f, _fun, _arg) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eextfcall (_fun, _arg)
} // end of [d3exp_extfcall]

(* ****** ****** *)

(*
implement
d3exp_con
(
  loc, s2f_res, d2c, npf, d3es_arg
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_res
, d3exp_node= D3Econ (d2c, npf, d3es_arg)
} // end of [d3exp_con]
*)

local

fun aux1 (
  d3es: d3explst
) : bool = let
  fn f (d3e: d3exp): bool =
  case+ d3e.d3exp_node of
  | D3Etop _ => true | _ => false
in
  list_exists_fun<d3exp> (d3es, f)
end // end of [aux1]

fun aux2 (
  d3es: d3explst
) : s2explst = (
  case+ d3es of
  | list_cons
      (d3e, d3es) => let
      val s2e = d3exp_get_type (d3e)
      val s2e = (
        case+ d3e.d3exp_node of
        | D3Etop () => s2exp_topize_0 (s2e) | _ => s2e
      ) : s2exp // end of [val]
      val s2es = aux2 (d3es)
    in
      list_cons (s2e, s2es)
    end // end of [list_cons]
  | list_nil () => list_nil ()
) // end of [aux2]

in // in of [local]

implement
d3exp_con (
  loc, s2e, d2c, npf, d3es_arg
) = let
  var s2e: s2exp = s2e
  val istop = aux1 (d3es_arg)
  val () =
    if istop then let
      val s2es_arg = aux2 (d3es_arg)
    in
      s2e := s2exp_datcontyp (d2c, s2es_arg)
    end // end of [if]
in '{
  d3exp_loc= loc
, d3exp_type= s2e
, d3exp_node= D3Econ (d2c, npf, d3es_arg)
} end // end of [d3exp_con]

end // end of [local]

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
d3exp_foldat
  (loc, d3e) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Efoldat (d3e)
} end // end of [d3exp_foldat]

implement
d3exp_freeat
  (loc, d3e) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Efreeat (d3e)
} end // end of [d3exp_freeat]

(* ****** ****** *)

implement
d3exp_item (
  loc, s2f, d2i, t2mas
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eitem (d2i, t2mas) // d2i: d2itm
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

(* ****** ****** *)

implement
d3exp_app_unista
  (loc, s2f, d3e) = let
  val s2f0 = d3exp_get_type (d3e)
in
//
case+ s2f0.s2exp_node of
| S2Euni _ => d3exp_app_sta (loc, s2f, d3e)
| S2Emetfun _ => d3exp_app_sta (loc, s2f, d3e)
| _ => d3e
//
end // end of [d3exp_app_unista]

(* ****** ****** *)

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

implement
d3exp_scase (
  loc, s2e_scase, s2e_val, sc3ls
) = let
in '{
  d3exp_loc= loc
, d3exp_type= s2e_scase
, d3exp_node= D3Escase (s2e_val, sc3ls)
} end // end of [d3exp_scase]

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
d3exp_ptrofvar
  (loc, s2f, d2v) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eptrofvar (d2v)
} // end of [d3exp_ptrofvar]

implement
d3exp_ptrofsel (
  loc, s2f, d3e, s2rt, d3ls
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eptrofsel (d3e, s2rt, d3ls)
} // end of [d3exp_ptrofsel]

(* ****** ****** *)

implement
d3exp_viewat
  (loc, s2at, d3e, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2at
, d3exp_node= D3Eviewat (d3e, d3ls)
} // end of [d3exp_viewat]

implement
d3exp_viewat_assgn (
  loc, d3e_l, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eviewat_assgn (d3e_l, d3ls, d3e_r)
} end // end of [d3exp_viewat_assgn]

(* ****** ****** *)

implement
d3exp_sel_var (
  loc, s2f, d2v, s2rt, d3ls
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_var (d2v, s2rt, d3ls)
} // end of [d3exp_sel_var]

implement
d3exp_sel_ptr
  (loc, s2f, d3e, s2rt, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_ptr (d3e, s2rt, d3ls)
} // end of [d3exp_sel_ptr]

implement
d3exp_sel_ref
  (loc, s2f, d3e, s2rt, d3ls) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Esel_ref (d3e, s2rt, d3ls)
} // end of [d3exp_sel_ref]

(* ****** ****** *)

implement
d3exp_assgn_var (
  loc, d2v_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_var (d2v_l, s2rt, d3ls, d3e_r)
} end // end of [d3exp_assgn_var]

implement
d3exp_assgn_ptr (
  loc, d3e_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_ptr (d3e_l, s2rt, d3ls, d3e_r)
} end // end of [d3exp_assgn_ptr]

implement
d3exp_assgn_ref (
  loc, d3e_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eassgn_ref (d3e_l, s2rt, d3ls, d3e_r)
} end // end of [d3exp_assgn_ref]

(* ****** ****** *)

implement
d3exp_xchng_var (
  loc, d2v_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_var (d2v_l, s2rt, d3ls, d3e_r)
} end // end of [d3exp_xchng_var]

implement
d3exp_xchng_ptr (
  loc, d3e_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_ptr (d3e_l, s2rt, d3ls, d3e_r)
} end // end of [d3exp_xchng_ptr]

implement
d3exp_xchng_ref (
  loc, d3e_l, s2rt, d3ls, d3e_r
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Exchng_ref (d3e_l, s2rt, d3ls, d3e_r)
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
d3exp_arrinit
(
  loc, s2e_arr, elt, asz, d3es
) = '{
  d3exp_loc= loc
, d3exp_type= s2e_arr
, d3exp_node= D3Earrinit (elt, asz, d3es)
} // end of [d3exp_arrinit]

implement
d3exp_arrpsz
(
  loc, s2f_arrpsz, s2e, d3es, asz
) = '{
  d3exp_loc= loc
, d3exp_type= s2f_arrpsz
, d3exp_node= D3Earrpsz (s2e, d3es, asz)
} // end of [d3exp_arrpsz]

(* ****** ****** *)

implement
d3exp_raise
(
  loc, s2f, d3e
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eraise (d3e)
} // end of [d3exp_raise]

(* ****** ****** *)

implement
d3exp_effmask
(
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
d3exp_vcopyenv
(
  loc, s2f, knd, d2v
) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Evcopyenv (knd, d2v)
} // end of [d3exp_vcopyenv]

(* ****** ****** *)

implement
d3exp_lam_dyn
(
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
d3exp_delay (
  loc, s2e, _eval
) = '{
  d3exp_loc= loc
, d3exp_type= s2e
, d3exp_node= D3Edelay (_eval)
} // end of [d3exp_delay]

implement
d3exp_ldelay (
  loc, s2e, _eval, _free
) = '{
  d3exp_loc= loc
, d3exp_type= s2e
, d3exp_node= D3Eldelay (_eval, _free)
} // end of [d3exp_ldelay]

(* ****** ****** *)

implement
d3exp_lazy_force (
  loc, s2e_res, lin, delayed
) = '{
  d3exp_loc= loc
, d3exp_type= s2e_res
, d3exp_node= D3Elazy_force (lin, delayed)
} // end of [d3exp_lazy_force]

(* ****** ****** *)

implement
d3exp_loop
(
  loc, init, test, post, body
) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eloop (init, test, post, body)
} end // end of [d3exp_loop]

implement
d3exp_loopexn
  (loc, knd) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eloopexn (knd)
} end // end of [d3exp_loopexn]

(* ****** ****** *)

implement
d3exp_trywith (
  loc, d3e_try, c3ls_wth
) = '{
  d3exp_loc= loc
, d3exp_type= d3e_try.d3exp_type
, d3exp_node= D3Etrywith (d3e_try, c3ls_wth)
} // end of [d3exp_trywith]

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

implement
d3exp_void_err (loc) = let
  val s2f = s2exp_void_t0ype ()
in '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eerr ()
} end // end of [d3exp_void_err]

(* ****** ****** *)

implement
d3lab_lab
  (loc, lab, opt) = '{
  d3lab_loc= loc, d3lab_node= D3LABlab (lab), d3lab_overld= opt
} // end of [d3lab_lab]

implement
d3lab_ind
  (loc, ind) = '{
  d3lab_loc= loc, d3lab_node= D3LABind (ind), d3lab_overld= None
} // end of [d3lab_ind]

(* ****** ****** *)

implement
gm3at_make
  (loc, d3e, op3t) = '{
  gm3at_loc= loc, gm3at_exp= d3e, gm3at_pat= op3t
} // end of [gm3at_make]

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

implement
sc3lau_make (
  loc, sp2t, d3e
) = '{
  sc3lau_loc= loc
, sc3lau_pat= sp2t
, sc3lau_body= d3e
} // end of [sc3lau_make]

(* ****** ****** *)
//
// HX: various declarations
//
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

implement
v3ardec_make (
  loc, knd, d2v, d2vw, s2e, ini
) = '{
  v3ardec_loc= loc
, v3ardec_knd= knd
, v3ardec_dvar_ptr= d2v
, v3ardec_dvar_view= d2vw
, v3ardec_type= s2e
, v3ardec_ini= ini
} // end of [v3ardec_make]

implement
prv3ardec_make (
  loc, d2v, s2e, ini
) = '{
  prv3ardec_loc= loc
, prv3ardec_dvar= d2v
, prv3ardec_type= s2e
, prv3ardec_ini= ini
} // end of [prv3ardec_make]

(* ****** ****** *)

implement
d3ecl_make_node
  (loc, node) = '{
  d3ecl_loc= loc, d3ecl_node= node
} // end of [d3ecl_make_node]

(* ****** ****** *)

implement
d3ecl_none
  (loc) = d3ecl_make_node (loc, D3Cnone ())
// end of [d3ecl_none]
implement
d3ecl_list
  (loc, xs) = d3ecl_make_node (loc, D3Clist (xs))
// end of [d3ecl_list]

(* ****** ****** *)

implement
d3ecl_saspdec (loc, d2c) =
  d3ecl_make_node (loc, D3Csaspdec (d2c))
// end of [d3ecl_saspdec]

(* ****** ****** *)

implement
d3ecl_extcode
  (loc, knd, pos, code) =
  d3ecl_make_node (loc, D3Cextcode (knd, pos, code))
// end of [d3ecl_extcode]

(* ****** ****** *)

implement
d3ecl_datdecs
  (loc, knd, s2cs) =
  d3ecl_make_node (loc, D3Cdatdecs (knd, s2cs))
// end of [d3ecl_datdecs]

(* ****** ****** *)

implement
d3ecl_exndecs
  (loc, d2cs) =
  d3ecl_make_node (loc, D3Cexndecs (d2cs))
// end of [d3ecl_exndecs]

(* ****** ****** *)

implement
d3ecl_dcstdecs
  (loc, knd, d2cs) =
  d3ecl_make_node (loc, D3Cdcstdecs (knd, d2cs))
// end of [d3ecl_dcstdecs]

(* ****** ****** *)

implement
d3ecl_impdec
  (loc, knd, impdec) =
  d3ecl_make_node (loc, D3Cimpdec (knd, impdec))
// end of [d3ecl_impdec]

(* ****** ****** *)

implement
d3ecl_fundecs
  (loc, funknd, decarg, f3ds) =
  d3ecl_make_node (loc, D3Cfundecs (funknd, decarg, f3ds))
// end of [d3ecl_fundecs]

(* ****** ****** *)

implement
d3ecl_valdecs
  (loc, knd, v3ds) =
  d3ecl_make_node (loc, D3Cvaldecs (knd, v3ds))
// end of [d3ecl_valdecs]

implement
d3ecl_valdecs_rec
  (loc, knd, v3ds) =
  d3ecl_make_node (loc, D3Cvaldecs_rec (knd, v3ds))
// end of [d3ecl_valdecs_rec]

(* ****** ****** *)

implement
d3ecl_vardecs
  (loc, v3ds) =
  d3ecl_make_node (loc, D3Cvardecs (v3ds))
// end of [d3ecl_vardecs]

implement
d3ecl_prvardecs
  (loc, v3ds) =
  d3ecl_make_node (loc, D3Cprvardecs (v3ds))
// end of [d3ecl_prvardecs]

(* ****** ****** *)

implement
d3ecl_include
  (loc, d3cs) =
  d3ecl_make_node (loc, D3Cinclude (d3cs))
// end of [d3ecl_include]

(* ****** ****** *)

implement
d3ecl_staload
  (loc, fil, flag, loaded, opt) =
  d3ecl_make_node (loc, D3Cstaload (fil, flag, loaded, opt))
// endof [d3ecl_staload]

(* ****** ****** *)

implement
d3ecl_dynload
  (loc, fil) =
  d3ecl_make_node (loc, D3Cdynload (fil))
// end of [d3ecl_dynload]

(* ****** ****** *)

implement
d3ecl_local
  (loc, head, body) =
  d3ecl_make_node (loc, D3Clocal (head, body))
// endof [d3ecl_local]

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
patsopt_p3at_set_dvaropt (
  ats_ptr_type p3t, ats_ptr_type opt
) {
  ((p3at_t)p3t)->atslab_p3at_dvaropt = opt ; return ;
} // end of [patsopt_p3at_set_dvaropt]

ats_void_type
patsopt_p3at_set_type_left (
  ats_ptr_type p3t, ats_ptr_type opt
) {
  ((p3at_t)p3t)->atslab_p3at_type_left = opt ; return ;
} // end of [patsopt_p3at_set_type_left]

ats_void_type
patsopt_d3exp_set_type (
  ats_ptr_type d3e, ats_ptr_type s2f
) {
  ((d3exp_t)d3e)->atslab_d3exp_type = s2f ; return ;
} // end of [patsopt_d3exp_set_type]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_dynexp3.dats] *)

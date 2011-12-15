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
staload "pats_dynexp3.sats"

(* ****** ****** *)

implement
p3at_var (
  loc, s2f, knd, d2v
) = '{
  p3at_loc= loc
, p3at_node= P3Tvar (knd, d2v)
, p3at_type= s2f
} // end of [p3at_var]

implement
p3at_ann (
  loc, s2f, p3t, ann
) = '{
  p3at_loc= loc
, p3at_node= P3Tann (p3t, ann)
, p3at_type= s2f
} // end of [p3at_ann]

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
  (loc, s2f, rep, inf) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eint (rep, inf)
} // end of [d3exp_int]

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

implement
d3exp_float
  (loc, s2f, rep) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Efloat (rep)
} // end of [d3exp_float]

(* ****** ****** *)

implement
d3exp_empty
  (loc, s2f) = '{
  d3exp_loc= loc
, d3exp_type= s2f
, d3exp_node= D3Eempty ()
} // end of [d3exp_empty]

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
d3exp_err (loc) = '{
  d3exp_loc= loc
, d3exp_type= s2hnf_err (s2rt_t0ype)
, d3exp_node= D3Eerr ()
} // end of [d3exp_err]

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
d3ecl_none (loc) = '{
  d3ecl_loc= loc, d3ecl_node= D3Cnone ()
} // end of [d3ecl_none]

implement
d3ecl_list (loc, xs) = '{
  d3ecl_loc= loc, d3ecl_node= D3Clist (xs)
} // end of [d3ecl_list]

(* ****** ****** *)

implement
d3ecl_datdec
  (loc, knd, s2cs) = '{
  d3ecl_loc= loc, d3ecl_node= D3Cdatdec (knd, s2cs)
} // end of [d3ecl_datdet]

(* ****** ****** *)

implement
d3ecl_dcstdec
  (loc, knd, d2cs) = '{
  d3ecl_loc= loc, d3ecl_node= D3Cdcstdec (knd, d2cs)
} // end of [d3ecl_dcstdec]

(* ****** ****** *)

implement
d3ecl_fundecs (
  loc, funknd, decarg, d3cs
) = '{
  d3ecl_loc= loc
, d3ecl_node= D3Cfundecs (funknd, decarg, d3cs)
} // end of [d3ecl_fundecs]

(* ****** ****** *)

implement
d3ecl_valdecs (loc, knd, d3cs) = '{
  d3ecl_loc= loc, d3ecl_node= D3Cvaldecs (d3cs)
} // end of [d3ecl_valdecs]

(* ****** ****** *)

extern typedef "d3exp_t" = d3exp

%{$

ats_void_type
patsopt_d3exp_set_type (
  ats_ptr_type d3e, ats_ptr_type s2f
) {
  ((d3exp_t)d3e)->atslab_d3exp_type = s2f ; return ;
} // end of [patsopt_d3exp_set_type]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_dynexp3.dats] *)

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
hidexp_let (loc, hse, hids, hde) =
  hidexp_make_node (loc, hse, HDElet (hids, hde))
// end of [hidexp_let]

(* ****** ****** *)

implement
hidexp_lam
  (loc, hse, hips_arg, hde_body) =
  hidexp_make_node (loc, hse, HDElam (hips_arg, hde_body))
// end of [hidexp_lam]

(* ****** ****** *)

implement
hivaldec_make
  (loc, pat, def) = '{
  hivaldec_loc= loc
, hivaldec_pat= pat
, hivaldec_def= def
} // end of [hivaldec_make]

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

implement
hidecl_valdecs (loc, knd, hvds) =
  hidecl_make_node (loc, HIDvaldecs (knd, hvds))
// end of [hidecl_valdecs]

(* ****** ****** *)

(* end of [pats_hidynexp.dats] *)

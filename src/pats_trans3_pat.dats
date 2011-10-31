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

staload _(*anon*) = "prelude/DATS/list.dats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

macdef hnf = s2hnf_of_s2exp
macdef unhnf = s2exp_of_s2hnf

(* ****** ****** *)

local

extern
fun aux_p2at (p2t0: p2at): s2hnf
extern
fun aux_labp2atlst (lp2ts: labp2atlst): labs2explst

implement
aux_p2at (p2t0) = let
in
//
case+ p2t0.p2at_node of
//
  | P2Tann (p2t, s2f) => s2f
//
  | P2Tany _ =>
      s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
    // end of [P2Tany]
  | P2Tvar _ =>
      s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
    // end of [P2Tvar]
//
  | P2Tbool _ => s2exp_bool_t0ype () // bool0
  | P2Tint _ => s2exp_int_t0ype () // int0
  | P2Tchar _ => s2exp_char_t0ype () // char0
  | P2Tstring _ => s2exp_string_type () // string0
  | P2Tfloat _ => s2exp_double_t0ype () // double
//
  | P2Tempty () => s2exp_void_t0ype ()
  | P2Tcon _ =>
      s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
    // end of [P2Tcon]
//
  | P2Tlst _ => let
      val s2e_elt =
        s2exp_Var_make_srt (p2t0.p2at_loc, s2rt_t0ype)
      // end of [val]
    in
      s2exp_list0_t0ype_type (unhnf (s2e_elt))
    end // end of [P2Tlst]
//
  | P2Trec (knd, npf, lp2ts) =>
      s2exp_tyrec (knd, npf, aux_labp2atlst (lp2ts))
    // end of [P2Trec]
//
  | P2Tas (knd, d2v, p2t) => p2at_syn_typ (p2t)
//
  | P2Tlist _ => hnf (s2exp_err s2rt_t0ype)
  | P2Texist _ => hnf (s2exp_err s2rt_t0ype)
  | P2Terr () => hnf (s2exp_err s2rt_t0ype)
(*
  | _ => let
      val () = assertloc (false) in exit (1)
    end // end of [_]
*)
//
end // end of [aux_p2at]
  
implement
aux_labp2atlst (lp2ts) =
  case+ lp2ts of
  | list_cons (lp2t, lp2ts) => (
    case+ lp2t of
    | LP2Tnorm (l, p2t) => let
        val s2f = p2at_syn_typ (p2t)
        val ls2e = SLABELED (l, None(*name*), (unhnf)s2f)
      in
        list_cons (ls2e, aux_labp2atlst (lp2ts))
      end // end of [LP2Tnorm]
    | LP2Tomit () => list_nil () // HX: should an error be reported?
    ) // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_labp2atlst]

in // in of [local]

implement
p2at_syn_typ
  (p2t0) = s2e0 where {
  val s2e0 = aux_p2at (p2t0)
  val () = p2at_set_typ (p2t0, Some (s2e0))
} // end of [p2at_syn_type]

end // end of [local]

implement
p2atlst_syn_typ (p2ts) =
  l2l (list_map_fun (p2ts, p2at_syn_typ))
// end of [p2atlst_syn_typ]

(* ****** ****** *)

(* end of [pats_trans3_pat.dats] *)

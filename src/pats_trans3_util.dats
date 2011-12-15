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

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_dynexp"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

implement
d2exp_funclo_of_d2exp
  (d2e0, fc0) =
  case+ d2e0.d2exp_node of
  | D2Eann_funclo (d2e, fc) => (fc0 := fc; d2e)
  | _ => d2e0
// end of [d2exp_funclo_of_d2exp]

(* ****** ****** *)

implement
d2exp_s2eff_of_d2exp
  (d2e0, s2fe0) =
  case+ d2e0.d2exp_node of
  | D2Elam_dyn _ => d2e0
  | D2Elaminit_dyn _ => d2e0
  | D2Elam_sta _ => d2e0
  | D2Eann_seff
      (d2e, s2fe) => let
      val () = s2fe0 := s2fe in d2e
    end // end of [D2Eann_seff]
  | _ => let
      val () = s2fe0 := S2EFFall () in d2e0
    end // end of [_]
// end of [d2exp_s2eff_of_d2exp]

(* ****** ****** *)

implement
d2exp_is_varlamcst
  (d2e0) = begin
  case+ d2e0.d2exp_node of
  | D2Evar _ => true
  | D2Elam_dyn _ => true
  | D2Eint _ => true
  | D2Ebool _ => true
  | D2Echar _ => true
  | D2Estring _ => true
  | D2Ei0nt _ => true
  | D2Ec0har _ => true
  | D2Es0tring _ => true
  | D2Etop _ => true
  | _ => false
end // end of [d2exp_is_varlamcst]

(* ****** ****** *)

implement
d23exp_free (x) = case+ x of
  | ~D23Ed2exp (d2e) => () | ~D23Ed3exp (d3e) => ()
// end of [d23exp_free]

implement
d23explst_free (xs) = case+ xs of
  | ~list_vt_cons (x, xs) => (d23exp_free (x); d23explst_free (xs))
  | ~list_vt_nil () => ()
// end of [d23explst_free]

(* ****** ****** *)

implement
d3exp_trdn
  (d3e, s2f) = d3e where {
  val loc = d3e.d3exp_loc
  val () = begin
    print "d3exp_trdn: d3e.d3exp_type = "; print_s2hnf (d3e.d3exp_type); print_newline ()
  end // end of [val]
  val () = begin
    print "d3exp_tr_dn: s2f = "; print_s2hnf (s2f); print_newline ()
  end // end of [val]
  val err = $SOL.s2hnf_tyleq_solve (loc, d3e.d3exp_type, s2f)
  val () = if (err != 0) then let
    val () = prerr_error3_loc (loc)
    val () = filprerr_ifdebug "d3exp_trdn"
    val () = prerr ": the dynamic expression can not be assigned the type ["
    val () = prerr_s2hnf (s2f)
    val () = prerr "]."
    val () = prerr_newline ()
    val () = prerr_the_staerrlst ()
  in
    the_trans3errlst_add (T3E_d3exp_trdn (d3e, s2f))
  end // end of [val]
  val () = d3exp_set_type (d3e, s2f)
} // end of [d3exp_trdn]

(* ****** ****** *)

(* end of [pats_trans3_util.dats] *)

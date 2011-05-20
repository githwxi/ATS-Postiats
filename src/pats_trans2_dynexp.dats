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
// Start Time: May, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_dynexp"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans2.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

#include "pats_basics.hats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
d1exp_tr (d1e0) = let
// (*
  val () = begin
    print "d1exp_tr: d1e0 = "; print_d1exp d1e0; print_newline ()
  end // end of [val]
// *)
  val loc0 = d1e0.d1exp_loc
in
//
case+ d1e0.d1exp_node of
//
| D1Ei0nt (x) => d2exp_i0nt (loc0, x)
| D1Ec0har (x) => d2exp_c0har (loc0, x)
| D1Ef0loat (x) => d2exp_f0loat (loc0, x)
| D1Es0tring (x) => d2exp_s0tring (loc0, x)
//
| D1Elist (npf, d1es) => (
  case+ d1es of
  | list_cons _ => let
      val knd = TYTUPKIND_flt // HX: flat tuple
      val d2es = d1explst_tr (d1es)
    in
      d2exp_tup (loc0, knd, npf, d2es)
    end // end of [list_cons]
  | list_nil () => d2exp_empty (loc0)
  ) // end of [D1Elist]
| D1Elet (d1cs, d1e) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_let (loc0, d2cs, d2e)
  end // end of [D1Elet]
| D1Ewhere (d1e, d1cs) => let
    val (pfenv | ()) = the_trans2_env_push ()
    val d2cs = d1eclist_tr (d1cs); val d2e = d1exp_tr (d1e)
    val () = the_trans2_env_pop (pfenv | (*none*))
  in
    d2exp_where (loc0, d2e, d2cs)
  end // end of [D1Ewhere]
| D1Eann_type (d1e, s1e) => let
    val d2e = d1exp_tr d1e
    val s2e = s1exp_trdn_impredicative (s1e)
  in
    d2exp_ann_type (loc0, d2e, s2e)
  end // end of [D1Eann_type]
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": d1exp_tr: not yet implemented: d1e0 = "
    val () = prerr_d1exp (d1e0)
    val () = prerr "]"
    val () = prerr_newline ()
  in
    $ERR.abort {d2exp} ()
  end // end of [_]
//
end // end of [d1exp_tr]

(* ****** ****** *)

implement d1explst_tr (d1es) = l2l (list_map_fun (d1es, d1exp_tr))

(* ****** ****** *)

(* end of [pats_trans2_dynexp.dats] *)

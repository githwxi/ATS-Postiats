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
// Start Time: May, 2012
//
(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_selab"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

local

fun auxerr1 (
  loc0: location, d2v: d2var
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is not mutable and thus [view@] cannot be applied."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2exp_trup_ptrof_dvar (loc0, d2v))
end // end of [auxerr1]

in // in of [local]

implement
d2exp_trup_viewat
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
in
//
case+
  d2e0.d2exp_node of
| D2Evar (d2v) => let
    val opt = d2var_get_addr (d2v)
  in
    case+ opt of
    | Some (s2l) => let
        val s2e_ptr =
          d2var_get_type_some (loc0, d2v)
        val d3e_ptr =
          d3exp_ptrof_var (loc0, s2e_ptr, d2v)
        val opt = pfobj_search_atview (s2l)
      in
        case+ opt of
        | ~Some_vt (pfobj) => let
            val+ ~PFOBJ (
              d2vw, s2e_ctx, s2e_elt, s2l
            ) = pfobj // end of [val]
            val s2e_out = s2exp_without (s2e_elt)
            val s2e = s2exp_hrepl (s2e_ctx, s2e_out)
            val () = d2var_set_type (d2vw, Some (s2e))
            val s2e_at = s2exp_at (s2e_elt, s2l)
          in
            d3exp_viewat (loc0, s2e_at, d3e_ptr, list_nil(*d3ls*))
          end // end of [Some_vt]
        | ~None_vt () => let
            val s2e_at = s2exp_t0ype_err () in
            d3exp_viewat (loc0, s2e_at, d3e_ptr, list_nil(*d3ls*))
          end // end of [None]
      end // end of [Some]
    | None () => let
        val () = auxerr1 (loc0, d2v) in d3exp_err (loc0)
      end // end of [None]
  end (* end of [D2Evar] *)
//
| _ => exitloc (1)
//
end // end of [d2exp_trup_viewat]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_view.dats] *)

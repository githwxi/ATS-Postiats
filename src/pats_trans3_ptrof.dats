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
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"

(* ****** ****** *)

local

fun auxerr1 (
  d2e0: d2exp
) : void = let
  val loc0 = d2e0.d2exp_loc
  val () = prerr_error3_loc (loc0)
in
  the_trans3errlst_add (T3E_d2exp_trup_ptrof (d2e0))
end // end of [auxerr1]

in

implement
d2exp_trup_ptrof
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
        val s2f =
          s2exp_ptr_addr_type (s2l)
        // end of [val]
      in
        d3exp_ptrof_var (loc0, s2f, d2v)
      end // end of [Some]
    | None () => let
        val () = auxerr1 (d2e0) in d3exp_err (loc0)
      end // end of [None]
  end (* end of [D2Evar] *)
| _ => exitloc (1)
//
end // end of [d2exp_trup_ptrof]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_ptrof.dats] *)

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

staload "pats_basics.sats"
macdef isdebug () = (debug_flag_get () > 0)

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
typedef symbol = $SYM.symbol
overload = with $SYM.eq_symbol_symbol

staload SYN = "pats_syntax.sats"
typedef s0taq = $SYN.s0taq

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_staexp2.sats"
staload "pats_trans2_env.sats"
staload "pats_trans2.sats"

(* ****** ****** *)

fn prerr_loc_error2
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_loc_error2]

(* ****** ****** *)

(*
** HX: static special identifier
*)
datatype staspecid = SPSIDarrow | SPSIDnone

fn staspecid_of_qid
  (q: s0taq, id: symbol): staspecid = begin
  case+ q.s0taq_node of
  | $SYN.S0TAQnone () => begin
      if id = $SYM.symbol_MINUSGT then SPSIDarrow () else SPSIDnone ()
    end // end of [S0TAQnone]
  | _ => SPSIDnone ()
end // end of [staspecid_of_qid]

(* ****** ****** *)

implement
s1rtext_tr (s1te0) = let
(*
*)
in
//
case+ s1te0.s1rtext_node of
| S1TEsrt (s1t) => (case+ s1t.s1rt_node of
  | S1RTqid (q, id) => let
      val ans = the_s2rtenv_find_qua (q, id)
    in
      case+ ans of
      | ~Some_vt s2te => s2te
      | ~None_vt () => S2TEerr () where {
          val () = the_tran2errlst_add (T2E_s1rtext_qid (q, id))
          val () = prerr_loc_error2 (s1t.s1rt_loc)
          val () = if isdebug () then prerr (": s1rtext_tr")
          val () = prerr ": the identifier [";
          val () = ($SYN.prerr_s0rtq (q); $SYM.prerr_symbol (id))
          val () = prerr "] refers to an unrecognized sort.";
          val () = prerr_newline ()
        } // end of [None_vt]
    end (* end of [S1RTqid] *)
  | _ => S2TEsrt (s1rt_tr s1t)
  ) // end of [S1TEsrt]
(*
| S1TEsub (id, s1te, s1ps) => let
    val s2te = s1rtext_tr s1te
    val s2t = begin case+ s2te of
      | S2TEsrt s2t => s2t | S2TEsub (_, s2t, _) => s2t
    end // end of [val]
    val s2v = s2var_make_id_srt (id, s2t)
    val (pf_s2expenv | ()) = the_s2expenv_push ()
    val () = the_s2expenv_add_svar s2v
    val s2ps = s1explst_tr_dn_bool s1ps
    val () = the_s2expenv_pop (pf_s2expenv | (*none*))
    val s2ps = (
      case+ s2te of
      | S2TEsrt _ => s2ps
      | S2TEsub (s2v1, _, s2ps1) => begin
          $Lst.list_append (s2ps, s2explst_alpha (s2v1, s2v, s2ps1))
        end
    ) : s2explst // end of [val]
  in
    S2TEsub (s2v, s2t, s2ps)
   end // end of [S1TEsub]
*)
| S1TEsub _ => S2TEerr ()
// end of [case]
end // end of [s1rtext_tr]

(* ****** ****** *)

(* end of [pats_trans2_staexp.dats] *)

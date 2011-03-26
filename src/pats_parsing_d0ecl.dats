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
// Start Time: March, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

(*
d0ecl
  | INFIX p0rec i0deseq
  | PREFIX p0rec i0deseq
  | POSTFIX p0rec i0deseq
  | NONFIX i0deseq
*)

fun
p_d0ecl_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_FIXITY _ => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_p0rec (buf, bt, err)
    val ent3 = p_i0deseq1 (buf, bt, err)
  in
    if err = 0 then (
      d0ecl_fixity (tok, ent2, ent3)
    ) else synent_null ()
  end
| T_NONFIX () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = 0 then
      d0ecl_nonfix (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SYMINTR () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = 0 then
      d0ecl_symintr (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPDEFINE () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_i0de (buf, bt, err)
    val ent3 = popt_fun {e0xp} (buf, bt, p_e0xp)
  in
    if err = 0 then let
      val ent3 = option_of_option_vt (ent3)
    in
      d0ecl_e0xpdef (tok, ent2, ent3)
    end else let
      val () = option_vt_free (ent3) in synent_null ()
    end (* end of [if] *)
  end
| T_SRPASSERT () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_assert (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPERROR () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_error (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPPRINT () => let
    val () = incby1 ()
    val bt = 0 // there is no backtracking
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_print (tok, ent2) else synent_null ()
    // end of [if]
  end
| _ => synent_null ()
// end of [case]
end // end of [p_d0ecl_tok]

implement
p_d0ecl
  (buf, bt, err) = res where {
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val res = p_d0ecl_tok (buf, bt, err, tok)
  val () = if
    synent_is_null (res) then let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_d0ecl)
  end // end of [val]
} // end of [p_d0ecl]

(* ****** ****** *)

implement
p_d0eclist
  (buf, bt, err) = let
  val xs = pstar_fun (buf, bt, p_d0ecl)
in
  list_of_list_vt (xs)
end // end of [d0eclist]

(* ****** ****** *)

(* end of [pats_parsing_d0ecl.dats] *)

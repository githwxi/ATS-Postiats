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

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

(*
e0xpseq ::=
  | /*(empty)*/ | e0xp {COMMA e0xpseq}
; /* e0xpseq */
*)

fun
p_e0xpseq (
  buf: &tokbuf
, bt: int
, err: &int
) : List_vt (e0xp) =
  pstar_fun0_COMMA {e0xp} (buf, bt, p_e0xp)
// end of [p_e0xpseq]

(* ****** ****** *)

(*
atme0xp ::=
  | i0de
  | LITERAL_char
  | LITERAL_float
  | LITERAL_int
  | LITERAL_string
  | LPAREN e0xpseq RPAREN
  | PERCENTLPAREN e0xp RPAREN
; /* atme0xp */
*)
fun
p_atme0xp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : e0xp = let
  var ent: synent?
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
(*
  val () = println! ("p_atme0xp: tok = ", tok)
*)
in
//
case+ tok.token_node of
//
| _ when
    ptest_fun (buf, p_i0de, ent) =>
    e0xp_i0de (synent_decode (ent))
//
| _ when
    ptest_fun (buf, p_i0nt, ent) =>
    e0xp_i0nt (synent_decode {i0nt} (ent))
//
| T_CHAR _ => let
    val () = incby1 () in e0xp_char (tok)
  end
| T_FLOAT_deciexp _ => let
    val () = incby1 () in e0xp_float (tok)
  end
| T_STRING _ => let
    val () = incby1 () in e0xp_string (tok)
  end
//
| T_LPAREN () => let
    val () = incby1 ()
    val ent2 = p_e0xpseq (buf, bt, err)
    val ent2 = list_of_list_vt (ent2)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = 0 then e0xp_list (tok, ent2, ent3) else synent_null ()
  end // end of [T_LPAREN]
| T_PERCENTLPAREN () => let
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = 0 then e0xp_eval (tok, ent2, ent3) else synent_null ()
  end // end of [T_PERCENTLPAREN]
| _ => synent_null ()
//
end // end of [p_atme0xp_tok]

fun
p_atme0xp (
  buf: &tokbuf, bt: int, err: &int
) : e0xp = res where {
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val res = p_atme0xp_tok (buf, bt, err, tok)
  val () = if
    synent_is_null (res) then let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_atme0xp)
  end // end of [val]
} // end of [p_atme0xp]

(* ****** ****** *)

(*
e0xp ::= {atme0xp}+
*)

implement
p_e0xp (buf, bt, err) = let
  val x0 = p_atme0xp (buf, bt, err)
  val xs1 = pstar_fun (buf, bt, p_atme0xp)
  fun loop (
    x0: e0xp, xs1: List_vt (e0xp)
  ) : e0xp =
    case+ xs1 of
    | ~list_vt_cons (x1, xs1) => let
        val x0 = e0xp_app (x0, x1) in loop (x0, xs1)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => x0
  // end of [loop]
in
  loop (x0, xs1)
end // end of [p_e0xp]

(* ****** ****** *)

(* end of [pats_parsing_e0xp.dats] *)

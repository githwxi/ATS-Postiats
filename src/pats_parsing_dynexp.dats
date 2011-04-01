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

staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

(*
di0de
  | IDENTIFIER_alp
  | IDENTIFIER_sym
  | BACKSLASH
  | BANG
  | EQ
  | GT
  | GTLT
  | LT
  | TILDE
*)

implement
p_di0de
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_alp (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| T_IDENT_sym (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
//
| T_GT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_GT)
  end
| T_LT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_LT)
  end
//
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_BACKSLASH)
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_BANG)
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_TILDE)
  end
//
| T_GTLT () => let
    val () = incby1 () in i0de_make_sym (loc, symbol_GTLT)
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_di0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_di0de]

(* ****** ****** *)

implement
p_pi0de
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_alp (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| T_IDENT_sym (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_pi0de)
  in
    synent_null ()
  end // end of [_]
end // end of [p_pi0de]

(* ****** ****** *)

(*
d0ynq ::=
  | i0de_dlr DOT
  | i0de_dlr COLON
  | i0de_dlr i0de_dlr COLON
/*
  | DOLLAR LITERAL_string DOT
  | DOLLAR LITERAL_string i0de_dlr COLON
*/
*)
implement
p_d0ynq (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ 0 of
| _ when
    ptest_fun (
      buf, p_i0de_dlr, ent
    ) => let
    val ent1 = synent_decode {i0de} (ent)
    val tok2 = tokbuf_get_token (buf)
  in
    case+ tok2.token_node of
    | T_DOT () => let
        val () = incby1 () in d0ynq_symdot (ent1, tok2)
      end
    | T_COLON () => let
        val () = incby1 () in d0ynq_symcolon (ent1, tok2)
      end
    | _ => let
        val ~SYNENT2 (ent2, ent3) =
          pseq2_fun {i0de,token} (buf, bt, err, p_i0de_dlr, p_COLON)
        // end of [val]
      in
        if err = err0 then
          d0ynq_symdotcolon (ent1, ent2, ent3)
        else let
(*
          val () = the_parerrlst_add_ifnbt (bt, ent1.i0de_loc, PE_d0ynq)
*)
        in
          tokbuf_set_ntok_null (buf, n0)
        end (* end of [if] *)
      end // end of [_]
  end (* end of [_ when ...] *)
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_d0ynq]

(* ****** ****** *)

implement
p_dqi0de
  (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ 0 of
| _ when
    ptest_fun (buf, p_si0de, ent) =>
    dqi0de_make_none (synent_decode {i0de} (ent))
| _ when
    ptest_fun (buf, p_d0ynq, ent) => let
    val bt = 0
    val ent1 = synent_decode {d0ynq} (ent)
    val ent2 = p_si0de (buf, bt, err)
  in
    if err = err0 then
      dqi0de_make_some (ent1, ent2)
    else
      tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_dqi0de)
  in
    synent_null ()
  end
//
end // end of [p_dqi0de]

(* ****** ****** *)

(* end of [pats_parsing_dynexp.dats] *)

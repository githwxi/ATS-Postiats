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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "pats_symbol.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_lexing.sats" // for tokens
staload "pats_tokbuf.sats" // for tokenizing

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

implement
p_BAR (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_BAR, PE_BAR)
implement
p_BAR_test (buf) = ptoken_test_fun (buf, is_BAR)

implement
p_COMMA (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_COMMA, PE_COMMA)
implement
p_COMMA_test (buf) = ptoken_test_fun (buf, is_COMMA)

implement
p_SEMICOLON (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_SEMICOLON, PE_SEMICOLON)
implement
p_SEMICOLON_test (buf) = ptoken_test_fun (buf, is_SEMICOLON)

implement
p_RPAREN (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_RPAREN, PE_RPAREN)
implement
p_RPAREN_test (buf) = ptoken_test_fun (buf, is_RPAREN)

implement
p_EOF (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_EOF, PE_EOF)
// end of [p_EOF]

(* ****** ****** *)

fun
i0nt_make_base_rep_sfx (
  loc: location, base: int, rep: string, sfx: uint
) : i0nt = '{
  i0nt_loc= loc
, i0nt_bas= base
, i0nt_rep= rep
, i0nt_sfx= sfx
} // end of [i0nt_make_base_rep_sfx]

implement
p_i0nt (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_INTEGER (base, str, sfx) => let
    val () = incby1 ()
  in
    i0nt_make_base_rep_sfx (loc, base, str, sfx)
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0nt)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_i0nt]

(* ****** ****** *)

implement
p_s0tring
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_STRING _ => let
    val () = incby1 () in tok
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_s0tring)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_s0tring]

(* ****** ****** *)

fun
i0de_make_string (
  loc: location, name: string
) : i0de = let
  val sym = symbol_make_string (name)
in '{
  i0de_loc= loc, i0de_sym= sym
} end // end of [i0de_make_string]

(* ****** ****** *)

(*
i0de
  : IDENTIFIER_alp
  | IDENTIFIER_sym
  | EQ
  | GT
  | LT
  | AMPERSAND
  | BACKSLASH
  | BANG
  | TILDE
  | MINUSGT
  | MINUSLTGT
  | GTLT
; /* i0de */
*)

implement
p_i0de
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
| T_EQ () => let
    val () = incby1 () in i0de_make_string (loc, "=")
  end
| T_GT () => let
    val () = incby1 () in i0de_make_string (loc, ">")
  end
| T_LT () => let
    val () = incby1 () in i0de_make_string (loc, "<")
  end
//
| T_AMPERSAND () => let
    val () = incby1 () in i0de_make_string (loc, "&")
  end
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_string (loc, "\\")
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_string (loc, "!")
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_string (loc, "~")
  end
//
| T_MINUSGT () => let
    val () = incby1 () in i0de_make_string (loc, "->")
  end
| T_MINUSLTGT () => let
    val () = incby1 () in i0de_make_string (loc, "-<>")
  end
//
| T_GTLT () => let
    val () = incby1 () in i0de_make_string (loc, "><")
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_i0de]

(* ****** ****** *)

implement
p_i0de_dlr
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_dlr (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0de_dlr)
  in
    synent_null ()
  end // end of [_] 
//
end // end of [p_i0de_dlr]

(* ****** ****** *)

(*
si0de
  | IDENTIFIER_alp
  | IDENTIFIER_sym
  | R0EAD // this one is removed in Postiats
  | GT
  | LT
  | AMPERSAND
  | BACKSLASH
  | BANG
  | TILDE
  | MINUSGT
*)

implement
p_si0de
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
    val () = incby1 () in i0de_make_string (loc, ">")
  end
| T_LT () => let
    val () = incby1 () in i0de_make_string (loc, "<")
  end
//
| T_AMPERSAND () => let
    val () = incby1 () in i0de_make_string (loc, "&")
  end
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_string (loc, "\\")
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_string (loc, "!")
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_string (loc, "~")
  end
//
| T_MINUSGT () => let
    val () = incby1 () in i0de_make_string (loc, "->")
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_si0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_si0de]

(* ****** ****** *)

(*
s0taq
  | /*empty*/
  | i0de_dlr DOT
  | i0de_dlr COLON
/*
  | DOLLAR LITERAL_string DOT // this one is removed
*/
*)

implement
p_s0taq (buf, bt, err) = let
  var ent: synent?
  val n0 = tokbuf_get_ntok (buf)
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
        val () = incby1 () in s0taq_symdot (ent1, tok2)
      end
    | T_COLON () => let
        val () = incby1 () in s0taq_symcolon (ent1, tok2)
      end
    | _ => let
        val () = tokbuf_set_ntok (buf, n0)
      in
        synent_null () // HX: there is no error
      end // end of [_]
  end (* end of [_ when ...] *)
| _ => synent_null () // HX: there is no error
//
end // end of [p_s0taq]

(*
sqi0de := s0taq si0de
*)

implement
p_sqi0de (buf, bt, err) = let
  val ent1 = p_s0taq (buf, bt, err)
  val ent2 = p_si0de (buf, bt, err)
in
  if err = 0 then
    sqi0de_make (ent1, ent2)
  else let
(*
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_s0taq)
*)
  in
    synent_null ()
  end (* end of [if] *)
end // end of [p_sqi0de]

(* ****** ****** *)

(*
i0deseq1 := {i0de}+
*)
implement
p_i0deseq1
  (buf, bt, err) = let
  val xs = pplus_fun (buf, bt, p_i0de)
in
  list_of_list_vt (xs)
end // end of [p_i0deseq1]

(* ****** ****** *)

(*
p0rec
  : /*(empty)*/
  | LITERAL_int
  | LPAREN i0de RPAREN
  | LPAREN i0de IDENTIFIER_sym LITERAL_int RPAREN
; /* p0rec */
*)
fun
p_p0rec_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : p0rec = let
  var ent: synent?
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| _ when
    ptest_fun (buf, p_i0nt, ent) => p0rec_i0nt (synent_decode {i0nt} (ent))
| T_LPAREN () => let
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
    val ent3 = tokbuf_get_token (buf)
  in
    case+ ent3.token_node of
    | T_RPAREN () => let
        val () = incby1 () in p0rec_i0de (ent2)
      end
    | T_IDENT_sym _ => let
        val () = incby1 ()
        val ent4 = p_i0nt (buf, bt, err)
        val ent5 = p_RPAREN (buf, bt, err)
      in
        if err = 0 then p0rec_i0de_adj (ent2, ent3, ent4) else synent_null ()
      end
    | _ => synent_null ()
  end (* T_LPAREN *)
| _ => p0rec_emp ()
//
end // end of [p_p0rec_tok]

implement
p_p0rec
  (buf, bt, err) = res where {
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val res = p_p0rec_tok (buf, bt, err, tok)
  val () = if
    synent_is_null (res) then let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_p0rec)
  end // end of [val]
} // end of [p_p0rec]

(* ****** ****** *)

(* end of [pats_parsing_misc.dats] *)

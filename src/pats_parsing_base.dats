(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_symbol.sats"
staload "./pats_label.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_lexing.sats" // for tokens
staload "./pats_tokbuf.sats" // for tokenizing

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
p_i0nt (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_INT _ => let
    val () = incby1 () in tok
  end
| _ (*non-INT*) => let
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
case+
tok.token_node of
| T_STRING _ => let
    val () = incby1 () in tok
  end
| _ (*non-STRING*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_s0tring)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_s0tring]

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
p_i0de (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
//
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
| T_AT () => let
    val () = incby1 () in i0de_make_string (loc, "@")
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

(*
i0deseq1 := {i0de}+
*)
implement
p_i0deseq1
  (buf, bt, err) = let
  val xs = pstar1_fun (buf, bt, err, p_i0de)
in
  list_of_list_vt (xs)
end // end of [p_i0deseq1]

(* ****** ****** *)

implement
p_i0dext
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_IDENT_ext (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| _ (*non-IDENT-ext*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0dext)
  in
    synent_null ()
  end // end of [_] 
//
end // end of [p_i0dext]

(* ****** ****** *)

implement
p_i0de_dlr
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_IDENT_dlr (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| _ (*non-IDENT-dlr*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_i0de_dlr)
  in
    synent_null ()
  end // end of [_] 
//
end // end of [p_i0de_dlr]

(* ****** ****** *)

(*
l0ab :=
  | i0de
  | i0nt
/*
  | LPAREN l0ab RPAREN // HX: this is removed for now
*/
*)
implement
p_l0ab
  (buf, bt, err) = let
  var ent: synent?
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| _ when
    ptest_fun (
      buf, p_i0de, ent
    ) => l0ab_make_i0de (synent_decode {i0de} (ent))
| T_INT _ => let
    val () = incby1 () in l0ab_make_i0nt (tok)
  end // end of [T_INT]
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_l0ab)
  in
    synent_null ()
  end
//
end // end of [p_l0ab]

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
  val err0 = err
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
//
| T_INT _ => let
    val () = incby1 () in p0rec_i0nt (tok)
  end
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
  in
    if err = err0 then let
      val tok2 = tokbuf_get_token (buf)
    in
      case+ tok2.token_node of
      | _ when
          ptest_fun (buf, p_i0de, ent) => let
          val ent3 = synent_decode {i0de} (ent)
          val ent4 = p_i0nt (buf, bt, err)
          val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
        in
          if err = err0 then
            p0rec_i0de_adj (ent2, ent3, ent4) else synent_null ()
          // end of [if]
        end
      | _ => let
          val ent3 = p_RPAREN (buf, bt, err)
        in
          if err = err0 then p0rec_i0de (ent2) else synent_null ()
        end
    end else
      synent_null ()
    // end of [if]
  end (* T_LPAREN *)
//
| _ (*rest-of-token*) => p0rec_emp ()
//
end // end of [p_p0rec_tok]

implement
p_p0rec
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_p0rec_tok, PE_p0rec)
// end of [p_p0rec]

(* ****** ****** *)

fun
p_effi0de (
  buf: &tokbuf, bt: int, err: &int
) : i0de = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_IDENT_alp name => let
    val () = incby1 () in i0de_make_string (loc, name)
  end
| _ (*non-IDENT-alp*) => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_effi0de]

(*
e0fftag ::=
  | FUN
  | BANG effi0de
  | TILDE effi0de
  | effi0de
  | LITERAL_int
*)
implement
p_e0fftag
  (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
//
| T_FUN _ => let
    val () = incby1 () in e0fftag_var_fun (tok)
  end
//
| T_BANG () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_effi0de (buf, bt, err)
  in
    if err = err0 then
      e0fftag_cst (0, ent2) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
//
| T_TILDE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_effi0de (buf, bt, err)
  in
    if err = err0 then
      e0fftag_cst (0, ent2) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
//
| T_INT _ => let
    val () = incby1 () in e0fftag_i0nt (tok)
  end
//
| _ when
    ptest_fun (
    buf, p_effi0de, ent
  ) => e0fftag_i0de (synent_decode {i0de} (ent))
| _ (*rest-of-token*) => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_e0fftag]

implement
p_e0fftaglst
  (buf, bt, err) = l2l (
  pstar_fun0_COMMA {e0fftag} (buf, bt, p_e0fftag)
) // end of [p_e0fftaglst]

(* ****** ****** *)

(*
colonwith
  | COLON
  | COLONLTGT
  | COLONLT e0fftagseq GT
*)
implement
p_colonwith
  (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
//
(*
  val () = println! ("p_colonwith: bt = ", bt)
  val () = println! ("p_colonwith: tok = ", tok)
*)
//
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_COLON () => let
    val () = incby1 () in None ()
  end
| T_COLONLT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0fftaglst (buf, bt, err)
    val ent3 = p_GT (buf, bt, err) // err = err0
  in
    if err = err0 then
      Some (ent2) else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
| _ (*rest-of-token*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_colonwith)
  in
    synent_null ()
  end (* end of [_] *)
//
end // end of [p_colonwith]

(* ****** ****** *)

implement
p_dcstkind
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_FUN _ => let
    val () = incby1 () in tok
  end
| T_VAL _ => let
    val () = incby1 () in tok
  end
| _ (*rest-of-token*) => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_dcstkind]

(* ****** ****** *)

#define s2s string1_of_string

(* ****** ****** *)

implement
p_extnamopt
  (buf, bt, err) = let
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
in
//
case+
tok.token_node of
| T_EQ () => let
    val bt = 0
    val () = tokbuf_incby1 (buf)
    val ent2 = p_s0tring (buf, bt, err)
  in
    if synent_is_null (ent2) then let
      val () = tokbuf_set_ntok (buf, n0) in None ()
    end else Some (ent2) // end of [if]
  end
| _ (*non-EQ*) => None ()
//
end // end of [p_extnamopt]

(* ****** ****** *)

(* end of [pats_parsing_base.dats] *)

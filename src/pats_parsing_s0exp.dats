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

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
viewtypedef s0explst_vt = List_vt (s0exp)

(* ****** ****** *)

dataviewtype
s0explst12 =
  | S0EXPLST12one of s0explst_vt
  | S0EXPLST12two of (s0explst_vt, s0explst_vt)
// end of [s0explst12]

fun s0explst12_free
  (ent: s0explst12): void =
  case+ ent of
  | ~S0EXPLST12one xs => list_vt_free (xs)
  | ~S0EXPLST12two (xs1, xs2) => (
      list_vt_free (xs1); list_vt_free (xs2)
    )
// end of [s0explst12_free]

(* ****** ****** *)

fun s0exp_list12 (
  t_beg: token, ent2: s0explst12, t_end: token
) : s0exp =
  case+ ent2 of
  | ~S0EXPLST12one (xs) => s0exp_list (t_beg, (l2l)xs, t_end)
  | ~S0EXPLST12two (xs1, xs2) => s0exp_list2 (t_beg, (l2l)xs1, (l2l)xs2, t_end)
// end of [s0exp_list12]

fun s0exp_tytup12 (
  knd: int, t_beg: token, ent2: s0explst12, t_end: token
) : s0exp =
  case+ ent2 of
  | ~S0EXPLST12one (xs) => s0exp_tytup (knd, t_beg, (l2l)xs, t_end)
  | ~S0EXPLST12two (xs1, xs2) => s0exp_tytup2 (knd, t_beg, (l2l)xs1, (l2l)xs2, t_end)
// end of [s0exp_tytup12]

(* ****** ****** *)

fun
p_s0expseq (
  buf: &tokbuf
, bt: int
, err: &int
) : List_vt (s0exp) =
  pstar_fun0_COMMA {s0exp} (buf, bt, p_s0exp)
// end of [p_s0expseq]

fun
p_s0expseq_BAR_s0expseq (
  buf: &tokbuf
, bt: int
, err: &int
) : s0explst12 = let
  val xs1 = p_s0expseq (buf, bt, err)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_BAR () => let
    val () = incby1 ()
    val xs2 = p_s0expseq (buf, bt, err)
  in
    S0EXPLST12two (xs1, xs2)
  end
| _ => S0EXPLST12one (xs1)
//
end // end of [p_s0expseq_BAR_s0expseq]

(* ****** ****** *)

(*
atms0exp
  | i0nt
  | LITERAL_char
  | sqi0de
  | OP si0de
//
  | LPAREN s0expseq RPAREN
  | LPAREN s0expseq BAR s0expseq RPAREN
//
  | ATLPAREN s0expseq RPAREN // knd = 0
  | ATLPAREN s0expseq BAR s0expseq RPAREN
//
  | QUOTELPAREN s0expseq RPAREN // knd = 1
  | QUOTELPAREN s0expseq BAR s0expseq RPAREN
//
  | ATLBRACE labs0expseq RBRACE
  | QUOTELBRACE labs0expseq RBRACE
//
  | ATLBRACKET s0exp RBRACKET LBRACKET s0arrind
//
  | DLRTUP_T LPAREN s0expseq RPAREN
  | DLRTUP_VT LPAREN s0expseq RPAREN
  | DLRTUP_T LPAREN s0expseq BAR s0expseq RPAREN
  | DLRTUP_VT LPAREN s0expseq BAR s0expseq RPAREN
//
  | DLRREC_T LBRACE labs0expseq RBRACE
  | DLRREC_VT LBRACE labs0expseq RBRACE
  | DLREXTYPE_STRUCT LITERAL_string OF LBRACE labs0expseq RBRACE
  | MINUSLT e0fftagseq GT
  | MINUSLTGT
  | LBRACE s0quaseq RBRACE
  | LBRACKET s0quaseq RBRACKET
  | HASHLBRACKET s0quaseq RBRACKET
*)

(* ****** ****** *)

fun
p_atms0exp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : s0exp = let
  var ent: synent?
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
(*
  val () = println! ("p_atms0exp: tok = ", tok)
*)
in
//
case+ tok.token_node of
| _ when
    ptest_fun (buf, p_sqi0de, ent) =>
    s0exp_sqid (synent_decode {sqi0de} (ent))
| _ when
    ptest_fun (buf, p_i0nt, ent) =>
    s0exp_i0nt (synent_decode {i0nt} (ent))
| T_OP _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_si0de (buf, bt, err)
  in
    if err = 0 then
      s0exp_opid (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_CHAR _ => let
    val () = incby1 () in s0exp_char (tok)
  end
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expseq_BAR_s0expseq (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = 0 then
      s0exp_list12 (tok, ent2, ent3)
    else let
      val () = s0explst12_free (ent2) in synent_null ()
    end // end of [if]
  end
| T_ATLPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expseq_BAR_s0expseq (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = 0 then
      s0exp_tytup12 (0(*knd*), tok, ent2, ent3)
    else let
      val () = s0explst12_free (ent2) in synent_null ()
    end // end of [if]
  end
| T_QUOTELPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expseq_BAR_s0expseq (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = 0 then
      s0exp_tytup12 (1(*knd*), tok, ent2, ent3)
    else let
      val () = s0explst12_free (ent2) in synent_null ()
    end // end of [if]
  end
//
| _ => synent_null ()
//
end // end of [p_atms0exp_tok]

fun
p_atms0exp (
  buf: &tokbuf, bt: int, err: &int
) : s0exp = res where {
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val res = p_atms0exp_tok (buf, bt, err, tok)
  val () = if
    synent_is_null (res) then let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_atms0exp)
  end // end of [val]
} // end of [p_atms0exp]

(* ****** ****** *)

(*
apps0exp := {atms0exp}+
*)

fun
p_apps0exp (
  buf: &tokbuf, bt: int, err: &int
) : s0exp = let
  val xs = pplus_fun (buf, bt, p_atms0exp)
  fun loop (
    x0: s0exp, xs1: List_vt (s0exp)
  ) : s0exp =
    case+ xs1 of
    | ~list_vt_cons (x1, xs1) => let
        val x0 = s0exp_app (x0, x1) in loop (x0, xs1)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => x0
  // end of [loop]
in
//
case+ xs of
| ~list_vt_cons (x, xs) => loop (x, xs)
| ~list_vt_nil () => let
    val () = err := err + 1 in synent_null ()
  end // end of [list_vt_nil]
//
end // end of [p_apps0exp]

(* ****** ****** *)

(*
exts0exp := DLREXTYPE LITERAL_string {atms0exp}
*)

fun
p_exts0exp (
  buf: &tokbuf, bt: int, err: &int
) : s0exp = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_DLREXTYPE () => let
    val bt = 0
    val () = incby1 ()
    val str = p_s0tring (buf, bt, err)
  in
    if err = 0 then let
      val arg = pstar_fun (buf, bt, p_atms0exp)
      val arg = list_of_list_vt (arg)
    in
      s0exp_extype (tok, str, arg)
    end else let
      val () = err := err + 1
      val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_s0tring)
    in
      synent_null ()
    end // end of [if]
  end
| _ => let
    val () = err := err + 1
(*
    val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_exts0exp)
*)
  in
    synent_null ()
  end
//
end // end of [p_exts0exp]

(* ****** ****** *)

(*
s0exp
  : apps0exp
  | exts0exp
  | s0exp COLON s0rt
  | LAM s0argseqseq colons0rtopt EQGT s0exp
*)

implement
p_s0exp (
  buf, bt, err
) = let
  var ent: synent?
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
in
//
case+ tok.token_node of
| _ when
    ptest_fun (
      buf, p_apps0exp, ent
    ) => synent_decode {s0exp} (ent)
| _ when
    ptest_fun (
      buf, p_exts0exp, ent
    ) => synent_decode {s0exp} (ent)
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_s0exp)
  in
    synent_null ()
  end
//
end // end of [p_s0exp]

(* ****** ****** *)

(* end of [pats_parsing_s0exp.dats] *)

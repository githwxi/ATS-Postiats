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

staload "./pats_symbol.sats"
staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
#define t2t option_of_option_vt

(* ****** ****** *)

viewtypedef d0explst12 = list12 (d0exp)
viewtypedef labd0explst12 = list12 (labd0exp)

(* ****** ****** *)

fun
d0exp_list12
(
  t_beg: token
, ent2: d0explst12
, t_end: token
) : d0exp =
  case+ ent2 of
  | ~LIST12one (xs) =>
      d0exp_list (t_beg, ~1, (l2l)xs, t_end)
  | ~LIST12two (xs1, xs2) => let
      val npf = list_vt_length (xs1)
      val xs12 = list_vt_append (xs1, xs2)
    in
      d0exp_list (t_beg, npf, (l2l)xs12, t_end)
    end (* end of [LIST12two] *)
// end of [d0exp_list12]

(* ****** ****** *)

fun
d0exp_list12_if
(
  t_beg: token
, ent2: d0explst12
, t_end: token
, err: int, err0: int
) : d0exp =
  if err = err0 then
    d0exp_list12 (t_beg, ent2, t_end)
  else let
    val () = list12_free (ent2) in synent_null ()
  end (* end of [if] *)
// end of [d0exp_list12_if]

(* ****** ****** *)

fun
d0exp_tup12
(
  knd: int
, t_beg: token
, ent2: d0explst12
, t_end: token
) : d0exp = let
in
//
case+ ent2 of
| ~LIST12one (xs) =>
    d0exp_tup (knd, t_beg, ~1, (l2l)xs, t_end)
| ~LIST12two (xs1, xs2) => let
    val npf = list_vt_length (xs1)
    val xs12 = list_vt_append (xs1, xs2)
  in
    d0exp_tup (knd, t_beg, npf, (l2l)xs12, t_end)
  end (* end of [LIST12two] *)
//
end // end of [d0exp_tup12]

(* ****** ****** *)

fun
d0exp_rec12
(
  knd: int
, t_beg: token, ent2: labd0explst12, t_end: token
) : d0exp = let
in
//
case+ ent2 of
| ~LIST12one (xs) =>
    d0exp_rec (knd, t_beg, ~1, (l2l)xs, t_end)
| ~LIST12two (xs1, xs2) => let
    val npf = list_vt_length (xs1)
    val xs12 = list_vt_append (xs1, xs2)
  in
    d0exp_rec (knd, t_beg, npf, (l2l)xs12, t_end)
  end
//
end // end of [d0exp_rec12]

(* ****** ****** *)

fun
p_d0expseq_BAR_d0expseq
(
  buf: &tokbuf, bt: int, err: &int
) : d0explst12 =
  plist12_fun (buf, bt, p_d0exp)
// end of [p_d0expseq_BAR_d0expseq]

fun
p1_d0expseq_BAR_d0expseq
(
  d0e: d0exp
, buf: &tokbuf, bt: int, err: &int
) : d0explst12 =
  p1list12_fun (d0e, buf, bt, p_d0exp)
// end of [p1_d0expseq_BAR_d0expseq]

(* ****** ****** *)

fun
p_labd0expseq_BAR_labd0expseq
(
  buf: &tokbuf, bt: int, err: &int
) : labd0explst12 = let
  val _ = p_COMMA_test (buf) in
  plist12_fun (buf, bt, p_labd0exp)
end // end of [p_labd0expseq_BAR_labd0expseq]

(* ****** ****** *)

(*
di0de
  | IDENTIFIER_alp
  | IDENTIFIER_sym
  | BACKSLASH
  | BANG
  | EQ
  | GT
  | LT
  | TILDE
  | GTLT
*)

implement
p_di0de
  (buf, bt, err) = let
//
val tok =
  tokbuf_get_token(buf)
// end of [val]
val loc = tok.token_loc
macdef incby1() = tokbuf_incby1(buf)
//
in
//
case+
tok.token_node
of // case+
| T_IDENT_alp (x) => let
    val () = incby1 () in i0de_make_string(loc, x)
  end
| T_IDENT_sym (x) => let
    val () = incby1 () in i0de_make_string(loc, x)
  end
//
| T_LT () => let
    val () = incby1 () in i0de_make_sym(loc, symbol_LT)
  end
| T_GT () => let
    val () = incby1 () in i0de_make_sym(loc, symbol_GT)
  end
//
| T_BACKSLASH
    ((*void*)) => let
    val () = incby1 () in i0de_make_sym(loc, symbol_BACKSLASH)
  end
| T_BANG () => let
    val () = incby1 () in i0de_make_sym(loc, symbol_BANG)
  end
| T_EQ () => let // [EQ] is a keyword in the statics
    val () = incby1 () in i0de_make_sym(loc, symbol_EQ)
  end
| T_TILDE () => let
    val () = incby1 () in i0de_make_sym(loc, symbol_TILDE)
  end
//
| T_GTLT () => let
    val () = incby1 () in i0de_make_sym(loc, symbol_GTLT)
  end
//
| _ (*rest*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_di0de)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_di0de]

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
p_d0ynq(buf, bt, err) = let
//
val
err0 = err
//
val n0 =
  tokbuf_get_ntok(buf)
//
val tok =
  tokbuf_get_token(buf)
//
val loc = tok.token_loc
//
var ent: synent? // uninitized
//
macdef incby1() = tokbuf_incby1 (buf)
//
in
//
case+ 0 of
| _ when
    ptest_fun (
    buf, p_i0de_dlr, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{i0de}(ent)
    // end of [val]
    val tok2 = tokbuf_get_token(buf)
  in
    case+
    tok2.token_node
    of // case+
    | T_DOT() => let
        val () = incby1() in d0ynq_symdot(ent1, tok2)
      end
(*
//
// HX-2017-01-24:
// removed due to no use
//
    | T_COLON() => let
        val () = incby1() in d0ynq_symcolon(ent1, tok2)
      end
*)
    | _ (*non-DOT*) =>
        tokbuf_set_ntok_null(buf, n0) where
      {
        val () =
          the_parerrlst_add_ifnbt(bt, loc, PE_d0ynq)
        // end of [val]
      } // end of [non-DOT]
(*
//
// HX-2017-01-24:
// removed due to no use
//
    | _ (*non-DOT-COLON*) => let
        val ent2 =
          p_i0de_dlr(buf, bt, err)
        val ent3 =
          pif_fun(buf, bt, err, p_COLON, err0)
        // end of [val]
      in
        if err = err0
          then
          (
            d0ynq_symdotcolon(ent1, ent2, ent3)
          ) (* end of [then] *)
          else let
            val () =
              the_parerrlst_add_ifnbt(bt, loc, PE_d0ynq)
            // end of [val]
          in
            tokbuf_set_ntok_null(buf, n0)
          end // end of [else]
        // end of [if]
      end // end of [non-DOT-COLON]
*)
  end (* end of [_ when ...] *)
//
| _ (*rest-of-tokens*) =>
    synent_null((*void*)) where
  {
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt(bt, loc, PE_d0ynq)
  } (* end of [rest-of-tokens] *)
//
end // end of [p_d0ynq]

(* ****** ****** *)

fun
pqi0de_fun (
  buf: &tokbuf
, bt: int, err: &int
, f: parser (i0de)
, enode: parerr_node
) : dqi0de = let
//
val
err0 = err
//
val n0 =
  tokbuf_get_ntok(buf)
//
val tok =
  tokbuf_get_token (buf)
//
val loc = tok.token_loc
//
var ent: synent? // uninitized
//
in
//
case+ 0 of
| _ when
    ptest_fun (buf, f, ent) =>
    dqi0de_make_none(synent_decode{i0de}(ent))
| _ when
    ptest_fun(buf, p_d0ynq, ent) => let
    // val bt = 0 // HX: avoiding false positive
    val ent1 = synent_decode{d0ynq}(ent)
    val ent2 = f(buf, bt, err) // HX: err = err0
  in
    if err = err0
      then dqi0de_make_some(ent1, ent2)
      else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end
| _ (*rest*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, enode)
  in
    synent_null ()
  end
//
end // end of [pqi0de_fun]

(*
dqi0de ::= di0de | d0ynq di0de
*)
implement
p_dqi0de (buf, bt, err) =
  pqi0de_fun (buf, bt, err, p_di0de, PE_dqi0de)
// end of [p_dqi0de]

(* ****** ****** *)

fun
p_arri0de (
  buf: &tokbuf, bt: int, err: &int
) : i0de = let
  val tok = tokbuf_get_token (buf)
in
//
case+ tok.token_node of
| T_IDENT_arr (name) => let
    val () = tokbuf_incby1 (buf) in
    i0de_make_string (tok.token_loc, name)
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_arri0de]

implement
p_arrqi0de (buf, bt, err) =
  pqi0de_fun (buf, bt, err, p_arri0de, PE_arrqi0de)
// end of [p_arrqi0de]

(* ****** ****** *)

fun
p_tmpi0de (
  buf: &tokbuf, bt: int, err: &int
) : i0de = let
  val tok = tokbuf_get_token (buf)
in
//
case+ tok.token_node of
| T_IDENT_tmp (name) => let
    val () = tokbuf_incby1 (buf) in
    i0de_make_string (tok.token_loc, name)
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_tmpi0de]

implement
p_tmpqi0de (buf, bt, err) =
  pqi0de_fun (buf, bt, err, p_tmpi0de, PE_tmpqi0de)
// end of [p_tmpqi0de]

(* ****** ****** *)

(*
labd0exp ::= l0ab EQ d0exp
*)
implement
p_labd0exp
(
  buf, bt, err
) = let
  val err0 = err
  val tok = tokbuf_get_token (buf)
  val+~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun{l0ab,token,d0exp}(buf, bt, err, p_l0ab, p_EQ, p_d0exp)
  (* end of [val] *)
in
//
if (err = err0) then
  labd0exp_make (ent1, ent3)
else let
  val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_labd0exp)
in
  synent_null ((*okay*))
end (* end of [if] *)
//
end // end of [p_labd0exp]

(* ****** ****** *)

(*
eqd0expopt :: = [EQ d0exp]
*)
implement
p_eqd0expopt
  (buf, bt, err) =
  t2t (ptokentopt_fun (buf, is_EQ, p_d0exp))
// end of [p_eqd0expopt]

(* ****** ****** *)

(*
d0expsemiseq =
  | d0exp {SEMICOLON d0exp}* {SEMICOLON}*
  | /*empty*/
*)
implement
p_d0expsemiseq
  (buf, bt, err) = let
  val err0 = err
  val x = p_d0exp (buf, 1(*bt*), err) // HX: optional
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
if
err = err0
then let
  val tok = tokbuf_get_token (buf)
in
//
case+
tok.token_node of
| T_SEMICOLON () => let
    val () = incby1 ()
    val xs = p_d0expsemiseq (buf, 1(*bt*), err)
  in
    list_cons (x, xs)
  end
| _ (*non-SEMICOLON*) => list_sing (x)
//
end // end of [then]
else let
  val () = err := err0
  val semilst = pstar_fun (buf, bt, p_SEMICOLON)
  val () = list_vt_free (semilst)
in
  list_nil ()
end // end of [else]
//
end // end of [p_d0expsemiseq]

(* ****** ****** *)

(*
s0expelt ::=
| LBRACE s0exp RBRACE
| LBRACKET s0exp RBRACKET
| /* empty*/
*)
fun
p_s0expelt
(
  buf: &tokbuf, bt: int, err: &int
) : s0expopt = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_LBRACE () => let // HX-2011-04-04: deprecated?
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0 then
      Some (ent2) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| T_LBRACKET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACKET, err0)
  in
    if err = err0 then
      Some (ent2) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| _ => None () // HX: there is no error
end // end of [p_s0expelt]

(* ****** ****** *)

(*
arrdimopt ::= /*empty*/ | LBRACKET d0exp LBRACKET
*)
fun
p_arrdimopt
(
  buf: &tokbuf, bt: int, err: &int
) : d0expopt = let
  val bt = 1 // HX: this is optional
  val err0 = err
  val+~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {token,d0exp,token} (buf, bt, err, p_LBRACKET, p_d0exp, p_RBRACKET)
  // end of [val]
in
  if err = err0 then Some (ent2) else (err := err0; None ())
end // end of [p_arrdimopt]

(* ****** ****** *)

(*
d0arrind ::= d0expcommaseq RBRACKET [LBRACKET d0arrind]
*)
fun
p_d0arrind
(
  buf: &tokbuf, bt: int, err: &int
) : d0arrind = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
//
  val ent1 = pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp)
  val ent2 = p_RBRACKET (buf, bt, err) // err = err0
//
in
//
if err = err0 then let
  val bt = 0
  val tok = tokbuf_get_token (buf)
in
  case+ tok.token_node of
  | T_LBRACKET () => let
      val () = incby1 ()
      val ent4 = p_d0arrind (buf, bt, err)
    in
      if err = err0 then
        d0arrind_cons ((l2l)ent1, ent4) else let
        val () = list_vt_free (ent1) in tokbuf_set_ntok_null (buf, n0)
      end // end of [if]
    end
  | _ => d0arrind_sing ((l2l)ent1, ent2)
end else let
  val () = list_vt_free (ent1) in tokbuf_set_ntok_null (buf, n0)
end (* end of [if] *)
//
end // end of [p_d0arrind]

(* ****** ****** *)

(*
s0elop ::= DOT | MINUSGT
*)
fun
p_s0elop
(
  buf: &tokbuf, bt: int, err: &int
) : s0elop = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_DOT () => let
    val () = incby1 () in s0elop_make_dot (tok)
  end
| T_MINUSGT () => let
    val () = incby1 () in s0elop_make_minusgt (tok)
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_s0elop]

(* ****** ****** *)

(*
s0expdarg ::= LBRACE s0exparg RBRACE
*)
fun
p_s0expdarg (
  buf: &tokbuf, bt: int, err: &int
) : d0exp = let
  val err0 = err
  typedef a1 = token and a2 = s0exparg and a3 = token
  val+~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {a1,a2,a3} (buf, bt, err, p_LBRACE, p_s0exparg, p_RBRACE)
  // end of [val]
in
  if err = err0 then
    d0exp_sexparg (ent1, ent2, ent3) else synent_null ((*okay*))
  // end of [if]
end // end of [p_s0expdarg]

(* ****** ****** *)

(*
atmd0exp ::=
  | dqi0de
  | OP di0de
  | i0nt
  | s0tring
  | c0har
  | f0loat
  | #FILENAME | #LOCATION
  | BREAK | CONTINUE
  | LABEL
//
  | DLREXTVAL
    LPAREN s0exp COMMA s0tring RPAREN
  | DLREXTFALL
    LPAREN s0exp COMMA s0tring commad0expseq RPAREN
//
  | LPAREN d0exp SEMICOLON d0expsemiseq RPAREN
  | LPAREN d0expcommaseq [BAR d0expcommaseq] RPAREN
//
  | ATLPAREN
    d0expcommaseq [BAR d0expcommaseq] RPAREN
  | QUOTELPAREN
    d0expcommaseq [BAR d0expcommaseq] RPAREN
//
  | ATLBRACE labd0expseq [BAR labd0expseq] RBRACE
  | QUOTELBRACE labd0expseq [BAR labde0xpseq] RBRACE
//
  | ATLBRACKET s0exp RBRACKET
    arrdimopt LPAREN d0expcommaseq RPAREN
  | HASHLBRACKET s0exparg BAR d0exp RBRACKET
  | QUOTELBRACKET d0expcommaseq RBRACKET
//
  | arrqi0de d0arrind
//
  | DLRARRPSZ s0expelt LPAREN d0expcommaseq RPAREN
//
  | BEGIN d0expsemiseq END
//
  | LET d0ecseq_dyn IN d0expsemiseq END
  | LBRACE d0ecseq_dyn RBRACE
//
  | COMMALPAREN d0exp RPAREN // macsyn_decode
  | BQUOTELPAREN d0expsemiseq RPAREN // macsyn_encode_seq
  | PERCENTLPAREN d0exp RPAREN // macsyn_cross
//
*)

fun
p_atmd0exp (
  buf: &tokbuf, bt: int, err: &int
) : d0exp =
(
  ptokwrap_fun
    (buf, bt, err, p_atmd0exp_tok, PE_atmd0exp)
) (* end of [p_atmd0exp] *)

and
p_atmd0exp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0exp = let
//
val err0 = err
var ent: synent?
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+ tok.token_node of
//
| _ when
    ptest_fun (buf, p_di0de, ent) =>
    d0exp_ide (synent_decode{i0de}(ent))
| _ when
    ptest_fun (buf, p_i0dext, ent) =>
    d0exp_idext (synent_decode{i0de}(ent))
//
| T_INT _ => let
    val () = incby1 () in d0exp_i0nt (tok)
  end
| T_CHAR _ => let
    val () = incby1 () in d0exp_c0har (tok)
  end
| T_FLOAT _ => let
    val () = incby1 () in d0exp_f0loat (tok)
  end
| T_STRING _ => let
    val () = incby1 () in d0exp_s0tring (tok)
  end
//
| T_OP _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_di0de (buf, bt, err)
  in
    if err = err0 then
      d0exp_opid (tok, ent2) else synent_null ()
    // end of [if]
  end
| _ when
    ptest_fun (buf, p_dqi0de, ent) =>
    d0exp_dqid (synent_decode{dqi0de}(ent))
//
| T_DLRMYFILENAME
    ((*void*)) => let
    val () = incby1 () in d0exp_MYFIL (tok)
  end
| T_DLRMYLOCATION
    ((*void*)) => let
    val () = incby1 () in d0exp_MYLOC (tok)
  end
| T_DLRMYFUNCTION
    ((*void*)) => let
    val () = incby1 () in d0exp_MYFUN (tok)
  end
//
| T_DLRTYREP() => let
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_s0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_tyrep(tok, ent3, ent4) else synent_null()
    // end of [if]
  end // end of [T_DLRTYREP]
//
| T_DLRLITERAL
    ((*void*)) => let
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_literal (tok, ent3, ent4) else synent_null ()
    // end of [if]
  end // end of [T_DLRLITERAL]
//
| _ when
    ptest_fun (
    buf, p_s0elop, ent // s0elop ::= DOT | MINUSGT
  ) => let
    val bt = 0
    val ent1 =
      synent_decode {s0elop} (ent)
    // end of [val]
    val tok2 = tokbuf_get_token (buf)
  in
    case+
      tok2.token_node of
    | T_LBRACKET () => let
        val () = incby1 ()
        val ent2 = p_d0arrind (buf, bt, err)
      in
        if err = err0 then
          d0exp_sel_ind (ent1, ent2) else synent_null ()
        // end of [if]
      end // end of [T_LBRACKET]
    | _ when
        ptest_fun (
        buf, p_l0ab, ent
      ) => let
        val ent2 =
          synent_decode {l0ab} (ent) in d0exp_sel_lab (ent1, ent2)
        // end of [val]
      end // end of [when ...]
    | _ (*rest*) => let
        val () = err := err + 1 in synent_null((*dangling [s0elop]*))
      end // end of [_]
  end // end of [p_s0elop]
//
| T_DOTINT _ => let
    val () = incby1 () in d0exp_sel_int (tok)
  end // end of [T_DOTINT]
//
| T_ADDRAT () => let
    val () = incby1 () in d0exp_ptrof (tok)
  end
| T_VIEWAT () => let
    val () = incby1 () in d0exp_viewat (tok)
  end
| T_FOLDAT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun (buf, bt, p_s0expdarg)
  in
    d0exp_foldat (tok, (l2l)ent2) // HX: there is no failure
  end
| T_FREEAT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun (buf, bt, p_s0expdarg)
  in
    d0exp_freeat (tok, (l2l)ent2) // HX: there is no failure
  end
//
| _ when
    ptest_fun (
    buf, p_tmpqi0de, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode{dqi0de}(ent)
    val ent2 = pstar_fun1_sep{t0mpmarg}(buf, bt, err, p_tmps0expseq, p_GTLT_test)
    val ent3 = pif_fun (buf, bt, err, p_GT, err0)
  in
    if err = err0
      then let
        val ent2 = (l2l)ent2
      in
        d0exp_tmpid (ent1, ent2, ent3)
      end // end of [then]
      else let
        val () = list_vt_free(ent2) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end
//
| T_DLREXTVAL() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_s0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent5 = pif_fun (buf, bt, err, p_s0tring, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0 then
      d0exp_extval(tok, ent3, ent5, ent6) else synent_null()
    // end of [if]
  end
//
| T_DLREXTFCALL
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_s0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent5 = pif_fun (buf, bt, err, p_s0tring, err0)
    val ent6 = pstar_COMMA_fun {d0exp} (buf, bt, p_d0exp)
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val okay = (if err = err0 then true else false): bool
  in
    if okay
      then let
        val ent6 = (l2l)ent6
      in
        d0exp_extfcall(tok, ent3, ent5, ent6, ent7)
      end // end of [then]
      else let // HX: err > err0
        val () = list_vt_free(ent6) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end // end of [T_DLREXTFCALL]
//
| T_DLREXTMCALL
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_s0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent5 = pif_fun (buf, bt, err, p_d0exp, err0)
    val ent6 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent7 = pif_fun (buf, bt, err, p_s0tring, err0)
    val ent8 = pstar_COMMA_fun {d0exp} (buf, bt, p_d0exp)
    val ent9 = pif_fun (buf, bt, err, p_RPAREN, err0)
    val okay = (if err = err0 then true else false): bool
  in
    if okay
      then let
        val ent8 = (l2l)ent8
      in
        d0exp_extmcall (tok, ent3, ent5, ent7, ent8, ent9)
      end // end of [then]
      else let // HX: err > err0
        val () = list_vt_free (ent8) in synent_null ((*void*))
      end // end of [else]
    // end of [if]
  end // end of [T_DLREXTMCALL]
//
| T_LPAREN () => let
    val () = incby1 ()
    val d0e =
      p_d0exp (buf, 1(*bt*), err) // HX: may backtrack!
    // end of [val]
  in
    if err = err0
      then let
        val bt = 0
        val tok2 = tokbuf_get_token(buf)
      in
        case+
        tok2.token_node
        of // case+
        | T_SEMICOLON() => let
            val () = incby1 ()
            val d0es = p_d0expsemiseq(buf, bt, err)
            val ent3 = p_RPAREN(buf, bt, err) // err=err0
          in
            if err = err0
              then d0exp_seq(tok, list_cons(d0e, d0es), ent3)
              else synent_null()
            // end of [if]
          end
        | _ (*non-SEMICOLON*) => let
            val ent2 =
              p1_d0expseq_BAR_d0expseq(d0e, buf, bt, err)
            // end of [val]
            val ent3 = p_RPAREN(buf, bt, err) // HX: err = err0
          in
            d0exp_list12_if (tok, ent2, ent3, err, err0)
          end
      end // end of [then]
      else let
        val bt = 0
        val () = err := err0
        val ent2 = p_d0expseq_BAR_d0expseq(buf, bt, err)
        val ent3 = p_RPAREN(buf, bt, err) // HX: err=err0
      in
        d0exp_list12_if (tok, ent2, ent3, err, err0)
      end // end of [else]
    // end of [if]
  end // end of [let] // end of [T_LPAREN]
//
| tnd when
    is_LPAREN_deco (tnd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      p_d0expseq_BAR_d0expseq (buf, bt, err)
    // end of [val]
    val ent3 = p_RPAREN (buf, bt, err) // err=err0
  in
    if err = err0
      then let
        val knd =
          (if is_ATLPAREN(tnd) then 0 else 1): int
        // end of [val]
      in
        d0exp_tup12 (knd, tok, ent2, ent3)
      end // end of [then]
      else let
        val () = list12_free(ent2) in synent_null()
      end // end of [else]
    // end of [if]
  end
| tnd when
    is_LBRACE_deco (tnd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      p_labd0expseq_BAR_labd0expseq(buf, bt, err)
    // end of [val]
    val ent3 = p_RBRACE (buf, bt, err) // err=err0
  in
    if err = err0
      then let
        val knd =
          (if is_ATLBRACE (tnd) then 0 else 1): int
        // end of [val]
      in
        d0exp_rec12 (knd, tok, ent2, ent3)
      end // end of [then]
      else let
        val () = list12_free(ent2) in synent_null()
      end // end of [else]
    // end of [if]
  end
//
(*
| ATLBRACKET s0exp RBRACKET
  arrdimopt LPAREN d0expcommaseq RPAREN
*)
| T_ATLBRACKET
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACKET, err0)
    val ent4 = (
      if err = err0 then p_arrdimopt (buf, bt, err) else None ()
    ) : d0expopt
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = (
      if err = err0
        then pstar_fun0_COMMA{d0exp}(buf, bt, p_d0exp)
        else list_vt_nil ((*void*))
      // end of [if]
    ) : d0explst_vt
    val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0 then
      d0exp_arrinit (tok, ent2, ent4, (l2l)ent6, ent7)
    else let
      val () = list_vt_free (ent6) in synent_null ()
    end (* end of [if] *)
  end
//
(*
| HASHLBRACKET
  s0exparg BAR d0exp RBRACKET
*)
| T_HASHLBRACKET
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exparg (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_BAR, err0)
    val ent4 = pif_fun (buf, bt, err, p_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_RBRACKET, err0)
  in
    if err = err0
      then d0exp_exist(tok, ent2, ent3, ent4, ent5)
      else synent_null()
    // end of [if]
  end
//
(*
| QUOTELBRACKET d0expseq RBRACKET
*)
| T_QUOTELBRACKET
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun0_COMMA{d0exp}(buf, bt, p_d0exp)
    // end of [val]
    val ent3 = p_RBRACKET(buf, bt, err)
  in
    if err = err0
      then d0exp_lst_quote(tok, (l2l)ent2, ent3)
      else let
        val () = list_vt_free(ent2) in synent_null()
      end // end of [else]
    // end of [if]
  end
//
| _ when
    ptest_fun (
    buf, p_arrqi0de, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {dqi0de} (ent)
    val ent2 = p_d0arrind (buf, bt, err) // err = err0
  in
    if err = err0 then
      d0exp_arrsub (ent1, ent2) else synent_null ()
    // end of [if]
  end
//
| T_DLRARRPSZ
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expelt (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent4 = (
      if err = err0
        then pstar_fun0_COMMA{d0exp}(buf, bt, p_d0exp)
        else list_vt_nil((*void*))
      // end of [if]
    ) : d0explst_vt // end of [val]
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then let
        val ent4 = (l2l)ent4
      in
        d0exp_arrpsz(tok, ent2, ent3, ent4, ent5)
      end // end of [then]
      else let
        val () = list_vt_free(ent4) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end
//
| T_DLRLST(lin) => let
    val bt = 0
    val () = incby1()
    val ent2 = p_s0expelt(buf, bt, err)
    val ent3 = pif_fun(buf, bt, err, p_LPAREN, err0)
    val ent4 =
    (
      if err = err0
        then pstar_fun0_COMMA{d0exp}(buf, bt, p_d0exp)
        else list_vt_nil((*void*))
      // end of [if]
    ) : d0explst_vt // end of [val]
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then let
        val ent4 = (l2l)ent4
      in
        d0exp_lst(lin, tok, ent2, ent3, ent4, ent5)
      end // end of [then]
      else let
        val () = list_vt_free(ent4) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end
| T_DLRTUP(knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN(buf, bt, err) // err = err0
    val ent3 = p_d0expseq_BAR_d0expseq(buf, bt, err)
    val ent4 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_tup12(knd, tok, ent3, ent4)
      else let
        val () = list12_free(ent3) in synent_null()
      end // end of [else]
  end
| T_DLRREC(knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LBRACE (buf, bt, err) // err = err0
    val ent3 = p_labd0expseq_BAR_labd0expseq(buf, bt, err)
    val ent4 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0
      then d0exp_rec12 (knd, tok, ent3, ent4)
      else let
        val () = list12_free (ent3) in synent_null ()
      end // end of [else]
    // end of [if]
  end
//
| T_BEGIN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0expsemiseq (buf, bt, err)
    val ent3 = p_END (buf, bt, err) // err = err0
  in
    if err = err0
      then d0exp_seq(tok, ent2, ent3) else synent_null()
    // end of [if]
  end
//
| T_LET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_dyn (buf, bt, err)
    val ent3 = p_IN (buf, bt, err) // err= err0
    val ent4 = pif_fun (buf, bt, err, p_d0expsemiseq, err0)
    val ent5 = pif_fun (buf, bt, err, p_END, err0)
  in
    if err = err0
      then d0exp_let_seq (tok, ent2, ent3, ent4, ent5)
      else synent_null()
    // end of [if]
  end
| T_LBRACE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_dyn (buf, bt, err)
    val ent3 = p_RBRACE (buf, bt, err) // err = err0
  in
    if err = err0
      then d0exp_declseq(tok, ent2, ent3) else synent_null()
    // end of [if]
  end
//
| T_COMMALPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_macsyn_decode(tok, ent2, ent3) else synent_null()
    // end of [if]
  end
| T_BQUOTELPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0expsemiseq (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_macsyn_encode_seq(tok, ent2, ent3) else synent_null()
    // end of [if]
  end
| T_PERCENTLPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0exp_macsyn_cross(tok, ent2, ent3) else synent_null()
    // end of [if]
  end
//
| _ (*rest-of-tokens*) => let
    val () = err := err + 1 in synent_null((*error*))
  end
// (* end of [case] *)
end // end of [p_atmd0exp_tok]

(* ****** ****** *)

(*
argd0exp ::= s0expdarg | atmd0exp
*)

fun
p_argd0exp (
  buf: &tokbuf, bt: int, err: &int
) : d0exp = let
  var ent: synent?
in
//
case+ 0 of
| _ when
    ptest_fun (
    buf, p_s0expdarg, ent
  ) => synent_decode {d0exp} (ent)
| _ when
    ptest_fun (
    buf, p_atmd0exp, ent
  ) => synent_decode {d0exp} (ent)
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_argd0exp]

(* ****** ****** *)

(*
d0exp0 ::=
| atmd0exp argd0expseq [COLON s0exp]
| break | continue
| $showtype d0exp
| $vcopyenv_v d0exp
| $vcopyenv_vt d0exp
| $tempenver d0exp
| $solassert d0exp
| $solverify s0exp
*)
fun
p_d0exp0
(
  buf: &tokbuf, bt: int, err: &int
) : d0exp = let
//
  val err0 = err
  var ent: synent?
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
| _ when
    ptest_fun (
    buf, p_atmd0exp, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{d0exp}(ent)
    // end of [val]
    val ent2 =
      pstar_fun{d0exp}(buf, bt, p_argd0exp)
    // end of [val]
    val ent3 = p_colons0expopt(buf, bt, err) // err = err0
//
    fun loop
    (
      x0: d0exp, xs: d0explst_vt
    ) : d0exp =
      case+ xs of
      | ~list_vt_nil() => x0
      | ~list_vt_cons(x, xs) => let
          val x0 = d0exp_app(x0, x) in loop(x0, xs)
        end // end of [list_vt_cons]
    // end of [loop]
    val d0e = loop (ent1, ent2)
  in
    case+ ent3 of
    | Some s0e => d0exp_ann(d0e, s0e) | None() => d0e
  end
//
| T_DLRBREAK() => let
    val () = incby1 () in d0exp_loopexn (0(*knd*), tok)
  end // end of [T_DLRBREAK]
| T_DLRCONTINUE() => let
    val () = incby1 () in d0exp_loopexn (1(*knd*), tok)
  end // end of [T_DLRCONTINUE]
//
| T_DLRVARARG() => let
//
    val bt = 0
    val () = incby1()
//
    val ent2 =
      p_LPAREN(buf, bt, err) // err = err0
    val ent3 =
      pstar_fun0_COMMA{d0exp}(buf, bt, p_d0exp)
//
    val ent4 = pif_fun(buf, bt, err, p_RPAREN, err0)
//
  in
    if err = err0
      then let
        val ent3 = (l2l)ent3
      in
        d0exp_vararg(tok, ent3, ent4)
      end // end of [then]
      else let
        val () = list_vt_free(ent3) in tokbuf_set_ntok_null(buf, n0)
      end // end of [else]
    (* end of [if] *)
  end
//
| T_DLRVCOPYENV(knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err = err0
      then d0exp_vcopyenv (knd, tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| T_DLRSHOWTYPE() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err = err0 then
      d0exp_showtype (tok, ent2) else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| T_DLRTEMPENVER() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err = err0
      then d0exp_tempenver (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| T_DLRSOLASSERT() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_atmd0exp (buf, bt, err)
  in
    if err = err0
      then d0exp_solassert (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
| T_DLRSOLVERIFY() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_atms0exp (buf, bt, err)
  in
    if err = err0
      then d0exp_solverify (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| _ (* rest-of-tokens *) => let
    val tok =
      tokbuf_get_token(buf)
    val loc = tok.token_loc
    val ((*void*)) = err := err + 1
    val ((*void*)) = the_parerrlst_add_ifnbt (bt, loc, PE_d0exp0)
  in
    synent_null ()
  end
end // end of [p_d0exp0]

(* ****** ****** *)

(*
d0exp1 ::=
  | d0exp0 {d0exp1}*
  | DLRRAISE d0exp0 // done!
  | DLREFFMASK d0exp0 // done!
  | DLREFFMASK_ARG d0exp0 // done!
  | DLRDELAY d0exp0 // done!
*)
fun
p_d0exp1
(
  buf: &tokbuf, bt: int, err: &int
) : d0exp = let
  val err0 = err
  var ent: synent?
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node
of // case+
| _ when
    ptest_fun (
    buf, p_d0exp0, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {d0exp} (ent)
    val ent2 = pstar_fun {d0exp} (buf, bt, p_d0exp1)
    fun loop (
      x0: d0exp, xs: d0explst_vt
    ) : d0exp =
      case+ xs of
      | ~list_vt_cons (x, xs) => let
          val x0 = d0exp_app (x0, x) in loop (x0, xs)
        end
      | ~list_vt_nil () => x0
    // end of [loop]
  in
    loop (ent1, ent2)
  end
//
| T_DLRDELAY(knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err = err0
      then d0exp_delay (knd, tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| T_DLRRAISE() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err = err0
      then d0exp_raise (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| T_DLREFFMASK() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pif_fun (buf, bt, err, p_LBRACE, err0)
    val ent3 = pif_fun (buf, bt, err, p_e0fftaglst, err0)
    val ent4 = pif_fun (buf, bt, err, p_RBRACE, err0)
    val ent5 = pif_fun (buf, bt, err, p_d0exp1, err0)
  in
    if err = err0
      then d0exp_effmask (tok, ent3, ent5)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
| T_DLREFFMASK_ARG(knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp0 (buf, bt, err)
  in
    if err=err0
      then d0exp_effmask_arg (knd, tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    (* end of [if] *)
  end
//
| _ (*rest-of-tokens*) => let
    val loc = tok.token_loc
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_d0exp1)
  in
    synent_null ()
  end
end // end of [p_d0exp1]

(* ****** ****** *)

(*
i0nvarg ::= di0de COLON [s0exp]
*)
fun
p_i0nvarg
(
  buf: &tokbuf, bt: int, err: &int
) : i0nvarg = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
//
val ent1 = p_di0de (buf, bt, err)
//
val bt = 0
val ent2 =
  pif_fun (buf, bt, err, p_COLON, err0)
val ent3 = let
  val s0e =
    pif_fun{s0exp}(buf, bt, err, p_s0exp, err0)
  // end of [val]
in
  if err = err0 then Some(s0e) else None()
end : s0expopt // end of [val]
//
in
  if err = err0
    then i0nvarg_make (ent1, ent3)
    else tokbuf_set_ntok_null (buf, n0)
  // end of [if]
end // end of [p_i0nvarg]

fun
p_i0nvargseq
(
  buf: &tokbuf, bt: int, err: &int
) : i0nvarglst =
  l2l (pstar_fun0_COMMA (buf, bt, p_i0nvarg))
// end of [p_i0nvargseq]

(* ****** ****** *)
//
(*
i0nvqua :: /*(empty)*/ | LBRACE s0quaseq RBRACE
*)
fun
p_i0nvqua
(
  buf: &tokbuf, bt: int, err: &int
) : Option (s0qualst) = let
//
val bt = 1
val err0 = err
//
typedef a1 = token
typedef a2 = s0qualst
typedef a3 = token
//
val+~SYNENT3
  (ent1, ent2, ent3) =
  pseq3_fun{a1,a2,a3}
    (buf, bt, err, p_LBRACE, p_s0quaseq, p_RBRACE)
  // end of [pseq3_fun]
in
  if err = err0 then Some(ent2) else (err := err0; None())
end // end of [p_i0nvqua]
//
(*
i0nvresqua ::= /*(empty)*/ | LBRACKET s0quaseq RBRACKET
*)
fun p_i0nvresqua
(
  buf: &tokbuf, bt: int, err: &int
) : Option (s0qualst) = let
//
val bt = 1
val err0 = err
//
typedef a1 = token
typedef a2 = s0qualst
typedef a3 = token
//
val+~SYNENT3
  (ent1, ent2, ent3) =
  pseq3_fun{a1,a2,a3}
    (buf, bt, err, p_LBRACKET, p_s0quaseq, p_RBRACKET)
  // end of [pseq3_fun]
in
  if err = err0 then Some(ent2) else (err := err0; None())
end // end of [p_i0nvresqua]
//
(* ****** ****** *)

(*
i0nvmet ::= /*(empty)*/ | DOTLTGTDOT | DOTLT s0expseq GTDOT
*)
fun p_i0nvmet
(
  buf: &tokbuf, bt: int, err: &int
) : s0explstopt = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
| T_DOTLT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun0_COMMA{s0exp}(buf, bt, p_s0exp)
    // end of [val]
    val ent3 = p_GTDOT (buf, bt, err) // err = err0
  in
    if err = err0
      then Some ((l2l)ent2)
      else let
        val () = list_vt_free(ent2) in tokbuf_set_ntok_null(buf, n0)
      end (* end of [else] *)
  end
| T_DOTLTGTDOT () => let
    val () = incby1 () in Some (list_nil)
  end // end of [T_DOTLTGTDOT]
| _ (*rest-of-tokens*) => None () // HX: there is no error
//
end // end of [p_i0nvmet]

(* ****** ****** *)
//
(*
i0nvargstate ::= LPAREN i0nvargseq RPAREN
*)
fun
p_i0nvargstate
(
  buf: &tokbuf, bt: int, err: &int
) : i0nvarglst = let
//
val err0 = err
//
typedef a1 = token
typedef a2 = i0nvarglst
typedef a3 = token
//
val+~SYNENT3
  (ent1, ent2, ent3) =
  pseq3_fun{a1,a2,a3}
    (buf, bt, err, p_LPAREN, p_i0nvargseq, p_RPAREN)
  // end of [pseq3_fun]
//
in
  if err = err0 then ent2 else synent_null((*void*))
end // end of [p_i0nvargstate]
//
(*
i0nvresstate ::= COLON i0nvresqua LPAREN i0nvargseq RPAREN
*)
fun
p_i0nvresstate
(
  buf: &tokbuf, bt: int, err: &int
) : i0nvresstate = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
| T_COLON () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0nvresqua (buf, bt, err)
    typedef a1 = token and a2 = i0nvarglst and a3 = token
    val+~SYNENT3 (ent3, ent4, ent5) =
      pseq3_fun{a1,a2,a3}(buf, bt, err, p_LPAREN, p_i0nvargseq, p_RPAREN)
    // end of [val]
  in
    if err = err0
      then (
        i0nvresstate_make_some (tok, ent2, ent4, ent5)
      ) else tokbuf_set_ntok_null (buf, n0)
  end
| _ (*non-COLON*) =>
    let val () = err := err + 1 in synent_null() end
//
end // end of [p_i0nvresstate]
//
fun
p_i0nvresstateopt
(
  buf: &tokbuf, bt: int, err: &int
) : i0nvresstate = let
  val err0 = err
  val tok = tokbuf_get_token (buf)
  val ent = p_i0nvresstate (buf, 1(*bt*), err) // HX: optional
in
  if err = err0 then ent else let
    val () = err := err0 in i0nvresstate_make_none (tok.token_loc)
  end (* end of [if] *)
end // end of [p_i0nvresstateopt]
//
(* ****** ****** *)
//
(*
loopi0nv ::= i0nvqua i0nvmet i0nvargstate i0nvresstateopt
*)
//
fun
p_loopi0nv
(
  buf: &tokbuf, bt: int, err: &int  
) : loopi0nv = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
//
val ent1 = p_i0nvqua (buf, bt, err)
val ent2 = pif_fun (buf, bt, err, p_i0nvmet, err0)
val ent3 = pif_fun (buf, bt, err, p_i0nvargstate, err0)
val ent4 = pif_fun (buf, bt, err, p_i0nvresstateopt, err0)
//
in
//
if
err = err0
then loopi0nv_make(ent1, ent2, ent3, ent4)
else tokbuf_set_ntok_null(buf, n0)
//
end // end of [loopi0nv]
//
(* ****** ****** *)

(*
funarrow ::= EQGT | EQLTGT | EQLT e0fftagseq GT
*)
fun
p_funarrow (
  buf: &tokbuf, bt: int, err: &int
) : e0fftaglstopt = let
//
val err0 = err
//
val n0 =
  tokbuf_get_ntok(buf)
//
val tok =
  tokbuf_get_token(buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
| T_EQGT () => let
    val () = incby1 () in None ()
  end
| T_EQLTGT () => let
    val () = incby1 () in Some (list_nil)
  end
| T_EQLT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0fftaglst (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_GT, err0)
  in
    if err = err0
      then Some(ent2) else tokbuf_set_ntok_null(buf, n0)
    // end of [if]
  end
| _ (*rest*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt(bt, loc, PE_funarrow)
  in
    synent_null((*void*))
  end // end of [_]
//
end // end of [p_funarrow]

(* ****** ****** *)
//
(*
pstar_where for
{ where LBRACE d0eclseq_dyn RBRACE }*
*)
//
fun
pstar_where
(
  d0e: d0exp
, buf: &tokbuf, bt: int, err: &int
) : d0exp = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok(buf)
val tok = tokbuf_get_token(buf)
//
macdef incby1() = tokbuf_incby1(buf)
//
in
//
case+
tok.token_node
of // case+
| T_WHERE() => let
    val bt = 0
    val () = incby1()
    val tok2 = tokbuf_get_token(buf)
    typedef a2 = d0eclist and a3 = token
  in
    case+
    tok2.token_node
    of // case+
    | T_LBRACE() => let
//
        val () = incby1()
//
        val+
        ~SYNENT2
        (ent2, ent3) =
        pseq2_fun{a2,a3}
          (buf, bt, err, p_d0eclseq_dyn, p_RBRACE)
        // end of [val]   
//
      in
        if
        (err = err0)
        then let
          val d0e =
            d0exp_where(d0e, ent2, ent3)
          // end of [val]
        in
          pstar_where(d0e, buf, bt, err)
        end // end of [then]
        else tokbuf_set_ntok_null(buf, n0)
      end // end of [T_LBRACE]
    | _(*non-LBRACE*) => let
//
        val+
        ~SYNENT2
        (ent2, ent3) =
        pseq2_fun{a2,a3}(buf, bt, err, p_d0eclseq_dyn, p_END)
//
      in
        if
        (err = err0) then let
          val d0e =
            d0exp_where(d0e, ent2, ent3)
          // end of [val]
        in
          pstar_where(d0e, buf, bt, err)
        end // end of [then]
        else tokbuf_set_ntok_null(buf, n0)
      end // end of [non-LBRACE]
  end // end of [T_WHERE]
| _ (*non-WHERE*) => d0e // HX: it is not a where-clause
//
end // end of [pstar_where]

(* ****** ****** *)

fun
ptokhead_fun
(
  buf: &tokbuf
, bt: int
, err: &int
, f: (tnode) -> bool
, tokres: &token? >> token
) : Option (i0nvresstate) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val () = tokres := tok
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
if
f(tok.token_node)
then let
  val () = incby1 ()
  val ent2 =
    p_i0nvresstate(buf, 1(*bt*), err)
  // end of [val]
in
  if err = err0
    then let
      val ent3 = p_EQGT(buf, 0(*bt*), err)
    in
      if err = err0
        then Some(ent2)
        else tokbuf_set_ntok_null(buf, n0)
      // end of [if]
    end // end of [then]
    else let
      val () = err := err0 in None () // errless
    end // end of [else]
  // end of [if]
end // end of [then]
else let
  val () = err := err + 1 in synent_null()
end // end of [else]
//
end // end of [ptokhead_fun]

(* ****** ****** *)

(*
ifhead: IF [i0nvresstate EQGT]
*)
fun
p_ifhead
(
  buf: &tokbuf, bt: int, err: &int
) : ifhead = let
//
val err0 = err
//
var tok: token
val res = ptokhead_fun(buf, bt, err, is_IF, tok)
//
in
  if err = err0
    then ifhead_make(tok, res) else synent_null()
  // end of [if]
end // end of [p_ifhead]

(*
sifhead: SIF [i0nvresstate EQGT]
*)
fun
p_sifhead
(
  buf: &tokbuf, bt: int, err: &int
) : sifhead = let
//
val err0 = err
//
var tok: token
val res = ptokhead_fun(buf, bt, err, is_SIF, tok)
//
in
  if err = err0
    then sifhead_make(tok, res) else synent_null()
  // end of [if]
end // end of [p_sifhead]

(* ****** ****** *)

(*
ifhead: IFCASE [i0nvresstate EQGT]
*)
fun
p_ifcasehd
(
  buf: &tokbuf, bt: int, err: &int
) : ifhead = let
//
val err0 = err
//
var tok: token
val res =
  ptokhead_fun(buf, bt, err, is_IFCASE, tok)
//
in
  if err = err0
    then ifhead_make(tok, res) else synent_null()
  // end of [if]
end // end of [p_ifcasehd]

(* ****** ****** *)

(*
casehead: CASE [i0nvresstate EQGT]
*)
fun
p_casehead
(
  buf: &tokbuf, bt: int, err: &int
) : casehead = let
//
val err0 = err
//
var tok: token
val res = ptokhead_fun(buf, bt, err, is_CASE, tok)
//
in
  if err = err0
    then casehead_make(tok, res) else synent_null()
  // end of [if]
end // end of [p_casehead]

(*
scasehead: SCASE [i0nvresstate EQGT]
*)
fun
p_scasehead
(
  buf: &tokbuf, bt: int, err: &int
) : scasehead = let
//
val err0 = err
//
var tok: token
val res = ptokhead_fun(buf, bt, err, is_SCASE, tok)
//
in
  if err = err0
    then scasehead_make(tok, res) else synent_null()
  // end of [if]
end // end of [p_scasehead]

(* ****** ****** *)
//
(*
forhead ::= FORSTAR loopi0nv EQGT // [for] is external id
*)
//
fun
p_forhead (
  buf: &tokbuf, bt: int, err: &int
) : loophead = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
//
val ent1 = p_FORSTAR (buf, bt, err)
//
val ent2 =
  pif_fun (buf, bt, err, p_loopi0nv, err0)
//
val ent3 = pif_fun (buf, bt, err, p_EQGT, err0)
//
in
//
if
err = err0
then loophead_make_some (ent1, ent2, ent3)
else tokbuf_set_ntok_null (buf, n0)
//
end // end of [p_forhead]
//
(* ****** ****** *)
//
(*
whilehead ::= WHILESTAR loopi0nv EQGT // [while] is external id
*)
//
fun
p_whilehead (
  buf: &tokbuf, bt: int, err: &int
) : loophead = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
//
val ent1 = p_WHILESTAR (buf, bt, err)
//
val ent2 =
  pif_fun (buf, bt, err, p_loopi0nv, err0)
//
val ent3 = pif_fun (buf, bt, err, p_EQGT, err0)
//
in
  if err = err0 then
    loophead_make_some (ent1, ent2, ent3)
  else tokbuf_set_ntok_null (buf, n0)
end // end of [p_whilehead]
//
(* ****** ****** *)
//
(*
tryhead ::= TRY [i0nvresstate EQGT]
*)
//
fun
p_tryhead (
  buf: &tokbuf, bt: int, err: &int
) : tryhead = let
//
val
err0 = err
//
var tok: token
val res = ptokhead_fun(buf, bt, err, is_TRY, tok)
//
in
  if err = err0 then tryhead_make(tok, res) else synent_null()
end // end of [p_tryhead]
//
(* ****** ****** *)

(*
initestpost ::=
  LPAREN d0expcommaseq SEMICOLON d0expcommaseq SEMICOLON d0expcommaseq RPAREN
; /* initestpost */
*)
fun
p_initestpost
(
  buf: &tokbuf, bt: int, err: &int
) : initestpost = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_LPAREN (buf, bt, err)
  val bt = 0
  val ent2 = (if err = err0 then
    pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp) else list_vt_nil
  ) : d0explst_vt // end of [val]
  val ent3 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  val ent4 = (if err = err0 then
    pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp) else list_vt_nil
  ) : d0explst_vt // end of [val]
  val ent5 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  val ent6 = (if err = err0 then
    pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp) else list_vt_nil
  ) : d0explst_vt // end of [val]
  val ent7 = pif_fun (buf, bt, err, p_RPAREN, err0)
in
//
if
err = err0
then let
  val ent2 = (l2l)ent2
  val ent4 = (l2l)ent4
  val ent6 = (l2l)ent6
in
  initestpost_make
    (ent1, ent2, ent3, ent4, ent5, ent6, ent7)
  // initestpost_make
end // end of [then]
else let
  val () = list_vt_free(ent2)
  val () = list_vt_free(ent4)
  val () = list_vt_free(ent6)
in
  tokbuf_set_ntok_null(buf, n0)
end (* end of [else] *)
//
end // end of [p_initestpost]

(* ****** ****** *)
//
(*
d0exp  :: =
  | d0exp1
    {WHERE LBRACE d0ecseq_dyn RBRACE}*
  | ifhead    d0exp1 THEN d0exp [ELSE d0exp] // done!
  | sifhead   s0exp  THEN d0exp  ELSE d0exp  // done!
  | casehead  d0exp1 OF c0lauseq  // done!
  | scasehead s0exp  OF sc0lauseq // done!
  | ifcasehd  i0fclseq            // HX-2016-05-21: added
  | lamkind   f0arg1seq colons0expopt funarrow d0exp // done!
  | fixkind   di0de f0arg1seq colons0expopt funarrow d0exp // done!
  | whilehead atmd0exp d0exp // done!
  | forhead   initestpost d0exp // done!
  | tryhead   d0expsemiseq WITH c0lauseq // done!
*)
//
extern
fun
p_d0exp_tok
(
  buf: &tokbuf
, bt: int, err: &int, tok: token
) : d0exp // end-of-function
//
implement
p_d0exp
  (buf, bt, err) = 
(
  ptokwrap_fun (buf, bt, err, p_d0exp_tok, PE_d0exp)
) (* end of [p_d0exp] *)
//
implement
p_d0exp_tok
(
  buf, bt, err, tok
) = let
//
val err0 = err
var ent: synent?
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
| _ when
    ptest_fun (
    buf, p_d0exp1, ent
  ) => let
    val d0e =
      synent_decode{d0exp}(ent)
    // end of [val]
  in
    pstar_where(d0e, buf, bt, err)
  end
| _ when
    ptest_fun (
    buf, p_ifhead, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{ifhead}(ent)
    // end of [val]
    val ent2 = p_d0exp1(buf, bt, err)
    val ent3 = pif_fun(buf, bt, err, p_THEN, err0)
    val ent4 = pif_fun(buf, bt, err, p_d0exp, err0)
    val ent5 = ptokentopt_fun{d0exp}(buf, is_ELSE, p_d0exp)
  in
    if err = err0
      then let
        val ent5 = (t2t)ent5
      in
        d0exp_ifhead (ent1, ent2, ent4, ent5)
      end // end of [then]
      else let
        val () = option_vt_free(ent5) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_sifhead, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{sifhead}(ent)
    // end of [val]
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_THEN, err0)
    val ent4 = pif_fun (buf, bt, err, p_d0exp, err0)
    val ent5 = pif_fun (buf, bt, err, p_ELSE, err0)
    val ent6 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then d0exp_sifhead(ent1, ent2, ent4, ent6)
      else synent_null((*void*))
    // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_casehead, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{casehead}(ent)
    // end of [val]
    val ent2 = p_d0exp1 (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_OF, err0)
    val ent4 = pif_fun (buf, bt, err, p_c0lauseq, err0)
  in
    if err = err0
      then d0exp_casehead(ent1, ent2, ent3, ent4)
      else synent_null((*void*))
    // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_scasehead, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{scasehead}(ent)
    // end of [val]
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_OF, err0)
    val ent4 = pif_fun (buf, bt, err, p_sc0lauseq, err0)
  in
    if err = err0
      then d0exp_scasehead(ent1, ent2, ent3, ent4)
      else synent_null((*void*))
    // end of [if]
  end
//
| _ when
    ptest_fun (
    buf, p_ifcasehd, ent
  ) => let
    val bt = 0
    val ent1 =
      synent_decode{ifhead}(ent)
    // end of [val]
    val ent2 = p_i0fclseq (buf, bt, err)
  in
    if err = err0
      then d0exp_ifcasehd(ent1, ent2) else synent_null((*void*))
    // end of [if]
  end // for [IFCASE]
//
| T_LAM (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun{f0arg}(buf, bt, p_f0arg1)
    val ent3 = p_colons0expopt(buf, bt, err) // err=err0
    val ent4 = pif_fun (buf, bt, err, p_funarrow, err0)
    val ent5 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then let
        val ent2 = (l2l)ent2
      in
        d0exp_lam(knd, tok, ent2, ent3, ent4, ent5)
      end // end of [then]
      else let
        val () = list_vt_free(ent2) in synent_null()
      end // end of [else]
    // end of [if]
  end
| T_FIX (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_di0de (buf, bt, err)
    val ent3 =
    (
      if err = err0
        then pstar_fun(buf, bt, p_f0arg1)
        else list_vt_nil((*void*))
      // end of [if]
    ) : f0arglst_vt // end of [val]
    val ent4 =
      pif_fun (buf, bt, err, p_colons0expopt, err0)
    // end of [val]
    val ent5 = pif_fun (buf, bt, err, p_funarrow, err0)
    val ent6 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then let
        val ent3 = (l2l)ent3
      in
        d0exp_fix
          (knd, tok, ent2, ent3, ent4, ent5, ent6)
        // d0exp_fix
      end // end of [then]
      else let
        val () = list_vt_free(ent3) in synent_null()
      end (* end of [else] *)
    // end of [if]
  end
//
| T_FOR () => let
    val bt = 0 // no backtracking
    val () = incby1 ()
    val ent1 = loophead_make_none (tok)
    val ent2 = p_initestpost (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then d0exp_forhead(ent1, ent2, ent3)
      else synent_null((*void*))
    // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_forhead, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode{loophead}(ent)
    val ent2 = p_initestpost (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then d0exp_forhead(ent1, ent2, ent3)
      else synent_null((*void*))
    // end of [if]
  end
//
| T_WHILE () => let
    val bt = 0 // no backtracking
    val () = incby1 ()
    val ent1 = loophead_make_none(tok)
    val ent2 = p_atmd0exp(buf, bt, err)
    val ent3 = pif_fun(buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then d0exp_whilehead(ent1, ent2, ent3)
      else synent_null((*void*))
    // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_whilehead, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode{loophead}(ent)
    val ent2 =
      pif_fun (buf, bt, err, p_atmd0exp, err0)
    // end of [val]
    val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
  in
    if err = err0
      then d0exp_whilehead(ent1, ent2, ent3)
      else synent_null((*void*))
    // end of [if]
  end
//
| _ when
    ptest_fun (
    buf, p_tryhead, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode{tryhead}(ent)
    val ent2 = p_d0expsemiseq(buf, bt, err)
    val ent3 = pif_fun(buf, bt, err, p_WITH, err0)
    val ent4 = pif_fun(buf, bt, err, p_c0lauseq, err0)
  in
    if err = err0
      then d0exp_trywith_seq(ent1, ent2, ent3, ent4)
      else synent_null((*void*))
    // end of [if]
  end
//
| _ (*rest-of-tokens*) =>
    let val () = err := err + 1 in synent_null () end
//
end // end of [p_d0exp_tok]
//
(* ****** ****** *)

(*
//
// HX-2016-05-21: supporting for ifcase!
//
*)

local

fun
p_i0fcl (
  buf: &tokbuf, bt: int, err: &int
) : i0fcl = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_d0exp0(buf, bt, err)
  val ent2 = pif_fun (buf, bt, err, p_EQGT, err0)
  val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
in
//
if err = err0 then
  i0fcl_make (ent1, ent3)
else let
  val tok = tokbuf_get_token (buf)
  val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_i0fcl)
in
  tokbuf_set_ntok_null (buf, n0)
end // end of [if]
//
end // end of [p_i0fcl]

in (* in-of-local *)

implement
p_i0fclseq
  (buf, bt, err) = let
  val _ = p_BAR_test (buf) in l2l(pstar_fun0_BAR (buf, bt, p_i0fcl))
end // end of [p_i0fclseq]

end // end of [local]

(* ****** ****** *)

(* end of [pats_parsing_dynexp.dats] *)

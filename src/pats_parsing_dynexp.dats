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

#define l2l list_of_list_vt
#define t2t option_of_option_vt

(* ****** ****** *)

viewtypedef d0explst12 = list12 (d0exp)
viewtypedef labd0explst12 = list12 (labd0exp)

(* ****** ****** *)

fun d0exp_list12 (
  t_beg: token
, ent2: d0explst12
, t_end: token
) : d0exp =
  case+ ent2 of
  | ~LIST12one (xs) =>
      d0exp_list (t_beg, 0, (l2l)xs, t_end)
  | ~LIST12two (xs1, xs2) => let
      val npf = list_vt_length (xs1)
      val xs12 = list_vt_append (xs1, xs2)
    in
      d0exp_list (t_beg, npf, (l2l)xs12, t_end)
    end (* end of [LIST12two] *)
// end of [d0exp_list12]

(* ****** ****** *)

fun d0exp_tup12 (
  knd: int
, t_beg: token
, ent2: d0explst12
, t_end: token
) : d0exp =
  case+ ent2 of
  | ~LIST12one (xs) =>
      d0exp_tup (knd, t_beg, 0, (l2l)xs, t_end)
  | ~LIST12two (xs1, xs2) => let
      val npf = list_vt_length (xs1)
      val xs12 = list_vt_append (xs1, xs2)
    in
      d0exp_tup (knd, t_beg, npf, (l2l)xs12, t_end)
    end (* end of [LIST12two] *)
// end of [d0exp_tup12]

(* ****** ****** *)

fun d0exp_rec12 (
  knd: int
, t_beg: token, ent2: labd0explst12, t_end: token
) : d0exp =
  case+ ent2 of
  | ~LIST12one (xs) =>
      d0exp_rec (knd, t_beg, 0(*npf*), (l2l)xs, t_end)
  | ~LIST12two (xs1, xs2) => let
      val npf = list_vt_length (xs1)
      val xs12 = list_vt_append (xs1, xs2)
    in
      d0exp_rec (knd, t_beg, npf, (l2l)xs12, t_end)
    end
// end of [d0exp_rec12]

(* ****** ****** *)

fun
p_d0expseq_BAR_d0expseq (
  buf: &tokbuf
, bt: int
, err: &int
) : d0explst12 =
  plist12_fun (buf, bt, p_d0exp)
// end of [p_d0expseq_BAR_d0expseq]

fun
p_labd0expseq_BAR_labd0expseq (
  buf: &tokbuf
, bt: int
, err: &int
) : labd0explst12 =
  plist12_fun (buf, bt, p_labd0exp)
// end of [p_labd0expseq_BAR_labd0expseq]

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
in
//
case+ 0 of
| _ when
    ptest_fun (buf, p_di0de, ent) =>
    dqi0de_make_none (synent_decode {i0de} (ent))
| _ when
    ptest_fun (buf, p_d0ynq, ent) => let
    val bt = 0
    val ent1 = synent_decode {d0ynq} (ent)
    val ent2 = p_di0de (buf, bt, err)
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

(*
labd0exp ::= l0ab EQ d0exp
*)
implement
p_labd0exp (
  buf, bt, err
) = let
  val err0 = err
  val tok = tokbuf_get_token (buf)
//
  val+ ~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {l0ab,token,d0exp} (buf, bt, err, p_l0ab, p_EQ, p_d0exp)
//
in
//
if (err = err0) then
  labd0exp_make (ent1, ent3)
else let
  val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_labd0exp)
in
  synent_null ()
end (* end of [if] *)
//
end // end of [p_labd0exp]

(* ****** ****** *)

implement
p_d0expsemiseq0
  (buf, bt, err) = (l2l)xs where {
  val xs = pstar_fun0_SEMICOLON (buf, bt, p_d0exp)
  val () = let
    val semilst = pstar_fun (buf, bt, p_SEMICOLON)
  in
    list_vt_free (semilst)
  end (* end of [val] *)
} // end of [d0expsemiseq0]

(* ****** ****** *)

fun p_s0expelt (
  buf: &tokbuf, bt: int, err: &int
) : s0expopt = let
  val err0 = err
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
    if err = err0 then Some (ent2) else None ()
  end
| T_LBRACKET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACKET, err0)
  in
    if err = err0 then Some (ent2) else None ()
  end
| _ => None ()
end // end of [p_s0expelt]

(* ****** ****** *)

(*
arrdim ::= LBRACKET d0exp LBRACKET
*)
fun p_arrdimopt (
  buf: &tokbuf, bt: int, err: &int
) : d0expopt = let
  val err0 = err
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_LBRACKET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACKET, err0)
  in
    if err = err0 then Some (ent2) else None ()
  end
| _ => None ()
end // end of [p_arrdimopt]

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
  | DLREXTVAL LPAREN s0exp COMMA s0tring RPAREN
//
  | LPAREN d0expcommaseq {BAR d0expcommaseq} RPAREN
//
  | ATLPAREN d0expcommaseq {BAR d0expcommaseq} RPAREN
  | QUOTELPAREN d0expcommaseq {BAR d0expcommaseq} RPAREN
//
  | ATLBRACE labd0expseq {BAR labd0expseq} RBRACE
  | QUOTELBRACE labd0expseq {BAR labde0xpseq} RBRACE
//
  | ATLBRACKET s0exp RBRACKET arrdimopt LPAREN d0expcommaseq RPAREN
  | DLRARRSZ s0expelt LPAREN d0expcommaseq RPAREN
//
  | LET d0ecseq_dyn IN d0expsemiseq0 END
  | LBRACE d0ecseq_dyn RBRACE
*)

fun
p_atmd0exp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0exp = let
  val err0 = err
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| _ when
    ptest_fun (buf, p_dqi0de, ent) =>
    d0exp_dqid (synent_decode {dqi0de} (ent))
| T_INTEGER _ => let
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
| T_OP _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_di0de (buf, bt, err)
  in
    if err = err0 then
      d0exp_opid (tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_SRPFILENAME () => let
    val () = incby1 () in d0exp_FILENAME (tok)
  end
| T_SRPLOCATION () => let
    val () = incby1 () in d0exp_LOCATION (tok)
  end
//
| T_BRKCONT (knd) => let
    val () = incby1 () in d0exp_loopexn (knd, tok)
  end
//
| T_DLREXTVAL () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_s0exp, err0)
    val ent4 = pif_fun (buf, bt, err, p_COMMA, err0)
    val ent5 = pif_fun (buf, bt, err, p_s0tring, err0)
    val ent6 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0 then
      d0exp_extval (tok, ent3, ent5, ent6) else synent_null ()
    // end of [if]
  end
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0expseq_BAR_d0expseq (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if err = err0 then
      d0exp_list12 (tok, ent2, ent3)
    else let
      val () = list12_free (ent2) in synent_null ()
    end // end of [if]
  end
//
| tnd when
    is_LPAREN_deco (tnd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0expseq_BAR_d0expseq (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if err = err0 then let
      val knd = if is_ATLPAREN (tnd) then 0 else 1
    in
      d0exp_tup12 (knd, tok, ent2, ent3)
    end else let
      val () = list12_free (ent2) in synent_null ()
    end // end of [if]
  end
| tnd when
    is_LBRACE_deco (tnd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_labd0expseq_BAR_labd0expseq (buf, bt, err)
    val ent3 = p_RBRACE (buf, bt, err) // err = err0
  in
    if err = err0 then let
      val knd = if is_ATLBRACE (tnd) then 0 else 1
    in
      d0exp_rec12 (0(*knd*), tok, ent2, ent3)
    end else let
      val () = list12_free (ent2) in synent_null ()
    end // end of [if]
  end
//
| T_ATLBRACKET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0exp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RBRACKET, err0)
    val ent4 = (
      if err = err0 then p_arrdimopt (buf, bt, err) else None ()
    ) : d0expopt
    val ent5 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent6 = (
      if err = err0 then
        pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp) else list_vt_nil ()
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
| T_DLRARRSZ () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expelt (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_LPAREN, err0)
    val ent4 = (
      if err = err0 then
        pstar_fun0_COMMA {d0exp} (buf, bt, p_d0exp) else list_vt_nil ()
      // end of [if]
    ) : d0explst_vt // end of [val]
    val ent5 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0 then 
      d0exp_arrsize (tok, ent2, ent3, (l2l)ent4, ent5)
    else let
      val () = list_vt_free (ent4) in synent_null ()
    end (* end of [if] *)
  end
//
| T_LET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_dyn (buf, bt, err)
    val ent3 = p_IN (buf, bt, err) // err= err0
    val ent4 = pif_fun (buf, bt, err, p_d0expsemiseq0, err0)
    val ent5 = pif_fun (buf, bt, err, p_END, err0)
  in
    if err = err0 then
      d0exp_let_seq (tok, ent2, ent3, ent4, ent5)
    else synent_null ()
  end
| T_LBRACE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_dyn (buf, bt, err)
    val ent3 = p_RBRACE (buf, bt, err) // err = err0
  in
    if err = err0 then
      d0exp_declseq (tok, ent2, ent3) else synent_null ()
    // end of [if]
  end
//
| _ => let
    val () = err := err + 1 in synent_null ()
  end
// (* end of [case] *)
end // end of [p_atmd0exp_tok]

fun
p_atmd0exp (
  buf: &tokbuf, bt: int, err: &int
) : d0exp =
  ptokwrap_fun (buf, bt, err, p_atmd0exp_tok, PE_atmd0exp)
// end of [p_atmd0exp]

(* ****** ****** *)

fun
p_s0expdarg (
  buf: &tokbuf, bt: int, err: &int
) : d0exp = let
  val err0 = err
  val ~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {token,s0exparg,token} (buf, bt, err, p_LBRACE, p_s0exparg, p_RBRACE)
  // end of [val]
in
  if err = err0 then
    d0exp_sexparg (ent1, ent2, ent3) else synent_null ()
  // end of [if]
end // end of [p_s0expdarg]

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
d0exp ::= atmd0exp argd0expseq
*)
fun p_d0exp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0exp = let
  var ent: synent?
in
//
case+ 0 of
| _ when
    ptest_fun (
    buf, p_atmd0exp, ent
  ) => let
    val ent1 = synent_decode {d0exp} (ent)
    val ent2 = pstar_fun {d0exp} (buf, bt, p_argd0exp)
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
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_d0exp_tok]

implement
p_d0exp
  (buf, bt, err) = 
  ptokwrap_fun (buf, bt, err, p_d0exp_tok, PE_d0exp)
// end of [p_d0exp]

(* ****** ****** *)

(* end of [pats_parsing_dynexp.dats] *)

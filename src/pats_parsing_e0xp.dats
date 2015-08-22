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

staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
#define t2t option_of_option_vt

(* ****** ****** *)

(*
e0xpseq ::= /*(empty)*/ | e0xp {COMMA e0xpseq}*
*)

fun
p_e0xpseq_vt
(
  buf: &tokbuf
, bt: int, err: &int
) : List_vt (e0xp) =
(
  pstar_fun0_COMMA {e0xp} (buf, bt, p_e0xp)
) (* p_e0xpseq_vt *)

(* ****** ****** *)
//
implement
p_e0xpseq
  (buf, bt, err) = l2l(p_e0xpseq_vt(buf, bt, err))
//
(* ****** ****** *)
//
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
//
fun
p_atme0xp (
  buf: &tokbuf, bt: int, err: &int
) : e0xp =
(
  ptokwrap_fun
    (buf, bt, err, p_atme0xp_tok, PE_atme0xp)
) (* p_atme0xp *)
//
and
p_atme0xp_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : e0xp = let
//
val
err0 = err
//
var ent: synent?
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
//
| _ when
    ptest_fun(buf, p_i0de, ent) =>
    e0xp_i0de (synent_decode (ent))
//
| T_INT _ => let
    val () = incby1 () in e0xp_i0nt (tok)
  end
| T_CHAR _ => let
    val () = incby1 () in e0xp_c0har (tok)
  end
| T_FLOAT _ => let
    val () = incby1 () in e0xp_f0loat (tok)
  end
| T_STRING _ => let
    val () = incby1 () in e0xp_s0tring (tok)
  end
//
| T_LPAREN() => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xpseq_vt (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err) // err=err0
  in
    if err = err0 then
      e0xp_list (tok, (l2l)ent2, ent3)
    else let
      val () = list_vt_free (ent2) in synent_null()
    end (* end of [if] *)
  end // end of [T_LPAREN]
//
| T_PERCENTLPAREN
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0 then
      e0xp_eval (tok, ent2, ent3) else synent_null()
    // end of [if]
  end // end of [T_PERCENTLPAREN]
//
| _ (*rest-of-tokens*) =>
    let val () = err := err + 1 in synent_null() end
//
end // end of [p_atme0xp_tok]
//
(* ****** ****** *)
//
(*
e0xp0 ::= {atme0xp}+
*)
//
fun
p_e0xp0 (
  buf: &tokbuf, bt: int, err: &int
) : e0xp = let
//
fun
loop (
  x0: e0xp, xs1: List_vt (e0xp)
) : e0xp =
(
  case+ xs1 of
  | ~list_vt_nil () => x0
  | ~list_vt_cons (x1, xs1) => let
      val x0 = e0xp_app (x0, x1) in loop (x0, xs1)
    end // end of [list_vt_cons]
) (* end of [loop] *)
//
val xs = pstar1_fun (buf, bt, err, p_atme0xp)
//
in
//
case+ xs of
| ~list_vt_nil () => synent_null ()
| ~list_vt_cons (x, xs) => loop (x, xs)
//
end // end of [p_e0xp0]
//
(* ****** ****** *)
//
(*
e0xp ::= e0xp0 [e0xp] | IF e0xp0 THEN e0xp [ELSE e0xp]
*)
//
implement
p_e0xp(buf, bt, err) = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
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
    buf, p_e0xp0, ent
  ) => let
    val ent1 = synent_decode {e0xp} (ent)
    val ent2 = p_e0xp (buf, 0(*bt*), err) // optional
  in
    if err = err0
      then e0xp_app (ent1, ent2) else (err := err0; ent1)
    // end of [if]
  end
| T_IF () => let
    val () = incby1 ()
    val ent2 = p_e0xp0 (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_THEN, err0)
    val ent4 = pif_fun (buf, bt, err, p_e0xp, err0)
    val ent5 = ptokentopt_fun {e0xp} (buf, is_ELSE, p_e0xp)
  in
    if err = err0
      then e0xp_if (tok, ent2, ent4, (t2t)ent5)
      else let
        val () = option_vt_free (ent5) in tokbuf_set_ntok_null (buf, n0)
      end (* end of [else] *)
    // end of [if]
  end // end of [T_IF]
| _ (*rest-of-tokens*) =>
    let val () = err := err + 1 in synent_null() end
end // end of [p_e0xp]
//
(* ****** ****** *)
//
(*
datsval ::= i0de
  | LITERAL_char | LITERAL_float | LITERAL_int | LITERAL_string
*)
//
fun
p_datsval
(
  buf: &tokbuf, bt: int, err: &int
) : e0xp = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
var ent: synent?
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node
of // case+
//
| T_INT _ => let
    val () = incby1 () in e0xp_i0nt (tok)
  end
| T_CHAR _ => let
    val () = incby1 () in e0xp_c0har (tok)
  end
| T_FLOAT _ => let
    val () = incby1 () in e0xp_f0loat (tok)
  end
| T_STRING _ => let
    val () = incby1 () in e0xp_s0tring (tok)
  end
//
| T_IDENT_alp (id) => let
    val () = incby1 () in e0xp_make_stringid (loc, id)
  end // end of [T_IDENT_alp]
//
| _(*rest-of-tokens*) => e0xp_make_stringid (loc, "")
//
end // end of [p_datsval]
//
(* ****** ****** *)
//
(*
datsdef ::=
i0de [EQ = datsval] // HX: for use in a command-line
*)
//
implement
p_datsdef
  (buf, bt, err) = let
//
val
err0 = err
//
val n0 = tokbuf_get_ntok (buf)
//
val ent1 = p_i0de (buf, bt, err)
val ent2 = (
  if err = err0
    then ptokentopt_fun (buf, is_EQ, p_datsval)
    else None_vt ()
   // end of [if]
) : Option_vt (e0xp)
//
in
//
if
err = err0
then datsdef_make (ent1, (t2t)ent2)
else let
  val () = option_vt_free (ent2) in tokbuf_set_ntok_null (buf, n0)
end // end of [else]
//
end // end of [p_datsdef]
//
(* ****** ****** *)

(* end of [pats_parsing_e0xp.dats] *)

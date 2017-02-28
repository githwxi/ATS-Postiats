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
d0atsrtdec ::= s0rtid EQ d0atsrtconseq
*)
fun
p_d0atsrtdec (
  buf: &tokbuf, bt: int, err: &int
) : d0atsrtdec = let
  val err0 = err
  typedef a1 = i0de
  typedef a2 = token
  typedef a3 = d0atsrtconlst
  val+~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {a1,a2,a3} (buf, bt, err, p_s0rtid, p_EQ, p_d0atsrtconseq)
  // end of [val]
in
  if err = err0
    then d0atsrtdec_make (ent1, ent2, ent3) else synent_null ((*okay*))
  // end of [if]
end // end of [p_d0atsrtdec]

implement
p_d0atsrtdecseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_d0atsrtdec)
in
  l2l (xs)
end // end of [p_d0atsrtdecseq]

(* ****** ****** *)

(*
s0rtdef ::= s0rtid EQ s0rtext
*)
fun
p_s0rtdef (
  buf: &tokbuf, bt: int, err: &int
) : s0rtdef = let
  val err0 = err
  typedef a1 = i0de
  typedef a2 = token
  typedef a3 = s0rtext
  val+~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {a1,a2,a3} (buf, bt, err, p_s0rtid, p_EQ, p_s0rtext)
  // end of [val]
in
  if (err = err0) then
    s0rtdef_make (ent1, ent3) else synent_null ((*okay*))
  // end of [if]
end // end of [p_s0rtdef]

implement
p_s0rtdefseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0rtdef)
in
  l2l (xs)
end // end of [p_s0rtdecseq]

(* ****** ****** *)

(*
s0tacon ::= si0de a0msrtseq { EQ s0exp }
*)
fun
p_s0tacon (
  buf: &tokbuf, bt: int, err: &int
) : s0tacon = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_si0de(buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun{a0msrt}(buf, bt, p_a0msrt) else list_vt_nil
  // end of [if]
) : a0msrtlst_vt
val ent3 = pif_fun (buf, bt, err, p_eqs0expopt, err0)
//
in
  if err = err0
    then s0tacon_make (ent1, (l2l)ent2, ent3)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end (* end of [else] *)
  // end of [if]
end // end of [p_s0tacon]

implement
p_s0taconseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0tacon)
in
  l2l (xs)
end // end of [p_s0taconseq]

(* ****** ****** *)

(*
s0tacst ::= si0de a0msrtseq COLON s0rt extnamopt
*)
fun
p_s0tacst (
  buf: &tokbuf, bt: int, err: &int
) : s0tacst = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_si0de (buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun{a0msrt}(buf, bt, p_a0msrt) else list_vt_nil(*void*)
  // end of [if]
) : a0msrtlst_vt
val ent3 =
  pif_fun (buf, bt, err, p_COLON, err0)
// end of [val]
val ent4 = pif_fun (buf, bt, err, p_s0rt, err0)
val ent5 = pif_fun (buf, bt, err, p_extnamopt, err0)
//
in
  if err = err0
    then s0tacst_make (ent1, (l2l)ent2, ent4, ent5)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_s0tacst]

implement
p_s0tacstseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0tacst)
in
  l2l (xs)
end // end of [p_s0tacstseq]

(* ****** ****** *)

(*
//
// HX-2012-05-23: removed
//
(*
s0tavar ::= si0de COLON s0rt
*)
fun
p_s0tavar (
  buf: &tokbuf, bt: int, err: &int
) : s0tavar = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_si0de (buf, bt, err)
val bt = 0
val ent2 =
  pif_fun (buf, bt, err, p_COLON, err0)
val ent3 = pif_fun (buf, bt, err, p_s0rt, err0)
//
in
  if err = err0
    then s0tavar_make (ent1, ent3) else tokbuf_set_ntok_null (buf, ntok0)
  // end of [if]
end // end of [p_s0tavar]

implement
p_s0tavarseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0tavar)
in
  l2l (xs)
end // end of [p_s0tavarseq]
*)

(* ****** ****** *)

(*
t0kindef: si0de EQ s0tring
*)
fun
p_t0kindef (
  buf: &tokbuf, bt: int, err: &int
) : t0kindef = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_si0de (buf, bt, err)
val bt = 0
val ent2 = pif_fun (buf, bt, err, p_EQ, err0)
val ent3 = pif_fun (buf, bt, err, p_s0tring, err0)
//
in
  if err = err0
    then t0kindef_make (ent1, ent3) else tokbuf_set_ntok_null (buf, ntok0)
  // end of [if]
end // end of [p_t0kindef]

(* ****** ****** *)

(*
s0expdef
  | si0de s0margseq colons0rtopt EQ s0exp
*)
fun
p_s0expdef
(
  buf: &tokbuf, bt: int, err: &int
) : s0expdef = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok(buf)
//
val ent1 = p_si0de(buf, bt, err)
//
val bt = 0
val ent2 =
(
  if err = err0
    then pstar_fun(buf, bt, p_s0marg)
    else list_vt_nil(*void*)
  // end of [if]
) : s0marglst_vt // end of [val]
//
val ent3 =
  pif_fun(buf, bt, err, p_colons0rtopt, err0)
// end of [val]
//
val ent4 = pif_fun(buf, bt, err, p_EQ, err0)
val ent5 = pif_fun(buf, bt, err, p_s0exp, err0)
//
in
  if err = err0
    then s0expdef_make(ent1, (l2l)ent2, ent3, ent5)
    else let
      val () = list_vt_free(ent2) in tokbuf_set_ntok_null(buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_s0expdef]

implement
p_s0expdefseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND(buf, bt, err, p_s0expdef)
in
  l2l (xs)
end // end of [p_s0expdecseq]

(* ****** ****** *)

(*
s0aspdec ::= sqi0de s0margseq colons0rtopt EQ s0exp
*)
fun
p_s0aspdec
(
  buf: &tokbuf, bt: int, err: &int
) : s0aspdec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok(buf)
//
val ent1 = p_sqi0de(buf, bt, err)
//
val bt = 0
val ent2 =
(
  if err = err0
    then pstar_fun(buf, bt, p_s0marg)
    else list_vt_nil(*void*)
  // end of [if]
) : s0marglst_vt
//
val ent3 =
  pif_fun
  (
    buf, bt, err, p_colons0rtopt, err0
  ) (* pif_fun *)
//
val ent4 = pif_fun(buf, bt, err, p_EQ, err0)
val ent5 = pif_fun(buf, bt, err, p_s0exp, err0)
//
in
  if err = err0
    then s0aspdec_make(ent1, (l2l)ent2, ent3, ent5)
    else let
      val () = list_vt_free(ent2) in tokbuf_set_ntok_null(buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_s0aspdec]

(* ****** ****** *)
//
(*
e0xndecseq = e0xndec { AND e0xndec }
*)
implement
p_e0xndecseq
  (buf, bt, err) =
  list_of_list_vt(xs) where
{
  val xs = pstar_fun1_AND(buf, bt, err, p_e0xndec)
} (* end of [p_e0xndecseq] *)
//
(* ****** ****** *)

(*
d0atdec ::= si0de a0msrtseq EQ d0atconseq
*)
fun
p_d0atdec (
  buf: &tokbuf, bt: int, err: &int
) : d0atdec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_si0de (buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun {a0msrt} (buf, bt, p_a0msrt) else list_vt_nil ()
  // end of [if]
) : a0msrtlst_vt // end of [val]
val ent3 = pif_fun (buf, bt, err, p_EQ, err0)
val ent4 = pif_fun (buf, bt, err, p_d0atconseq, err0)
//
in
  if err = err0
    then d0atdec_make (ent1, (l2l)ent2, ent4)
    else let
      val () = err := err + 1
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_d0atdec]

implement
p_d0atdecseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_d0atdec)
in
  l2l (xs)
end // end of [p_d0atdecseq]

(* ****** ****** *)

(*
d0cstdec ::= di0de d0cstargseq colonwith s0exp extnamopt
*)
fun
p_d0cstdec (
  buf: &tokbuf, bt: int, err: &int
) : d0cstdec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_di0de (buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun (buf, bt, p_d0cstarg) else list_vt_nil(*void*)
  // end of [if]
) : List_vt (d0cstarg)
val ent3 = pif_fun (buf, bt, err, p_colonwith, err0)
val ent4 = pif_fun (buf, bt, err, p_s0exp, err0)
val ent5 = pif_fun (buf, bt, err, p_extnamopt, err0)
//
in
  if err = err0
    then d0cstdec_make (ent1, (l2l)ent2, ent3, ent4, ent5)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_d0cstdec]

implement
p_d0cstdecseq
  (buf, bt, err) = (
  l2l (pstar_fun1_AND (buf, bt, err, p_d0cstdec))
) (* end of [p_d0cstdecseq] *)

(* ****** ****** *)

(*
s0ym ::= di0de | LBRACKET RBRACKET | DOT l0ab
*)
extern
fun p_s0ym : parser (i0de)
implement
p_s0ym (buf, bt, err) = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
  tok.token_node of
| T_DOT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_l0ab (buf, bt, err)
  in
    if err = err0
      then i0de_make_dotlab (tok, ent2) else tokbuf_set_ntok_null (buf, ntok0)
    // end of [if]
  end // end of [T_DOT]
| T_LBRACKET () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_RBRACKET (buf, bt, err)
  in
    if err = err0
      then i0de_make_lrbrackets (tok, ent2) else tokbuf_set_ntok_null (buf, ntok0)
    // end of [if]
  end
| _ => let
    val ent = p_di0de (buf, bt, err)
  in
    if err = err0 then ent else synent_null ((*okay*))
  end // end of [_]
//
end // end of [p_s0ym]

(* ****** ****** *)

extern
fun p_s0ymseq1 : parser (i0delst)
implement
p_s0ymseq1
  (buf, bt, err) = let
  val xs = pstar1_fun (buf, bt, err, p_s0ym)
in
  list_of_list_vt (xs)
end // end of [p_s0ymseq1]

(* ****** ****** *)

extern
fun p_m0acarg : parser (m0acarg)
(*
m0acarg ::=
  | pi0de
  | LBRACE s0argseq RBRACE
  | LPAREN pi0deseq RPAREN
*)

implement
p_m0acarg
  (buf, bt, err) = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+ tok.token_node of
| T_LBRACE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun0_COMMA {s0arg} (buf, bt, p_s0arg)
    val ent3 = p_RBRACE (buf, bt, err)
  in
    if err = err0
      then m0acarg_sta (tok, (l2l)ent2, ent3)
      else let
        val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
      end // end of [else]
    // end of [if]
  end
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun0_COMMA {i0de} (buf, bt, p_si0de)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = err0
      then m0acarg_dyn (tok, (l2l)ent2, ent3)
      else let
        val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
      end // end of [if]
    // end of [if]
  end
| _ => let
    val ent1 = p_pi0de (buf, bt, err)
  in
    if err = err0
      then m0acarg_sing (ent1) else tokbuf_set_ntok_null (buf, ntok0)
    // end of [if]
  end
//
end // end of [p_m0acarg]

(* ****** ****** *)

(*
m0acdef ::= di0de m0acargseq EQ d0exp
*)
implement
p_m0acdef
  (buf, bt, err) = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_di0de (buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun (buf, bt, p_m0acarg) else list_vt_nil
  // end of [if]
) : List_vt (m0acarg)
val ent3 = pif_fun (buf, bt, err, p_EQ, err0)
val ent4 = pif_fun (buf, bt, err, p_d0exp, err0)
//
in
  if err = err0
    then m0acdef_make (ent1, (l2l)ent2, ent4)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end // end of [else]
  // end of [if]
end // end of [p_m0acdef]

(* ****** ****** *)

(*
stai0de ::= IDENT_alp
*)
//
extern fun p_stai0de : parser (i0de)
//
implement
p_stai0de
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_alp name => let
    val () = incby1 ()
    val name = "$" + name // HX: each qualifier begins with '$' 
  in
    i0de_make_string (loc, name)
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_stai0de)
  in
    synent_null ((*okay*))
  end
//
end // end of [p_stai0de]

(* ****** ****** *)

(*
staloadarg =
  | s0tring // "...": filename
  | i0de_dlr // $...: namespace
  | { d0eclseq_dyn } // local declarations
*)

fun
p_staloadarg
(
  buf: &tokbuf, bt: int, err: &int
) : staloadarg = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+ tok.token_node of
//
| T_STRING (name) => let
    val () = incby1 () in STLDfname (loc, name)
  end // end of [T_STRING]
//
| T_IDENT_dlr (name) => let
    val () = incby1 () in STLDnspace (loc, name)
  end // end of [T_IDENT_dlr]
//
| T_LBRACE ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      p_d0eclseq_fun{d0ecl}(buf, bt, p_d0ecl_dyn)
    // end of [val]
    val ent3 =
      pif_fun{token}(buf, bt, err, p_RBRACE, err0)
    // end of [val]
  in
    if err = err0
      then staloadarg_declist (tok, (l2l)ent2, ent3)
      else let
        val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
      end (* end of [else] *)
    // end of [if]
  end // end of [T_LBRACE]
//
| _ (*rest*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_staloadarg)
  in
    synent_null ((*okay*))
  end // end of [let] // end of [_]
//
end // end of [p_staloadarg]

(* ****** ****** *)

(*
staload ::=
  | s0tring
  | i0de_dlr
  | stai0de EQ staloadarg
*)
fun
p_staload_tok
(
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val err0 = err
  val tok2 = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
  tok2.token_node of
| T_STRING _ => let
    val () = incby1 () in d0ecl_staload_fname (tok, tok2)
  end // end of [T_STRING]
| T_IDENT_dlr _ => let
    val () = incby1 () in d0ecl_staload_nspace (tok, tok2)
  end // end of [T_IDENT_dlr]
| _ (*non-STR-IDENT*) => let
    val ent2 = p_stai0de (buf, bt, err)
    val bt = 0 // HX: backtracking is cancelled
    val ent3 = pif_fun (buf, bt, err, p_EQ, err0)
    val ent4 = pif_fun (buf, bt, err, p_staloadarg, err0)
  in
    if (err = err0)
      then
        d0ecl_staload_some_arg (tok, ent2, ent4)
      // end of [then]
      else let
        val d0c = synent_null((*okay*))
(*
        val ((*void*)) =
          the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_staload)
        // end of [val]
*)
      in
        d0c(*staload*)
      end // end of [else]
    // end of [if]
  end (* end of [_] *)
//
end // end of [p_staload_tok]

(* ****** ****** *)

(*
srpifkind ::= SRPIF | SRPIFDEF | SRPIFNDEF
*)
fun
p_srpifkind
(
  buf: &tokbuf, bt: int, err: &int
) : token = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_SRPIF () => let
    val () = incby1 () in tok
  end
| T_SRPIFDEF () => let
    val () = incby1 () in tok
  end
| T_SRPIFNDEF () => let
    val () = incby1 () in tok
  end
| _ => let
    val () = err := err + 1 in synent_null ((*okay*))
  end (* end of [_] *)
//
end // end of [p_srpifkind]

(*
srpelifkind ::= SRPELIF | SRPELIFDEF | SRPELIFNDEF
*)
fun
p_srpelifkind
(
  buf: &tokbuf, bt: int, err: &int
) : token = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_SRPELIF () => let
    val () = incby1 () in tok
  end
| T_SRPELIFDEF () => let
    val () = incby1 () in tok
  end
| T_SRPELIFNDEF () => let
    val () = incby1 () in tok
  end
| _ => let
    val () = err := err + 1 in synent_null ((*okay*))
  end (* end of [_] *)
//
end // end of [p_srpelifkind]

(* ****** ****** *)

(*
d0ecl
  | INFIX p0rec i0deseq
  | PREFIX p0rec i0deseq
  | POSTFIX p0rec i0deseq
  | NONFIX i0deseq
  | SYMINTR s0ymseq
  | SYMELIM s0ymseq
  | SRPUNDEF i0de
  | SRPDEFINE i0de e0xpopt
  | SRPERROR e0xp
  | SRPPRERR e0xp
  | SRPPRINT e0xp
  | SRPASSERT e0xp
  | DATASORT d0atsrtdecseq
  | STA s0tacstseq
(*
  | STAVAR s0tavarseq // HX-2012-05-23: removed this big hack!
*)
  | STADEF s0expdefseq
  | TYPEDEF s0expdefseq
  | ASSUME s0aspdec
  | EXCEPTION e0xndecseq
  | DATAYPE d0atdec andd0atdecseq {WHERE s0expdefseq}
  | MACDEF {REC} m0acdefseq
  | OVERLOAD [] WITH dqi0de {of INTEGER}
  | OVERLOAD s0ym WITH dqi0de {of INTEGER}
  | CLASSDEC si0de [EQ s0exp]
  | STALOAD staload
*)

fun
p_d0ecl_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val err0 = err
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
//
| T_FIXITY _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_p0rec (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_i0deseq1, err0)
  in
    if err = err0
      then d0ecl_fixity (tok, ent2, ent3) else synent_null ()
    // end of [if]
  end
| T_NONFIX () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = err0
      then d0ecl_nonfix (tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_SYMINTR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0ymseq1 (buf, bt, err)
  in
    if err = err0
      then d0ecl_symintr (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SYMELIM () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0ymseq1 (buf, bt, err)
  in
    if err = err0
      then d0ecl_symelim (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_OVERLOAD () => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_s0ym (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_WITH, err0)
    val ent3 = pif_fun (buf, bt, err, p_dqi0de, err0)
    val ent4 = (
      if err = err0
        then ptokentopt_fun (buf, is_OF, p_i0nt) else None_vt
      // end of [if]
    ) : Option_vt (i0nt)
  in
    if err = err0
      then d0ecl_overload (tok, ent1, ent3, (t2t)ent4)
      else let
        val () = option_vt_free (ent4) in synent_null ()
      end // end of [else]
    // end of [if]
  end (* T_OVERLOAD *)
//
| T_SRPUNDEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
  in
    if err = err0
    then d0ecl_e0xpundef(tok, ent2) else synent_null()
  end // end of [#undef]
| T_SRPDEFINE
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
    val ent3 = (
      if err = err0
      then popt_fun{e0xp}(buf, bt, p_e0xp) else None_vt()
    ) : Option_vt (e0xp) // end of [val]
  in
    if err = err0
      then let
        val ent3 =
          option_of_option_vt (ent3)
        // end of [val]
      in
        d0ecl_e0xpdef (tok, ent2, ent3)
      end // end of [then]
      else let
        val () = option_vt_free(ent3) in synent_null()
      end // end of [else]
    // end of [if]
  end // end of [#define]
//
| T_SRPERROR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0
      then d0ecl_e0xpact_error(tok, ent2) else synent_null()
    // end of [if]
  end
| T_SRPPRERR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0
      then d0ecl_e0xpact_prerr(tok, ent2) else synent_null()
    // end of [if]
  end
| T_SRPPRINT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0
      then d0ecl_e0xpact_print(tok, ent2) else synent_null()
    // end of [if]
  end
//
| T_SRPASSERT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0
      then d0ecl_e0xpact_assert(tok, ent2) else synent_null()
    // end of [if]
  end
//
| T_SRPREQUIRE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0 then d0ecl_require (tok, ent2) else synent_null()
    // end of [if]
  end // end of [T_SRPREQUIRE]
//
| T_SRPPRAGMA
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 =
      pif_fun (buf, bt, err, p_e0xpseq, err0)
    // end of [val]
    val ent4 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0ecl_pragma(ent2, ent3, ent4) else synent_null()
    // end of [if]
  end // end of [T_SRPCODEGEN2]
//
| T_SRPCODEGEN2
    ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_LPAREN (buf, bt, err)
    val ent3 =
      pif_fun (buf, bt, err, p_e0xpseq, err0)
    // end of [val]
    val ent4 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then d0ecl_codegen2(ent2, ent3, ent4) else synent_null()
    // end of [if]
  end // end of [T_SRPCODEGEN2]
//
| T_SORTDEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0rtdefseq (buf, bt, err)
  in
    if err = err0 then d0ecl_srtdefs (tok, ent2) else synent_null ()
  end
| T_DATASORT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0atsrtdecseq (buf, bt, err)
  in
    if err = err0 then d0ecl_datsrts (tok, ent2) else synent_null ()
  end
//
| T_STACST () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tacstseq (buf, bt, err)
  in
    if err = err0 then d0ecl_stacsts (tok, ent2) else synent_null ()
  end
| T_ABSTYPE (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0taconseq (buf, bt, err)
  in
    if err = err0 then d0ecl_stacons (knd, tok, ent2) else synent_null ()
  end
(*
| T_STAVAR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tavarseq (buf, bt, err)
  in
    if err = err0 then d0ecl_stavars (tok, ent2) else synent_null ()
  end
*)
//
| T_STADEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = err0
      then (
        d0ecl_sexpdefs(~1(*knd*), tok, ent2)
      ) else synent_null()
    // end of [if]
  end
| T_MACDEF (knd) => let
    val bt = 0
    val () = incby1 ()
    var _ent: synent?
    val isr = ptest_fun(buf, p_REC, _ent)
    val ent3 =
      pstar_fun1_AND{m0acdef}(buf, bt, err, p_m0acdef)
  in
    if err = err0
      then d0ecl_macdefs (knd, isr, tok, (l2l)ent3)
      else let
        val () = list_vt_free (ent3) in synent_null ()
      end (* end of [else] *)
    // end of [if]
  end
//
| T_ASSUME() => let
    val bt = 0
    val () = incby1()
    val ent2 = p_s0aspdec(buf, bt, err)
  in
    if err = err0
      then d0ecl_saspdec(tok, ent2) else synent_null()
    // end of [if]
  end // T_ASSUME
//
| T_REASSUME() => let
    val bt = 0
    val () = incby1()
    val ent2 = p_sqi0de(buf, bt, err)
  in
    if err = err0
      then d0ecl_reassume(tok, ent2) else synent_null()
    // end of [if]
  end // T_REASSUME
//
| T_TKINDEF() => let
    val bt = 0
    val () = incby1()
    val ent2 = p_t0kindef(buf, bt, err)
  in
    if err = err0
      then d0ecl_tkindef(tok, ent2) else synent_null()
  end // T_TKINDEF
//
| T_TYPEDEF(knd) => let
    val bt = 0
    val () = incby1()
    val ent2 =
      p_s0expdefseq(buf, bt, err)
    // end of [val]
  in
    if err = err0
      then d0ecl_sexpdefs(knd, tok, ent2) else synent_null()
  end // T_TYPEDEF
//
| T_EXCEPTION() => let
    val bt = 0
    val () = incby1()
    val ent2 =
      p_e0xndecseq(buf, bt, err)
    // end of [val]
  in
    if err = err0
      then d0ecl_exndecs(tok, ent2) else synent_null()
    // end of [if]
  end // T_EXCEPTION
| T_DATATYPE(knd) => let
    val bt = 0
    val () = incby1()
    val ent2 =
      p_d0atdecseq(buf, bt, err)
    // end of [val]
    val tok2 = tokbuf_get_token(buf)
  in
    case+
    tok2.token_node
    of (* case+ *)
    | T_WHERE () => let
        val () = incby1()
        val ent4 = p_s0expdefseq(buf, bt, err)
      in
        d0ecl_datdecs_some(knd, tok, ent2, tok2, ent4)
      end // end of [T_WHERE]
    | _ (*non-T_WHERE*) => d0ecl_datdecs_none(knd, tok, ent2)
  end // T_DATATYPE
//
| T_CLASSDEC() => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_si0de(buf, bt, err)
    val ent3 = pif_fun(buf, bt, err, p_colons0expopt, err0)
  in
    if err = err0
      then d0ecl_classdec(tok, ent1, ent3) else synent_null()
    // end of [if]
  end // T_CLASSDEC
//
| T_SRPSTALOAD() => let
    val bt = 0
    val () = incby1()
  in
    p_staload_tok(buf, bt, err, tok)
  end // end of [T_SRPSTALOAD]
//
| _ (*rest-of-tokens*) =>
    let val () = err := err + 1 in synent_null() end
// end of [case]
end // end of [p_d0ecl_tok]

(* ****** ****** *)

implement
p_d0ecl
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_d0ecl_tok, PE_d0ecl)
// end of [p_d0ecl]

(* ****** ****** *)

implement
p_d0eclseq_fun
  {a}(buf, bt, f) = let
//
viewtypedef res_vt = List_vt (a)
//
fun loop (
  buf: &tokbuf
, res: &res_vt? >> res_vt
, err: &int
) :<cloref1> void = let
  val x = f (buf, 1(*bt*), err)
in
  case+ 0 of
  | _ when err > 0 => let
      val () = res := list_vt_nil
    in
      // nothing
    end
  | _ => () where {
      val () =
        res := list_vt_cons {a} {0} (x, ?)
      // end of [val]
      val+list_vt_cons (_, !p_res1) = res
//
      val semilst = pstar_fun {token} (buf, 1(*bt*), p_SEMICOLON)
      val () = list_vt_free (semilst)
//
      val () = loop (buf, !p_res1, err)
      prval () = fold@ (res)
    } // end of [where] // end of [_]
end // end of [loop]
//
var res: res_vt
var err: int = 0
val () = loop (buf, res, err)
//
in
  res (* properly ordered *)
end // end of [p_d0eclseq_fun]

(* ****** ****** *)

(*
guad0ecl_fun
  | e0xp [SRPTHEN] d0eclseq_fun SRPENDIF
  | e0xp [SRPTHEN] d0eclseq_fun SRPELSE d0eclseq_fun SRPENDIF
  | e0xp [SRPTHEN] d0eclseq_fun srpelifkind guad0ecl_fun
*)
fun
guad0ecl_fun
(
  buf: &tokbuf
, bt: int, err: &int, f: parser (d0ecl)
) : guad0ecl = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
var ent: synent?
//
macdef incby1 () = tokbuf_incby1 (buf)
//
val ent1 = p_e0xp (buf, bt, err)
val bt = 0
val _(*ignored*) = ptest_fun (buf, p_SRPTHEN, ent)
val ent3 = (
  if err = err0
    then p_d0eclseq_fun (buf, bt, f) else list_vt_nil ()
  // end of [if]
) : List_vt (d0ecl)
//
val tok = tokbuf_get_token (buf)
//
in
//
if (
err = err0
) then (
//
case+ tok.token_node of
| T_SRPENDIF
    ((*void*)) => let
    val () = incby1 ()
  in
    guad0ecl_one (ent1, (l2l)ent3, tok)
  end
| T_SRPELSE () => let
    val bt = 0
    val () = incby1 ()
    val ent5 = p_d0eclseq_fun {d0ecl} (buf, bt, f)
    val ent6 = p_SRPENDIF (buf, bt, err)
  in
    if err = err0
      then guad0ecl_two (ent1, (l2l)ent3, (l2l)ent5, ent6)
      else let
        val () = list_vt_free (ent3)
        val () = list_vt_free (ent5) in tokbuf_set_ntok_null (buf, ntok0)
      end // end of [else]
    // end of [if]
  end
| _ when
    ptest_fun (
      buf, p_srpelifkind, ent
    ) => let
    val bt = 0
    val ent5 = guad0ecl_fun (buf, bt, err, f)
  in
    if err = err0
      then guad0ecl_cons (ent1, (l2l)ent3, tok, ent5)
      else let
        val () = list_vt_free (ent3) in tokbuf_set_ntok_null (buf, ntok0)
      end // end of [else]
    // end of [if]
  end // end of [_ when ...]
| _ => let
    val () = err := err + 1
    val () = list_vt_free (ent3)
    val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_guad0ecl)
  in
    tokbuf_set_ntok_null (buf, ntok0)
  end // end of [_]
//
) else let
  val () = list_vt_free (ent3) in tokbuf_set_ntok_null (buf, ntok0)
end // end of [if]
//
end // end of [guad0ecl_fun]

(* ****** ****** *)

(*
d0ecl_sta
  | d0ecl
  | dcstkind q0margseq d0cstdecseq
  | LITERAL_extcode
  | SRPINCLUDE LITERAL_string
  | LOCAL d0eclseq_sta IN d0eclseq_sta END
  | srpifkind guad0ecl_sta
*)

fun
p_d0ecl_sta_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val err0 = err
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| _ when
    ptest_fun
  (
    buf, p_d0ecl, ent
  ) => synent_decode (ent)
| _ when
    ptest_fun
  (
    buf, p_dcstkind, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {token} (ent)
    val ent2 = p_q0margseq (buf, bt, err)
    val ent3 = p_d0cstdecseq (buf, bt, err)
  in
    if err = err0
      then d0ecl_dcstdecs (ent1, ent2, ent3) else synent_null ()
    // end of [if]
  end // end of [_ when ...]
//
| T_EXTCODE _ => let
    val () = incby1 () in d0ecl_extcode (0(*sta*), tok)
  end // end of [T_EXTCODE]
//
| T_SRPINCLUDE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0
      then d0ecl_include (0(*sta*), tok, ent2) else synent_null ()
    // end of [if]
  end // end of [T_SRPINCLUDE]
//
| _ when
    ptest_fun
  (
    buf, p_srpifkind, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode{token}(ent)
    val ent2 = guad0ecl_fun (buf, bt, err, p_d0ecl_sta)
  in
    if err = err0
      then d0ecl_guadecl (ent1, ent2) else synent_null ()
    // end of [if]
  end // end of [_ when ...]
//
| T_LOCAL () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_fun{d0ecl}(buf, bt, p_d0ecl_sta)
    val ent3 = p_IN (buf, bt, err)
    val ent4 =
    (
      if err = err0
        then p_d0eclseq_fun (buf, bt, p_d0ecl_sta) else list_vt_nil ()
      // end of [if]
    ) : d0eclist_vt // end of [val]
    val ent5 = pif_fun (buf, bt, err, p_END, err0)
  in
    if err = err0
      then d0ecl_local (tok, (l2l)ent2, (l2l)ent4, ent5)
      else let
        val () = list_vt_free (ent2)
        val () = list_vt_free (ent4) in synent_null ((*okay*))
      end // end of [else]
    // end of [if]
  end // end of [T_LOCAL]
//
| _ => let
    val () = err := err + 1 in synent_null ()
  end // end of [_]
//
end // end of [p_d0ecl_sta_tok]

implement
p_d0ecl_sta
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_d0ecl_sta_tok, PE_d0ecl_sta)
// end of [p_d0ecl_sta]

(* ****** ****** *)

(*
v0aldec ::= p0at EQ d0exp witht0ype
*)
fun p_v0aldec (
  buf: &tokbuf, bt: int, err: &int
) : v0aldec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_p0at (buf, bt, err)
val ent2 = pif_fun (buf, bt, err, p_EQ, err0)
val ent3 = pif_fun (buf, bt, err, p_d0exp, err0)
val ent4 = pif_fun (buf, bt, err, p_witht0ype, err0)
//
in
//
if err = err0
  then v0aldec_make (ent1, ent3, ent4) else tokbuf_set_ntok_null (buf, ntok0)
//
end // end of [p_v0aldec]

(* ****** ****** *)

(*
f0undec ::= di0de f0argseq {colonwith s0exp} EQ d0exp witht0ype
*)
fun p_f0undec (
  buf: &tokbuf, bt: int, err: &int
) : f0undec = let
  val err0 = err
  var ent: synent?
in
//
case+ 0 of
| _ when
    ptest_fun (
    buf, p_di0de, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {i0de} (ent)
    val ent2 = pstar_fun {f0arg} (buf, bt, p_f0arg1)
    val+~SYNENT2 (ent3, ent4) =
      pseq2_fun {e0fftaglstopt,s0exp} (buf, 1(*bt*), err, p_colonwith, p_s0exp)
    // end of [val]
    val ent3 = (if (err = err0) then ent3 else None ()): e0fftaglstopt
    val ent4 = (if (err = err0) then Some (ent4) else None ()): s0expopt
    val () = if err > err0 then (err := err0) // anntationless
    val+~SYNENT3 (ent5, ent6, ent7) =
      pseq3_fun {token,d0exp,witht0ype} (buf, bt, err, p_EQ, p_d0exp, p_witht0ype)
    // end of [val]
  in
    if err = err0
      then f0undec_make (ent1, (l2l)ent2, ent3, ent4, ent6, ent7)
      else let val () = list_vt_free (ent2) in synent_null () end
    // end of [if]
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_f0undec]

(* ****** ****** *)

(*
v0ardec ::=
  {BANG} pi0de {COLON s0exp} {WITH pi0de} {EQ d0exp}
*)
fun p_v0ardec
(
  buf: &tokbuf, bt: int, err: &int
) : v0ardec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ref = popt_fun {token} (buf, bt, p_BANG)
val pid = p_pi0de (buf, bt, err)
val ann = pif_fun (buf, bt, err, p_colons0expopt, err0)
val varwth = (
  if err = err0
    then ptokentopt_fun (buf, is_WITH, p_pi0de) else None_vt ()
  // end  of [if]
) : Option_vt (i0de)
val def = pif_fun (buf, bt, err, p_eqd0expopt, err0)
//
in
//
if err = err0
  then // succ
    v0ardec_make ((t2t)ref, pid, (t2t)varwth, ann, def)
  else let // fail
    val () = option_vt_free (ref)
    val () = option_vt_free (varwth) in tokbuf_set_ntok_null (buf, ntok0)
  end // end of [else]
// end of [if]
//
end // end of [p_v0ardec]

(* ****** ****** *)

(*
i0mpsvararg ::= LBRACE s0vararg RBRACE
*)
fun
p_i0mpsvararg
(
  buf: &tokbuf, bt: int, err: &int
) : s0vararg = let
  val err0 = err
  typedef a1 = token
  typedef a2 = s0vararg
  typedef a3 = token
  val+
  ~SYNENT3
  (ent1, ent2, ent3) =
  pseq3_fun{a1,a2,a3}
    (buf, bt, err, p_LBRACE, p_s0vararg, p_RBRACE)
  // end of [val]
in
  if err = err0 then ent2 else synent_null((*okay*))
end // end of [p_i0mpsvararg]

(*
i0mparg ::= LPAREN {s0arg}* RPAREN | {i0mpsvararg}*
*)
fun
p_i0mparg
(
  buf: &tokbuf, bt: int, err: &int
) : i0mparg = let
//
val
err0 = err
val
ntok0 = tokbuf_get_ntok(buf)
//
val tok = tokbuf_get_token(buf)
//
macdef incby1() = tokbuf_incby1(buf)
//
in
//
case+
tok.token_node
of // case+
| T_LBRACE () => let
    val
    ent =
    pstar_fun{s0vararg}
      (buf, bt, p_i0mpsvararg)
    // end of [val]
  in
    i0mparg_svararglst((l2l)ent)
  end (* end of [_] *)
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun0_COMMA{s0arg}(buf, bt, p_s0arg)
    val ent3 = p_RPAREN (buf, bt, err)
  in
    if err = err0
      then i0mparg_sarglst_some(tok, (l2l)ent2, ent3)
      else let
        val () = list_vt_free(ent2) in tokbuf_set_ntok_null(buf, ntok0)
      end (* end of [else] *)
    // end of [if]
  end
| _ (*rest-of-tokens*) => i0mparg_sarglst_none()
//
end // end of [p_i0mparg]

(* ****** ****** *)
//
(*
impqi0de ::=
| dqi0de
| tmpqi0de tmps0expseq_gtlt GT
*)
//
fun
p_impqi0de
(
  buf: &tokbuf, bt: int, err: &int
) : impqi0de = let
//
val
err0 = err
val
ntok0 = tokbuf_get_ntok (buf)
//
val tok = tokbuf_get_token (buf)
var ent: synent? // uninitized
//
in
case+ 0 of
| _ when
    ptest_fun (
    buf, p_dqi0de, ent
  ) => let
    val qid = synent_decode{dqi0de}(ent) in impqi0de_make_none(qid)
  end // end of [dqi0de]
| _ when
    ptest_fun (
    buf, p_tmpqi0de, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {dqi0de} (ent)
    val ent2 =
      pstar_fun1_sep{t0mpmarg}(buf, bt, err, p_tmps0expseq, p_GTLT_test)
    val ent3 = p_GT (buf, bt, err)
  in
    if err = err0
      then impqi0de_make_some (ent1, (l2l)ent2, ent3)
      else let
        val () = list_vt_free (ent2) in tokbuf_set_ntok_null(buf, ntok0)
      end (* end of [else] *)
    // end of [if]
  end // end of [tmpqi0de]
| _ (*rest-of-token*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_impqi0de)
  in
    synent_null((*void*))
  end
end // end of [p_impqi0de]

(* ****** ****** *)
//
(*
i0mpdec ::=
| impqi0de f0arg2seq colons0expopt EQ d0exp
*)
//
fun p_i0mpdec (
  buf: &tokbuf, bt: int, err: &int
) : i0mpdec = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = p_impqi0de (buf, bt, err)
val bt = 0
val ent2 = (
  if err = err0
    then pstar_fun{f0arg}(buf, bt, p_f0arg2) else list_vt_nil(*void*)
  // end of [if]
) : f0arglst_vt
val ent3 =
  pif_fun (buf, bt, err, p_colons0expopt, err0)
val ent4 = pif_fun (buf, bt, err, p_EQ, err0)
val ent5 = pif_fun (buf, bt, err, p_d0exp, err0)
//
in
  if err = err0
    then i0mpdec_make (ent1, (l2l)ent2, ent3, ent5)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, ntok0)
    end (* end of [else] *)
  // end of [if]
end // end of [p_i0mpdec]

(* ****** ****** *)
//
(*
d0ec_dyn
  | d0ec
  | valkind {REC} v0aldecseq
  | funkind q0margseq f0undecseq
  | VAR v0ardecseq
//
  | IMPLEMENT i0mpargseq i0mpdec
//
  | EXTERN VAR LITERAL_string EQ d0exp
  | EXTERN TYPEDEF s0tring EQ s0exp
  | EXTERN dcstkind q0margseq d0cstdecseq
  | LITERAL_extcode
  | SRPINCLUDE LITERAL_string
  | DYNLOAD LITERAL_string
  | LOCAL d0ecseq_dyn IN d0ecseq_dyn END
  | srpifkind guad0ec_dyn
*)
//
fun
p_d0ecl_dyn_tok
(
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val err0 = err
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| _ when
    ptest_fun (
    buf, p_d0ecl, ent
  ) => synent_decode {d0ecl} (ent)
| T_VAL (knd) => let
    val bt = 0
    val () = incby1 ()
    val isrec = p_REC_test (buf)
    val ent3 = pstar_fun1_AND {v0aldec} (buf, bt, err, p_v0aldec)
  in
    if err = err0
      then d0ecl_valdecs (knd, isrec, tok, (l2l)ent3)
      else let val () = list_vt_free (ent3) in synent_null () end
    // end of [if]
  end // end of [T_VAL]
| T_FUN (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = pstar_fun {q0marg} (buf, bt, p_q0marg)
    val ent3 = pstar_fun1_AND {f0undec} (buf, bt, err, p_f0undec)
  in
    if err = err0
      then d0ecl_fundecs (knd, tok, (l2l)ent2, (l2l)ent3)
      else let
        val () = list_vt_free (ent2)
        val () = list_vt_free (ent3) in synent_null ((*okay*))
      end (* end of [else] *)
    // end of [if]
  end // end of [T_FUN]
| T_VAR (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun1_AND {v0ardec} (buf, bt, err, p_v0ardec)
  in
    if err = err0
      then d0ecl_vardecs (knd, tok, (l2l)ent2)
      else let
        val () = list_vt_free (ent2) in synent_null ((*okay*))
      end (* end of [else] *)
    // end of [if]
  end // end of [T_VAR]
//
| T_IMPLEMENT (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0mparg (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_i0mpdec, err0)
  in
    if err = err0
      then d0ecl_impdec (tok, ent2, ent3) else synent_null ()
    // (* end of [if] *)
  end // end of [T_IMPLEMENT]
//
| T_EXTCODE _ => let
    val () = incby1 () in d0ecl_extcode (1(*dyn*), tok)
  end // end of [T_EXTCODE]
//
| T_EXTERN () => let
    val bt = 0
    val () = incby1 ()
    val tok2 = tokbuf_get_token (buf)
  in
    case+ tok2.token_node of
//
    | _ when
        ptest_fun
      (
        buf, p_dcstkind, ent
      ) => let
        val ent1 = synent_decode {token} (ent)
        val ent2 = pif_fun (buf, bt, err, p_q0margseq, err0)
        val ent3 = pif_fun (buf, bt, err, p_d0cstdecseq, err0)
      in
        if err = err0
          then d0ecl_dcstdecs_extern (ent1, ent2, ent3) else synent_null ()
        // end of [if]
      end // end of [...]
//
    | T_VAR _ => let
        val () = incby1 ()
        val+~SYNENT3(ent1, ent2, ent3) =
          pseq3_fun{s0tring,token,d0exp}
            (buf, bt, err, p_s0tring, p_EQ, p_d0exp)
        // end of [val]
      in
        if err = err0
          then d0ecl_extvar2 (tok2, ent1, ent3) else synent_null ()
        // end of [if]
      end // end of [T_VAR]
    | T_TYPEDEF _ => let
        val () = incby1 ()
        val+~SYNENT3(ent1, ent2, ent3) =
          pseq3_fun{s0tring,token,s0exp}
            (buf, bt, err, p_s0tring, p_EQ, p_s0exp)
        // end of [val]
      in
        if err = err0
          then d0ecl_extype2 (tok2, ent1, ent3) else synent_null ()
        // end of [if]
      end // end of [T_TYPEDEF]
//
    | _ => let
        val () = err := err + 1 in synent_null ()
      end (* end of [_] *)
//
  end // end of [T_EXTERN]
//
| T_EXTYPE () => let
    val () = incby1 ()
    val+~SYNENT3(ent1, ent2, ent3) =
      pseq3_fun{s0tring,token,s0exp}
        (buf, bt, err, p_s0tring, p_EQ, p_s0exp)
    // end of [val]
  in
    if err = err0
      then d0ecl_extype (tok, ent1, ent3) else synent_null ()
    // end of [if]
   end // end of [T_EXTYPE]
//
| T_EXTVAR () => let
    val () = incby1 ()
    val+~SYNENT3(ent1, ent2, ent3) =
      pseq3_fun{s0tring,token,d0exp}
        (buf, bt, err, p_s0tring, p_EQ, p_d0exp)
    // end of [val]
  in
    if err = err0
      then d0ecl_extvar (tok, ent1, ent3) else synent_null ()
    // end of [if]
  end // end of [T_EXTVAR]
//
| T_STATIC () => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_dcstkind (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_q0margseq, err0)
    val ent3 = pif_fun (buf, bt, err, p_d0cstdecseq, err0)
  in
    if err = err0
      then d0ecl_dcstdecs_static (ent1, ent2, ent3) else synent_null ()
    // end of [if]
  end (* end of [T_STATIC] *)
//
| T_LOCAL () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_fun {d0ecl} (buf, bt, p_d0ecl_dyn)
    val ent3 = pif_fun (buf, bt, err, p_IN, err0)
    val ent4 = (
      if err = err0
        then p_d0eclseq_fun (buf, bt, p_d0ecl_dyn) else list_vt_nil ()
      // end of [if]
    ) : d0eclist_vt
    val ent5 = pif_fun (buf, bt, err, p_END, err0)
  in
    if err = err0
      then d0ecl_local (tok, (l2l)ent2, (l2l)ent4, ent5)
      else let
        val () = list_vt_free (ent2)
        val () = list_vt_free (ent4) in synent_null ((*okay*))
      end // end of [else]
    // end of [if]
  end
//
| T_SRPINCLUDE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0
      then d0ecl_include (1(*dyn*), tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_SRPDYNLOAD () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0 then d0ecl_dynload (tok, ent2) else synent_null ()
  end // end of [T_SRPDYNLOAD]
//
| _ when
    ptest_fun (
    buf, p_srpifkind, ent
  ) => let
    val bt = 0
    val ent1 = synent_decode {token} (ent)
    val ent2 = guad0ecl_fun (buf, bt, err, p_d0ecl_dyn)
  in
    if err = err0
      then d0ecl_guadecl (ent1, ent2) else synent_null ()
    // end of [if]
  end
| _ (*rest*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_d0ecl_dyn_tok]

implement
p_d0ecl_dyn
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_d0ecl_dyn_tok, PE_d0ecl_dyn)
// end of [p_d0ecl_dyn]

(* ****** ****** *)

implement
p_d0eclseq_sta
  (buf, bt, err) = let
  val xs = p_d0eclseq_fun (buf, bt, p_d0ecl_sta)
in
  (l2l)xs
end // end of [p_d0eclseq_sta]

implement
p_d0eclseq_dyn
  (buf, bt, err) = let
  val xs = p_d0eclseq_fun (buf, bt, p_d0ecl_dyn)
in
  (l2l)xs
end // end of [p_d0eclseq_dyn]

(* ****** ****** *)

(* end of [pats_parsing_decl.dats] *)

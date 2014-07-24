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
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

(*
s0rtid
  | IDENTIFIER_alp
  | IDENTIFIER_sym
  | BACKSLASH // for instant infixing
  | MINUSGT // for forming functional sorts
/*
  | MINUSLTGT // HX: what is this for?
*/
*)

implement
p_s0rtid
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
(*
  val () = println! ("p_s0rtid: bt = ", bt)
  val () = println! ("p_s0rtid: err = ", err)
  val () = println! ("p_s0rtid: tok = ", tok)
*)
in
//
case+ tok.token_node of
//
| T_IDENT_alp (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
| T_IDENT_sym (x) => let
    val () = incby1 () in i0de_make_string (loc, x)
  end
//
| T_BACKSLASH () => let
    val () = incby1 () in i0de_make_string (loc, "\\")
  end
| T_MINUSGT () => let
    val () = incby1 () in i0de_make_string (loc, "->")
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_s0rtid)
  in
    synent_null ()
  end // end of [_]
//
end // end of [p_s0rtid]

(*
s0rtq ::= i0de_dlr DOT
*)
implement
p_s0rtq (buf, bt, err) = let
  val err0 = err
  val+~SYNENT2 (ent1, ent2) =
    pseq2_fun {i0de,token} (buf, bt, err, p_i0de_dlr, p_DOT)
  // end of [val]
in
  if err = err0 then
    s0rtq_symdot (ent1, ent2) else synent_null ()
  // end of [if]
end // end of [p_s0rtq]

(* ****** ****** *)

fun
p_s0rtseq_vt (
  buf: &tokbuf
, bt: int
, err: &int
) : List_vt (s0rt) =
  pstar_fun0_COMMA {s0rt} (buf, bt, p_s0rt)
// end of [p_s0rtseq_vt]

(* ****** ****** *)

(*
atms0rt
  | s0rtid
  | T_TYPE // prop/view/type/viewtype/t0ype/viewt0ype
  | LPAREN s0rtseq RPAREN
  | s0rtq s0rtid
/*
  | ATLPAREN s0rtseq RPAREN // for tuple sorts
*/
*)

fun
p_atms0rt_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : s0rt = let
(*
  val () = println! ("p_atms0rt: bt = ", bt)
  val () = println! ("p_atms0rt: err = ", err)
  val () = println! ("p_atms0rt: tok = ", tok)
*)
  val err0 = err
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| _ when
    ptest_fun (buf, p_s0rtid, ent) =>
    s0rt_i0de (synent_decode {i0de} (ent))
//
| T_TYPE _ => let
    val () = incby1 () in s0rt_type (tok)
  end (* end of [T_TYPE] *)
//
| _ when
    ptest_fun (buf, p_s0rtq, ent) => let
    val bt = 0
    val ent1 = synent_decode {s0rtq} (ent)
    val ent2 = p_s0rtid (buf, bt, err) // err = err0
  in
    if err = err0 then
      s0rt_qid (ent1, ent2) else synent_null ()
    // end of [if]
  end
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0rtseq_vt (buf, bt, err)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if (
      err = err0
    ) then (
      s0rt_list (tok, l2l(ent2), ent3)
    ) else let
      val () = list_vt_free (ent2) in synent_null ()
    end // end of [if]
  end (* end of [T_LPAREN] *)
//
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_atms0rt_tok]

fun
p_atms0rt (
  buf: &tokbuf, bt: int, err: &int
) : s0rt =
  ptokwrap_fun (buf, bt, err, p_atms0rt_tok, PE_atms0rt)
// end of [p_atms0rt]

(* ****** ****** *)

(*
s0rt ::= {atms0rt}+
*)

implement
p_s0rt (buf, bt, err) = let
  val xs = pstar1_fun (buf, bt, err, p_atms0rt)
  fun loop (
    x0: s0rt, xs1: List_vt (s0rt)
  ) : s0rt =
    case+ xs1 of
    | ~list_vt_cons (x1, xs1) => let
        val x0 = s0rt_app (x0, x1) in loop (x0, xs1)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => x0
  // end of [loop]
in
//
case+ xs of
| ~list_vt_cons (x, xs) => loop (x, xs)
| ~list_vt_nil () => synent_null () // HX: [err] changed
//
end // end of [p_s0rt]

(* ****** ****** *)

implement
p_ofs0rtopt
  (buf, bt, err) =
  t2t (ptokentopt_fun (buf, is_OF, p_s0rt))
// end of [p_ofs0rtopt]

implement
p_colons0rtopt
  (buf, bt, err) =
  t2t (ptokentopt_fun (buf, is_COLON, p_s0rt))
// end of [p_colons0rtopt]

(* ****** ****** *)

(*
s0arg ::= si0de [COLON s0rt]
*)

implement
p_s0arg
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val ent1 = p_si0de (buf, bt, err)
//
in
//
if
err = err0
then let
  val bt = 0
  val ent2 =
    p_colons0rtopt (buf, bt, err) in s0arg_make (ent1, ent2)
  // end of [val]
end // end of [then]
else let
(*
  val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_s0arg)
*)
in
  tokbuf_set_ntok_null (buf, n0)
end // end of [else]
//
end // end of [p_s0arg]

(* ****** ****** *)

(*
s0marg ::= si0de | LPAREN s0argseq RPAREN
*)

fun
p_s0marg_tok (
  buf: &tokbuf
, bt: int, err: &int
, tok: token
) : s0marg = let
  val err0 = err
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| _ when
    ptest_fun (
      buf, p_si0de, ent
    ) => let
    val ent = synent_decode {i0de} (ent)
    val x = s0arg_make (ent, None ())
  in
    s0marg_make_one (x)
  end
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun0_COMMA {s0arg} (buf, bt, p_s0arg)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if err = err0 then
      s0marg_make_many (tok, (l2l)ent2, ent3)
    else let
      val () = list_vt_free (ent2) in synent_null ()
    end (* end of [if] *)
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_s0marg_tok]

implement
p_s0marg (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_s0marg_tok, PE_s0marg)
// end of [p_s0marg]

(* ****** ****** *)

(*
a0srt ::= s0rtpol | si0de COLON s0rtpol
*)
implement
p_a0srt
  (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val () = tokbuf_incby1 (buf)
  val tok2 = tokbuf_get_token (buf)
  val () = tokbuf_set_ntok (buf, n0)
in
//
case+ tok2.token_node of
| T_COLON () => let
    val ent1 = p_si0de (buf, bt, err)
    val bt = 0
    val ent2 = pif_fun (buf, bt, err, p_COLON, err0)
    val ent3 = pif_fun (buf, bt, err, p_s0rt, err0)
  in
    if err = err0 then
      a0srt_make_some (ent1, ent3)
    else let
(*
      val () =
        the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_a0srt)
      // end of [val]
*)
    in
      tokbuf_set_ntok_null (buf, n0)
    end (* end of [if] *)
  end
| _ => let
    val ent1 = p_s0rt (buf, bt, err)
  in
    if (
      err = err0
    ) then (
      a0srt_make_none (ent1)
    ) else let
(*
      val () =
        the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_a0srt)
      // end of [val]
*)
    in
      tokbuf_set_ntok_null (buf, n0)
    end (* end of [if] *)
  end
//
end // end of [p_a0srt]

(* ****** ****** *)

implement
p_a0msrt
  (buf, bt, err) = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun0_COMMA {a0srt} (buf, bt, p_a0srt)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if err = err0 then
      a0msrt_make (tok, (l2l)ent2, ent3)
    else let
      val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, n0)
    end (* end of [if] *)
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [p_a0msrt]  

(* ****** ****** *)

(*
d0atsrtcon ::= s0ide [OF s0ort]
*)

fun
p_d0atsrtcon (
  buf: &tokbuf, bt: int, err: &int
) : d0atsrtcon = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val tok = tokbuf_get_token (buf)
  val ent1 = p_si0de (buf, bt, err)
in
//
if
err = err0
then let
  val bt = 0
  val ent2 = p_ofs0rtopt (buf, bt, err)
in
  d0atsrtcon_make (ent1, ent2)
end // end of [then]
else let
(*
//
val () =
  the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_d0atsrtcon)
//
*)
in
  tokbuf_set_ntok_null (buf, n0)
end // end of [else]
//
end // end of [p_d0atsrtcon]

(* ****** ****** *)

implement
p_d0atsrtconseq
  (buf, bt, err) = let
  val tok = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+
tok.token_node of
| T_BAR () => let
    val () = incby1 ()
    val xs = pstar_fun0_BAR (buf, bt, p_d0atsrtcon) in l2l(xs)
  end // end of [T_BAR]
| _ => let
    val xs = pstar_fun0_BAR (buf, bt, p_d0atsrtcon) in l2l(xs)
  end // end of [_]
//
end // end of [p_d0atsrtconseq]

(* ****** ****** *)

(* end of [pats_parsing_sort.dats] *)

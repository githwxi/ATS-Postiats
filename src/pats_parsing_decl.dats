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

staload _(*anon*) = "prelude/DATS/option_vt.dats"

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

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
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_s0rtid (buf, bt, err)
  val ent2 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent3 = (
    if err = 0 then p_d0atsrtconseq (buf, bt, err) else list_nil ()
  ) : d0atsrtconlst // end of [val]
in
  if err = 0 then
    d0atsrtdec_make (ent1, ent2, ent3)
  else let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    synent_null ()
  end (* end of [if] *)
end // end of [p_d0atsrtdec]

implement
p_d0atsrtdecseq
  (buf, bt, err) = let
  val xs = pstar_fun1_sep (buf, bt, err, p_d0atsrtdec, p_AND_test)
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
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_s0rtid (buf, bt, err)
  val ent2 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent3 = (
    if err = 0 then p_s0rtext (buf, bt, err) else synent_null ()
  ) : s0rtext // end of [val]
in
  if (err = 0) then
    s0rtdef_make (ent1, ent3)
  else let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    synent_null ()
  end (* end of [if] *)
end // end of [p_s0rtdef]

implement
p_s0rtdefseq
  (buf, bt, err) = let
  val xs = pstar_fun1_sep (buf, bt, err, p_s0rtdef, p_AND_test)
in
  l2l (xs)
end // end of [p_s0rtdecseq]

(* ****** ****** *)

(*
s0tacon
  | si0de s0argseqseq
  | si0de s0argseqseq EQ s0exp
*)
fun
p_s0tacon (
  buf: &tokbuf, bt: int, err: &int
) : s0tacon = let
  val ent1 = p_si0de (buf, bt, err)
  val ent2 = (
    if err = 0 then p_d0atmargseq (buf, bt, err) else list_nil
  ) : d0atmarglst
  val ent3 = (
    if err = 0 then p_eqs0expopt_vt (buf, bt, err) else None_vt ()
  ) : s0expopt_vt
in
  if err = 0 then let
    val ent3 = (t2t)ent3
  in
    s0tacon_make (ent1, ent2, ent3)
  end else let
    val () = option_vt_free (ent3) in synent_null ()
  end (* end of [if] *)
end // end of [p_s0tacon]

implement
p_s0taconseq
  (buf, bt, err) = let
  val xs = pstar_fun1_sep (buf, bt, err, p_s0tacon, p_AND_test)
in
  l2l (xs)
end // end of [p_s0taconseq]

(* ****** ****** *)

(*
s0expdef
  | si0de s0argseqseq colons0rtopt EQ s0exp
*)
fun
p_s0expdef (
  buf: &tokbuf, bt: int, err: &int
) : s0expdef = let
  val ent1 = p_si0de (buf, bt, err)
  val ent2 = (
    if err = 0 then p_s0margseq (buf, bt, err) else list_nil
  ) : s0marglst
  val ent3 = (
    if err = 0 then p_colons0rtopt_vt (buf, bt, err) else None_vt
  ) : s0rtopt_vt // end of [val]
  val ent4 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent5 = (
    if err = 0 then p_s0exp (buf, bt, err) else synent_null ()
  ) : s0exp // end of [val]
in
  if err = 0 then
    s0expdef_make (ent1, ent2, (t2t)ent3, ent5)
  else let
    val () = option_vt_free (ent3) in synent_null ()
  end // end of [if]
end // end of [p_s0expdef]

implement
p_s0expdefseq
  (buf, bt, err) = let
  val xs = pstar_fun1_sep (buf, bt, err, p_s0expdef, p_AND_test)
in
  l2l (xs)
end // end of [p_s0expdecseq]

(* ****** ****** *)

(*
s0aspdec ::= sqi0de s0argseqseq colons0rtopt EQ s0exp
*)
fun
p_s0aspdec (
  buf: &tokbuf, bt: int, err: &int
) : s0aspdec = let
  val ent1 = p_sqi0de (buf, bt, err)
  val ent2 = (
    if err = 0 then p_s0margseq (buf, bt, err) else list_nil
  ) : s0marglst
  val ent3 = (
    if err = 0 then p_colons0rtopt_vt (buf, bt, err) else None_vt
  ) : s0rtopt_vt // end of [val]
  val ent4 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent5 = (
    if err = 0 then p_s0exp (buf, bt, err) else synent_null ()
  ) : s0exp // end of [val]
in
  if err = 0 then
    s0aspdec_make (ent1, ent2, (t2t)ent3, ent5)
  else let
    val () = option_vt_free (ent3) in synent_null ()
  end // end of [if]
end // end of [p_s0aspdec]

(* ****** ****** *)

(*
d0atdec ::=
  | si0de s0margseq EQ d0atconseq  { $$ = d0atdec_make_some($1, $3, $4, $6) ; }
*)
fun
p_d0atdec (
  buf: &tokbuf, bt: int, err: &int
) : d0atdec = let
//
  val () = println! ("p_d0atdec: bt = ", bt)
  val () = println! ("p_d0atdec: err = ", err)
//
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_si0de (buf, bt, err)
  val ent2 = (
    if err = 0 then p_d0atmargseq (buf, bt, err) else list_nil ()
  ) : d0atmarglst // end of [val]
  val ent3 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val () = println! ("p_d0atdec: err = ", err)
  val ent4 = (
    if err = 0 then p_d0atconseq (buf, bt, err) else list_nil ()
  ) : d0atconlst // end of [val]
  val () = println! ("p_d0atdec: err = ", err)
in
  if err = 0 then
    d0atdec_make (ent1, ent2, ent4)
  else let
    val () = err := err + 1
    val () = tokbuf_set_ntok (buf, n0)
  in
    synent_null ()
  end (* end of [if] *)
end // end of [p_d0atdec]

implement
p_d0atdecseq
  (buf, bt, err) = let
  val xs = pstar_fun1_sep (buf, bt, err, p_d0atdec, p_AND_test)
in
  l2l (xs)
end // end of [p_d0atdecseq]

(* ****** ****** *)

fun
p_stai0de (
  buf: &tokbuf, bt: int, err: &int
) : i0de = let
  val tok = tokbuf_get_token (buf)
  val loc = tok.token_loc
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_IDENT_alp name => let
    val () = incby1 () in i0de_make_string (loc, name)
  end
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PE_stai0de)
  in
    synent_null ()
  end
//
end // end of [p_stai0de]

(*
staload ::= STALOAD LITERAL_string | STALOAD stai0de EQ LITERAL_string
*)
fun
p_d0ecl_tok_staload (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val tok2 = tokbuf_get_token (buf)
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok2.token_node of
| T_STRING (name) => let
    val () = incby1 () in d0ecl_staload_none (tok, tok2)
  end
| _ => let
    val ent2 = p_stai0de (buf, bt, err)
    val ent3 = (
      if err = 0 then p_EQ (buf, bt, err) else synent_null ()
    ) : token // end of [val]
    val ent4 = (
      if err = 0 then p_s0tring (buf, bt, err) else synent_null ()
    ) : token // end of [val]
  in
    if err = 0 then
      d0ecl_staload_some (tok, ent2, ent4) else synent_null ()
    // end of [if]
  end
//
end // end of [p_d0ecl_tok_staload]

(* ****** ****** *)

(*
d0ecl
  | INFIX p0rec i0deseq
  | PREFIX p0rec i0deseq
  | POSTFIX p0rec i0deseq
  | NONFIX i0deseq
  | SYMINTR i0deseq
  | SRPUNDEF i0de
  | SRPDEFINE i0de e0xpopt
  | SRPASSERT e0xp
  | SRPERROR e0xp
  | SRPPRINT e0xp
  | DATASORT d0atsrtdecseq
  | STADEF s0expdefseq
  | TYPEDEF s0expdefseq
  | ASSUME s0aspdec
  | DATAYPE d0atdec andd0atdecseq {WHERE s0expdefseq}
*)

fun
p_d0ecl_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  macdef incby1 () = tokbuf_incby1 (buf)
in
//
case+ tok.token_node of
| T_FIXITY _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_p0rec (buf, bt, err)
    val ent3 = (
      if err = 0 then p_i0deseq1 (buf, bt, err) else list_nil ()
    ) : List (i0de) // end of [val]
  in
    if err = 0 then (
      d0ecl_fixity (tok, ent2, ent3)
    ) else synent_null ()
  end
| T_NONFIX () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = 0 then
      d0ecl_nonfix (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SYMINTR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = 0 then
      d0ecl_symintr (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPDEFINE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
    val ent3 = (
      if err = 0 then popt_fun {e0xp} (buf, bt, p_e0xp) else None_vt ()
    ) : Option_vt (e0xp) // end of [val]
  in
    if err = 0 then let
      val ent3 = option_of_option_vt (ent3)
    in
      d0ecl_e0xpdef (tok, ent2, ent3)
    end else let
      val () = option_vt_free (ent3) in synent_null ()
    end (* end of [if] *)
  end
| T_SRPASSERT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_assert (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPERROR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_error (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPPRINT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = 0 then
      d0ecl_e0xpact_print (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_DATASORT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0atsrtdecseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_datsrts (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SORTDEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0rtdefseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_srtdefs (tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_ABSTYPE (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0taconseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_stacons (knd, tok, ent2) else synent_null ()
    // end of [if]
  end
| T_STADEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_sexpdefs (~1(*knd*), tok, ent2) else synent_null ()
    // end of [if]
  end
| T_TYPEDEF (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_sexpdefs (knd, tok, ent2) else synent_null ()
    // end of [if]
  end
| T_ASSUME () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0aspdec (buf, bt, err)
  in
    if err = 0 then d0ecl_saspdec (tok, ent2) else synent_null ()
  end
| T_DATATYPE (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0atdecseq (buf, bt, err)
    val tok2 = tokbuf_get_token (buf)
  in
    case+ tok2.token_node of
    | T_WHERE () => let
        val () = incby1 ()
        val ent4 = p_s0expdefseq (buf, bt, err)
      in
        d0ecl_datdecs_some (knd, tok, ent2, tok2, ent4)
      end
    | _ => d0ecl_datdecs_none (knd, tok, ent2)
  end
//
| T_STALOAD () => let
    val bt = 0
    val () = incby1 ()
  in
    p_d0ecl_tok_staload (buf, bt, err, tok)
  end
//
| _ => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
// end of [case]
end // end of [p_d0ecl_tok]

implement
p_d0ecl
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_d0ecl_tok, PE_d0ecl)
// end of [p_d0ecl]

(* ****** ****** *)

implement
p_d0eclist
  (buf, bt, err) = let
  val xs = pstar_fun (buf, bt, p_d0ecl)
in
  list_of_list_vt (xs)
end // end of [d0eclist]

(* ****** ****** *)

(* end of [pats_parsing_decl.dats] *)

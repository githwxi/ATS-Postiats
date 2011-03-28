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

(* ****** ****** *)

(*
d0atsrtdec ::= i0de EQ d0atsrtconseq
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
s0expdef
  | si0de s0argseqseq colons0rtopt EQ s0exp
*)
fun
p_s0expdef (
  buf: &tokbuf, bt: int, err: &int
) : s0expdef = let
  val ent1 = p_si0de (buf, bt, err)
  val ent2 = (
    if err = 0 then p_s0argseqseq (buf, bt, err) else list_nil
  ) : s0arglstlst
  val ent3 = (
    if err = 0 then p_colons0rtopt (buf, bt, err) else synent_null ()
  ) : s0rtopt // end of [val]
  val ent4 = (
    if err = 0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent5 = (
    if err = 0 then p_s0exp (buf, bt, err) else synent_null ()
  ) : s0exp // end of [val]
in
  if err = 0 then
    s0expdef_make (ent1, ent2, ent3, ent5) else synent_null ()
  // end of [if]
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
*)

fun
p_d0ecl_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val loc = tok.token_loc
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
| T_TYPEDEF (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = 0 then
      d0ecl_sexpdefs (knd, tok, ent2) else synent_null ()
    // end of [if]
  end
| _ => synent_null ()
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

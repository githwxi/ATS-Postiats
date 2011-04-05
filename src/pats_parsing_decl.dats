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
  val err0 = err
  typedef a1 = i0de
  typedef a2 = token
  typedef a3 = d0atsrtconlst
  val ~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {a1,a2,a3} (buf, bt, err, p_s0rtid, p_EQ, p_d0atsrtconseq)
  // end of [val]
in
  if err = err0 then
    d0atsrtdec_make (ent1, ent2, ent3)
  else synent_null ((*okay*))
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
  val ~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {a1,a2,a3} (buf, bt, err, p_s0rtid, p_EQ, p_s0rtext)
  // end of [val]
in
  if (err = err0) then
    s0rtdef_make (ent1, ent3)
  else synent_null ((*okay*))
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
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
//
  val ent1 = p_si0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then
      pstar_fun {a0msrt} (buf, bt, p_a0msrt) else list_vt_nil
  ) : a0msrtlst_vt
  val ent3 = (
    if err = err0 then p_eqs0expopt_vt (buf, bt, err) else None_vt ()
  ) : s0expopt_vt
//
in
  if err = err0 then let
    val ent3 = (t2t)ent3
  in
    s0tacon_make (ent1, (l2l)ent2, ent3)
  end else let
    val () = list_vt_free (ent2)
    val () = option_vt_free (ent3)
  in
    tokbuf_set_ntok_null (buf, n0)
  end (* end of [if] *)
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
s0tacst ::= si0de a0msrtseq COLON s0rt
*)
fun
p_s0tacst (
  buf: &tokbuf, bt: int, err: &int
) : s0tacst = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
//
  val ent1 = p_si0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then
      pstar_fun {a0msrt} (buf, bt, p_a0msrt) else list_vt_nil
  ) : a0msrtlst_vt
  val ent3 = (
    if err = err0 then p_COLON (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent4 = (
    if err = err0 then p_s0rt (buf, bt, err) else synent_null ()
  ) : s0rt // end of [val]
//
in
  if err = err0 then (
    s0tacst_make (ent1, (l2l)ent2, ent4)
  ) else let
    val () = list_vt_free (ent2)
  in
    tokbuf_set_ntok_null (buf, n0)
  end (* end of [if] *)
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
s0tavar ::= si0de COLON s0rt
*)
fun
p_s0tavar (
  buf: &tokbuf, bt: int, err: &int
) : s0tavar = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
//
  val ent1 = p_si0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then p_COLON (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent3 = (
    if err = err0 then p_s0rt (buf, bt, err) else synent_null ()
  ) : s0rt // end of [val]
//
in
  if err = err0 then (
    s0tavar_make (ent1, ent3)
  ) else
    tokbuf_set_ntok_null (buf, n0)
  // end of [if]
end // end of [p_s0tavar]

implement
p_s0tavarseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0tavar)
in
  l2l (xs)
end // end of [p_s0tavarseq]

(* ****** ****** *)

(*
s0expdef
  | si0de s0argseqseq colons0rtopt EQ s0exp
*)
fun
p_s0expdef (
  buf: &tokbuf, bt: int, err: &int
) : s0expdef = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_si0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then pstar_fun (buf, bt, p_s0marg) else list_vt_nil
  ) : s0marglst_vt // end of [val]
  val ent3 = (
    if err = err0 then p_colons0rtopt_vt (buf, bt, err) else None_vt ()
  ) : s0rtopt_vt // end of [val]
  val ent4 = pif_fun (buf, bt, err, p_EQ, err0)
  val ent5 = pif_fun (buf, bt, err, p_s0exp, err0)
in
  if err = err0 then
    s0expdef_make (ent1, (l2l)ent2, (t2t)ent3, ent5)
  else let
    val () = list_vt_free (ent2)
    val () = option_vt_free (ent3)
  in
    tokbuf_set_ntok_null (buf, n0)
  end // end of [if]
end // end of [p_s0expdef]

implement
p_s0expdefseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_s0expdef)
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
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_sqi0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then pstar_fun (buf, bt, p_s0marg) else list_vt_nil
  ) : s0marglst_vt
  val ent3 = (
    if err = err0 then p_colons0rtopt_vt (buf, bt, err) else None_vt
  ) : s0rtopt_vt // end of [val]
  val ent4 = pif_fun (buf, bt, err, p_EQ, err0)
  val ent5 = pif_fun (buf, bt, err, p_s0exp, err0)
in
  if err = err0 then
    s0aspdec_make (ent1, (l2l)ent2, (t2t)ent3, ent5)
  else let
    val () = list_vt_free (ent2)
    val () = option_vt_free (ent3)
  in
    tokbuf_set_ntok_null (buf, n0)
  end // end of [if]
end // end of [p_s0aspdec]

(* ****** ****** *)

(*
e0xndecseq = e0xndec { AND e0xndec }
*)
implement
p_e0xndecseq
  (buf, bt, err) = let
  val xs = pstar_fun1_AND (buf, bt, err, p_e0xndec)
in
  l2l (xs)
end // end of [p_e0xndecseq]

(* ****** ****** *)

(*
d0atdec ::= si0de s0margseq EQ d0atconseq
*)
fun
p_d0atdec (
  buf: &tokbuf, bt: int, err: &int
) : d0atdec = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_si0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then
      pstar_fun {a0msrt} (buf, bt, p_a0msrt) else list_vt_nil ()
  ) : a0msrtlst_vt // end of [val]
  val ent3 = pif_fun (buf, bt, err, p_EQ, err0)
  val ent4 = pif_fun (buf, bt, err, p_d0atconseq, err0)
in
  if err = err0 then
    d0atdec_make (ent1, (l2l)ent2, ent4)
  else let
    val () = err := err + 1
    val () = list_vt_free (ent2)
  in
    tokbuf_set_ntok_null (buf, n0)
  end (* end of [if] *)
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
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_di0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then
      pstar_fun (buf, bt, p_d0cstarg) else list_vt_nil ()
    // end of [if]
  ) : List_vt (d0cstarg)
  val ent3 = (
    if err = err0 then p_colonwith (buf, bt, err) else None ()
  ) : e0fftaglstopt
  val ent4 = (
    if err = err0 then p_s0exp (buf, bt, err) else synent_null ()
  ) : s0exp // end of [val]
  val ent5 = (
    if err = err0 then
      p_extnamopt (buf, bt, err) else synent_null ()
    // end of [if]
  ) : Stropt // end of [val]
in
  if err = err0 then
    d0cstdec_make (ent1, (l2l)ent2, ent3, ent4, ent5)
  else let
    val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, n0)
  end // end of [if]
end // end of [p_d0cstdec]

implement
p_d0cstdecseq
  (buf, bt, err) = l2l (xs) where {
  val xs = pstar_fun1_AND (buf, bt, err, p_d0cstdec)
} // end of [p_d0cstdecseq]

(* ****** ****** *)

(*
m0acdef ::= di0de m0acargseq EQ d0exp
*)
fun
p_m0acdef (
  buf: &tokbuf, bt: int, err: &int
) : m0acdef = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  val ent1 = p_di0de (buf, bt, err)
  val bt = 0
  val ent2 = (
    if err = err0 then
      pstar_fun (buf, bt, p_m0acarg) else list_vt_nil
    // end of [if]
  ) : List_vt (m0acarg)
  val ent3 = (
    if err = err0 then p_EQ (buf, bt, err) else synent_null ()
  ) : token // end of [val]
  val ent4 = (
    if err = err0 then p_d0exp (buf, bt, err) else synent_null ()
  ) : d0exp // end of [val]
in
  if err = err0 then
    m0acdef_make (ent1, (l2l)ent2, ent4)
  else let
    val () = list_vt_free (ent2) in tokbuf_set_ntok_null (buf, n0)
  end (* end of [if] *)
end // end of [p_m0acdef]

(* ****** ****** *)

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
    val () = incby1 () in i0de_make_string (loc, name)
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
staload ::= LITERAL_string | stai0de EQ LITERAL_string
*)
fun
p_staload_tok (
  buf: &tokbuf, bt: int, err: &int, tok: token
) : d0ecl = let
  val err0 = err
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
    val bt = 0
    val ent3 = pif_fun (buf, bt, err, p_EQ, err0)
    val ent4 = pif_fun (buf, bt, err, p_s0tring, err0)
  in
    if err = err0 then
      d0ecl_staload_some (tok, ent2, ent4)
    else let
(*
      val () = the_parerrlst_add_ifnbt (bt, loc, PE_staload)
*)
    in
      synent_null ()
    end // end of [if]
  end (* end of [_] *)
//
end // end of [p_staload_tok]

(* ****** ****** *)

(*
srpifkind ::= SRPIF | SRPIFDEF | SRPIFNDEF
*)
fun
p_srpifkind (
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
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_srpifkind]

(*
srpelifkind ::= SRPELIF | SRPELIFDEF | SRPELIFNDEF
*)
fun
p_srpelifkind (
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
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_srpelifkind]

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
  | STA s0tacstseq
  | STAVAR s0tavarseq
  | STADEF s0expdefseq
  | TYPEDEF s0expdefseq
  | ASSUME s0aspdec
  | EXCEPTION e0xndecseq
  | DATAYPE d0atdec andd0atdecseq {WHERE s0expdefseq}
  | OVERLOAD di0de WITH dqi0de
  | MACDEF {REC} m0acdefseq
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
| T_FIXITY _ => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_p0rec (buf, bt, err)
    val ent3 = pif_fun (buf, bt, err, p_i0deseq1, err0)
  in
    if err = err0 then
      d0ecl_fixity (tok, ent2, ent3) else synent_null ()
    // end of [if]
  end
| T_NONFIX () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = err0 then
      d0ecl_nonfix (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SYMINTR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0deseq1 (buf, bt, err)
  in
    if err = err0 then
      d0ecl_symintr (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPDEFINE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_i0de (buf, bt, err)
    val ent3 = (
      if err = err0 then
        popt_fun {e0xp} (buf, bt, p_e0xp) else None_vt ()
      // end of [if]
    ) : Option_vt (e0xp) // end of [val]
  in
    if err = err0 then let
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
    if err = err0 then
      d0ecl_e0xpact_assert (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPERROR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0 then
      d0ecl_e0xpact_error (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SRPPRINT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xp (buf, bt, err)
  in
    if err = err0 then
      d0ecl_e0xpact_print (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_DATASORT () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0atsrtdecseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_datsrts (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_SORTDEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0rtdefseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_srtdefs (tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_ABSTYPE (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0taconseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_stacons (knd, tok, ent2) else synent_null ()
    // end of [if]
  end
| T_STACST () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tacstseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_stacsts (tok, ent2) else synent_null ()
    // end of [if]
  end
| T_STAVAR () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tavarseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_stavars (tok, ent2) else synent_null ()
    // end of [if]
  end
//
| T_STADEF () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_sexpdefs (~1(*knd*), tok, ent2) else synent_null ()
    // end of [if]
  end
| T_TYPEDEF (knd) => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0expdefseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_sexpdefs (knd, tok, ent2) else synent_null ()
    // end of [if]
  end
| T_ASSUME () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0aspdec (buf, bt, err)
  in
    if err = err0 then d0ecl_saspdec (tok, ent2) else synent_null ()
  end
| T_EXCEPTION () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_e0xndecseq (buf, bt, err)
  in
    if err = err0 then d0ecl_exndecs (tok, ent2) else synent_null ()
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
| T_OVERLOAD () => let
    val bt = 0
    val () = incby1 ()
    val ~SYNENT3 (ent1, ent2, ent3) =
      pseq3_fun {i0de,token,dqi0de} (buf, bt, err, p_di0de, p_WITH, p_dqi0de)
    // end of [val]
  in
    if err = err0 then
      d0ecl_overload (tok, ent1, ent3) else synent_null ()
    // end of [val]
  end
//
| T_MACDEF (knd) => let
    val bt = 0
    val () = incby1 ()
    var _ent: synent?
    val isrec = ptest_fun (buf, p_REC, _ent)
    val ent3 = pstar_fun1_AND {m0acdef} (buf, bt, err, p_m0acdef)
  in
    if err = err0 then
      d0ecl_macdefs (knd, isrec, tok, (l2l)ent3)
    else let
      val () = list_vt_free (ent3) in synent_null ()
    end (* end of [if] *)
  end
//
| T_STALOAD () => let
    val bt = 0
    val () = incby1 ()
  in
    p_staload_tok (buf, bt, err, tok)
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

fun
p_d0eclseq_fun
  {a:type} (
  buf: &tokbuf, bt: int, f: parser a
) : List_vt (a) = let
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
        val+ list_vt_cons (_, !p_res1) = res
//
        val semilst = pstar_fun {token} (buf, bt, p_SEMICOLON)
        val () = list_vt_free (semilst)
//
        val () = loop (buf, !p_res1, err)
        prval () = fold@ (res)
      } // end of [_]
  end // end of [loop]
  var res: res_vt
  var err: int = 0
  val () = loop (buf, res, err)
in
  res (* properly ordered *)
end // end of [p_d0eclseq_fun]

(* ****** ****** *)

(*
srpthenopt ::= { SRPTHEN }
*)
fun p_srpthenopt (
  buf: &tokbuf, bt: int
) : token = tok where {
  var err: int = 0
  val tok = p_SRPTHEN (buf, bt, err)
} // end of [p_srpthenopt]

(* ****** ****** *)

(*
guad0ecl_fun
  | e0xp srpthenopt d0eclseq_fun SRPENDIF
  | e0xp srpthenopt d0eclseq_fun SRPELSE d0eclseq_fun SRPENDIF
  | e0xp srpthenopt d0eclseq_fun srpelifkind guad0ecl_fun
*)
fun guad0ecl_fun (
  buf: &tokbuf
, bt: int, err: &int, f: parser (d0ecl)
) : guad0ecl = let
  val err0 = err
  val n0 = tokbuf_get_ntok (buf)
  var ent: synent?
  macdef incby1 () = tokbuf_incby1 (buf)
//
  val ent1 = p_e0xp (buf, bt, err)
  val bt = 0
  val _(*ent2*) = (
    if err = err0 then p_srpthenopt (buf, bt) else synent_null ()
  ) : token // end of [val]
  val ent3 = (
    if err = err0 then p_d0eclseq_fun (buf, bt, f) else list_vt_nil ()
  ) : List_vt (d0ecl)
//
  val bt = 0
  val tok = tokbuf_get_token (buf)
in
//
if err = err0 then
//
case+ tok.token_node of
| T_SRPENDIF () => let
    val () = incby1 () in guad0ecl_one (ent1, (l2l)ent3, tok)
  end
| T_SRPELSE () => let
    val () = incby1 ()
    val ent5 = p_d0eclseq_fun {d0ecl} (buf, bt, f)
    val ent6 = p_SRPENDIF (buf, bt, err)
  in
    if err = err0 then
      guad0ecl_two (ent1, (l2l)ent3, (l2l)ent5, ent6)
    else let
      val () = list_vt_free (ent3)
      val () = list_vt_free (ent5)
    in
      tokbuf_set_ntok_null (buf, n0)
    end // end of [if]
  end
| _ when
    ptest_fun (
      buf, p_srpelifkind, ent
    ) => let
    val ent5 = guad0ecl_fun (buf, bt, err, f)
  in
    if err = err0 then
      guad0ecl_cons (ent1, (l2l)ent3, tok, ent5)
    else let
      val () = list_vt_free (ent3)
    in
      tokbuf_set_ntok_null (buf, n0)
    end // end of [if]
  end
| _ => let
    val () = err := err + 1
    val () = list_vt_free (ent3)
    val () = the_parerrlst_add_ifnbt (bt, tok.token_loc, PE_guad0ecl)
  in
    tokbuf_set_ntok_null (buf, n0)
  end // end of [_]
//
else let
  val () = list_vt_free (ent3) in tokbuf_set_ntok_null (buf, n0)
end // end of [if]
//
end // end of [guad0ecl_fun]

(* ****** ****** *)

(*
d0ecl_sta
  | d0ecl
  | FUN(knd) q0margseq d0cstdecseq
  | LITERAL_extcode
  | SRPINCLUDE LITERAL_string
  | LOCAL d0eclseq_sta IN d0eclseq_sta END
  | srpifkind guad0ecl_sta
*)

fun p_d0ecl_sta_tok (
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
  ) => synent_decode (ent)
| _ when
    ptest_fun (
    buf, p_dcstkind, ent
  ) => let
    val bt = 0
    val ent2 = pstar_fun {q0marg} (buf, bt, p_q0marg)
    val ent3 = p_d0cstdecseq (buf, bt, err)
  in
    if err = err0 then
      d0ecl_dcstdecs (tok, (l2l)ent2, ent3)
    else let
      val () = list_vt_free (ent2) in synent_null ()
    end // end of [if]
  end
| T_EXTCODE _ => let
    val () = incby1 () in d0ecl_extcode (0(*sta*), tok)
  end
| T_SRPINCLUDE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0 then
      d0ecl_include (0(*sta*), tok, ent2) else synent_null ()
    // end of [if]
  end
| T_LOCAL () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_fun {d0ecl} (buf, bt, p_d0ecl_sta)
    val ent3 = (
      if err = err0 then p_IN (buf, bt, err) else synent_null ()
    ) : token // end of [val]
    val ent4 = (
      if err = err0 then
        p_d0eclseq_fun (buf, bt, p_d0ecl_sta) else list_vt_nil ()
    ) : d0eclist_vt // end of [val]
    val ent5 = (
      if err = err0 then p_END (buf, bt, err) else synent_null ()
    ) : token // end of [val]
  in
    if err = err0 then
      d0ecl_local (tok, (l2l)ent2, (l2l)ent4, ent5)
    else let
      val () = list_vt_free (ent2)
      val () = list_vt_free (ent4)
    in
      synent_null ()
    end // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_srpifkind, ent
  ) => let
    val ent1 = synent_decode {token} (ent)
    val ent2 = guad0ecl_fun (buf, bt, err, p_d0ecl_sta)
  in
    if err = err0 then
      d0ecl_guadecl (ent1, ent2) else synent_null ()
    // end of [if]
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end
//
end // end of [p_d0ecl_sta_tok]

implement
p_d0ecl_sta
  (buf, bt, err) =
  ptokwrap_fun (buf, bt, err, p_d0ecl_sta_tok, PE_d0ecl_sta)
// end of [p_d0ecl_sta]

(* ****** ****** *)

(*
v0aldec ::= p0at EQ d0exp witht0ypeopt
*)
fun p_v0aldec (
  buf: &tokbuf, bt: int, err: &int
) : v0aldec = let
  val err0 = err
  val ~SYNENT3 (ent1, ent2, ent3) =
    pseq3_fun {p0at,token,d0exp} (buf, bt, err, p_p0at, p_EQ, p_d0exp)
  // end of [val]
in
  if err = err0 then let
    val ent4 =
      p_witht0ype (buf, bt, err) in v0aldec_make (ent1, ent3, ent4)
  end else synent_null ()
end // end of [p0valdec]

(* ****** ****** *)

(*
d0ec_dyn
  | d0ec
  | EXTERN d0cstdecseq
  | EXTERN TYPEDEF LITERAL_string EQ s0exp
  | EXTERN VAL LITERAL_string EQ d0exp
  | valkind {REC} v0aldecseq
/*
  | VAL PAR v0aldecseq
*/
  | funkind f0undecseq
  | VAR v0ardecseq
  | IMPLEMENT decs0argseqseq i0mpdec
  | LOCAL d0ecseq_dyn IN d0ecseq_dyn END
  | LITERAL_extcode
  | SRPINCLUDE LITERAL_string
  | DYNLOAD LITERAL_string
  | srpifkind guad0ec_dyn
*)

fun p_d0ecl_dyn_tok (
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
    if err = err0 then
      d0ecl_valdecs (knd, isrec, tok, (l2l)ent3)
    else let
      val () = list_vt_free (ent3) in synent_null ()
    end (* end of [if] *)
  end
| T_EXTCODE _ => let
    val () = incby1 () in d0ecl_extcode (1(*dyn*), tok)
  end
| T_SRPINCLUDE () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_s0tring (buf, bt, err)
  in
    if err = err0 then
      d0ecl_include (1(*dyn*), tok, ent2) else synent_null ()
    // end of [if]
  end
| T_LOCAL () => let
    val bt = 0
    val () = incby1 ()
    val ent2 = p_d0eclseq_fun {d0ecl} (buf, bt, p_d0ecl_dyn)
    val ent3 = pif_fun (buf, bt, err, p_IN, err0)
    val ent4 = (
      if err = err0 then
        p_d0eclseq_fun (buf, bt, p_d0ecl_dyn) else list_vt_nil ()
    ) : d0eclist_vt
    val ent5 = (
      if err = err0 then p_END (buf, bt, err) else synent_null ()
    ) : token // end of [val]
  in
    if err = err0 then
      d0ecl_local (tok, (l2l)ent2, (l2l)ent4, ent5)
    else let
      val () = list_vt_free (ent2)
      val () = list_vt_free (ent4)
    in
      synent_null ()
    end // end of [if]
  end
| _ when
    ptest_fun (
    buf, p_srpifkind, ent
  ) => let
    val ent1 = synent_decode {token} (ent)
    val ent2 = guad0ecl_fun (buf, bt, err, p_d0ecl_dyn)
  in
    if err = err0 then
      d0ecl_guadecl (ent1, ent2) else synent_null ()
    // end of [if]
  end
| _ => let
    val () = err := err + 1 in synent_null ()
  end
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

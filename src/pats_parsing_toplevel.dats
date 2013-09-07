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
// Start Time: April, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fun pskip_tokbuf
  (buf: &tokbuf): token = let
  val tok = tokbuf_get_token (buf)
(*
  val () = println! ("pskip_tokbuf: tok = ", tok)
*)
in
//
case+ tok.token_node of
| T_EOF () => tok
//
| T_SORTDEF () => tok
| T_DATASORT () => tok
//
| T_ABSTYPE _ => tok
| T_ASSUME () => tok
| T_STACST () => tok
| T_STADEF () => tok
| T_TYPEDEF _ => tok
| T_DATATYPE _ => tok
| T_EXCEPTION () => tok
//
| T_FUN _ => tok
| T_VAL _ => tok
| T_VAR _ => tok
//
| T_IMPLEMENT (knd) => tok
//
| T_FIXITY _ => tok
| T_NONFIX () => tok
| T_SYMINTR () => tok
| T_SYMELIM () => tok
//
| T_EXTERN () => tok
| T_LOCAL () => tok
| T_STALOAD () => tok
| T_DYNLOAD () => tok
//
| T_SRPASSERT () => tok
| T_SRPERROR () => tok
| T_SRPPRINT () => tok
| T_SRPDEFINE () => tok
| T_SRPIF () => tok
| T_SRPIFDEF () => tok
| T_SRPIFNDEF () => tok
| T_SRPINCLUDE () => tok
| T_SRPUNDEF () => tok
//
| _ => let
    val () = tokbuf_incby1 (buf) in pskip_tokbuf (buf)
  end (* end of [_] *)
//
end // end of [pskip_tokbuf]

fun pskip1_tokbuf_reset
  (buf: &tokbuf): token = let
//
val tok = tokbuf_get_token (buf)
//
val () =
(
case+
  tok.token_node of
| T_EOF ((*void*)) => ()
| tnode
  when tnode_is_comment (tnode) => ()
| _ => {
    val loc = tok.token_loc
    val err = parerr_make (loc, PE_DISCARD)
    val ((*void*)) = the_parerrlst_add (err)
  } // end of [_]
) : void // end of [val]
//
val () = tokbuf_incby1 (buf)
//
val tok = pskip_tokbuf (buf)
//
val ((*void*)) = tokbuf_reset (buf)
//
in
  tok
end // end of [pskip1_tokbuf_reset]

(* ****** ****** *)

fun
p_toplevel_fun
(
  buf: &tokbuf
, nerr: &int? >> int
, f: parser (d0ecl)
) : d0eclist = let
  typedef a = d0ecl
  fun loop (
    buf: &tokbuf
  , res: &d0eclist_vt? >> d0eclist_vt
  , nerr: &int
  , f: parser (d0ecl)
  ) : void = let
    val nerr0 = nerr
    val x = f (buf, 1(*bt*), nerr)
  in
    case+ 0 of
    | _ when
        nerr > nerr0 => let
        val tok0 = tokbuf_get_token (buf)
//
        val () = (
          case+ tok0.token_node of
          | T_EOF () => (nerr := nerr0) // HX: there is no error
          | _ => ()
        ) : void // end of [val]
//
        val tok = pskip1_tokbuf_reset (buf)
//
      in
        case+ tok.token_node of
        | T_EOF () => res := list_vt_nil () | _ => loop (buf, res, nerr, f)
      end // end of [_ when ...]
    | _ (*noerror*) => let
//
        val () = tokbuf_reset (buf)
//
        val semilst = pstar_fun {token} (buf, 1(*bt*), p_SEMICOLON)
        val () = list_vt_free (semilst)
//
        val () =
          res := list_vt_cons{a}{0}(x, ?)
        // end of [val]
        val+list_vt_cons (_, !p_res1) = res
        val () = loop (buf, !p_res1, nerr, f)
        prval () = fold@ (res)
      in
        // nothing
      end // end of [_]
   end (* end of [loop] *)
  val () = nerr := 0
  var res: d0eclist_vt
  val () = loop (buf, res, nerr, f)
//
  val _(*EOF*) = p_EOF (buf, 0, nerr) // HX: no more tokens 
//
in
  list_of_list_vt(res)
end // end of [p_toplevel_fun]

(* ****** ****** *)

implement
p_toplevel_sta (buf, nerr) = p_toplevel_fun (buf, nerr, p_d0ecl_sta)
implement
p_toplevel_dyn (buf, nerr) = p_toplevel_fun (buf, nerr, p_d0ecl_dyn)

(* ****** ****** *)

(* end of [pats_parsing_toplevel.dats] *)

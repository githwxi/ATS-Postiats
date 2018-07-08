(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)
//
staload
DA = "libats/SATS/dynarray.sats"
staload
_(*DA*) = "libats/DATS/dynarray.dats"
//
(* ****** ****** *)

assume tokbuf_vt0ype = _tokbuf_vt0ype

(* ****** ****** *)

implement
tokbuf_initize_string
  (buf, inp) = let
//
#define TOKBUFSZ 1024
//
val () = buf.tokbuf_ntok := i2sz(0)
val () = buf.tokbuf_tkbf := $DA.dynarray_make_nil(i2sz(TOKBUFSZ))
//
val () = lexbuf_initize_string(buf.tokbuf_lxbf, inp)
//
in
  // nothing
end // end of [tokbuf_initize_string]

(* ****** ****** *)

implement
tokbuf_initize_fileref
  (buf, inp) = let
//
#define TOKBUFSZ 1024
//
val () = buf.tokbuf_ntok := i2sz(0)
val () = buf.tokbuf_tkbf := $DA.dynarray_make_nil(i2sz(TOKBUFSZ))
val () = lexbuf_initize_fileref (buf.tokbuf_lxbf, inp)
//
in
  // nothing
end // end of [tokbuf_initize_fileref]

(* ****** ****** *)

implement
tokbuf_reset
  (buf) = () where
{
  val ntok = buf.tokbuf_ntok
  val ((*void*)) = buf.tokbuf_ntok := i2sz(0)
//
  val ntok2 =
    $DA.dynarray_removeseq_at(buf.tokbuf_tkbf, i2sz(0), ntok)
  // end of [val]
//
} (* end of [tokbuf_reset] *)

(* ****** ****** *)

implement
tokbuf_uninitize
  (buf) = () where
{
//
val () =
  $DA.dynarray_free(buf.tokbuf_tkbf)
//
val () = lexbuf_uninitize(buf.tokbuf_lxbf)
//
} (* end of [tokbuf_uninitize] *)

(* ****** ****** *)
//
implement
tokbuf_get_ntok(buf) = buf.tokbuf_ntok
implement
tokbuf_set_ntok(buf, ntok) = buf.tokbuf_ntok := ntok
//
(* ****** ****** *)
//
implement
tokbuf_incby_1
  (buf) =
(
buf.tokbuf_ntok :=
  succ(buf.tokbuf_ntok)
)
//
implement
tokbuf_incby_n
  (buf, n) = let
//
val n0 = buf.tokbuf_ntok
//
in
  buf.tokbuf_ntok := n0 + n
end // tokbuf_incby_n
//
implement
tokbuf_decby_n
  (buf, n) = let
//
val n0 = buf.tokbuf_ntok
//
in
//
if
(n0 >= n)
then buf.tokbuf_ntok := n0 - n
else buf.tokbuf_ntok := i2sz(0)
//
end // end of [tokbuf_decby_n]
//
(* ****** ****** *)

implement
tokbuf_get_token
  (buf) = let
//
val ntok = buf.tokbuf_ntok
val ptok =
  $DA.dynarray_getref_at(buf.tokbuf_tkbf, ntok)
//
in
//
if
isneqz(ptok)
then $UN.cptr_get<token>(ptok)
else let
//
val tok =
  lexbuf_get_token(buf.tokbuf_lxbf)
//
val ((*void*)) =
  $DA.dynarray_insert_atend_exn(buf.tokbuf_tkbf, tok)
//
in
  tok
end // end of [else]
//
end // end of [tokbuf_get_token]

(* ****** ****** *)

implement
tokbuf_getinc_token
  (buf) = tok where
{
  val tok = tokbuf_get_token(buf)
  val ((*void*)) = tokbuf_incby_1(buf)
} (* end of [tokbuf_getinc_token] *)

(* ****** ****** *)

implement
tokbuf_get_location(buf) =
  let val tok = tokbuf_get_token(buf) in tok.token_loc end
// end of [tokbuf_get_location]

(* ****** ****** *)

(* end of [atexting_tokbuf.dats] *)

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

staload "./atexting.sats"

(* ****** ****** *)
//
staload _ =
"libats/DATS/stringbuf.dats"
//
staload _ =
"{$LIBATSHWXI}/cstream/DATS/cstream.dats"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)

assume
lexbuf_vt0ype = _lexbuf_vt0ype

(* ****** ****** *)

implement
lexbuf_initize_fileref
  (buf, inp) = () where
{
//
#define BUFCAP 1024
//
val
cs0 =
$CS0.cstream_make_fileref(inp)
val
sbf =
$SBF.stringbuf_make_nil(i2sz(BUFCAP))
//
val () = buf.lexbuf_ntot := 0
val () = buf.lexbuf_nrow := 0
val () = buf.lexbuf_ncol := 0
//
val () = buf.lexbuf_nspace := 0
//
val () = buf.lexbuf_cstream := cs0
//
val () = buf.lexbuf_nback := 0
val () = buf.lexbuf_stringbuf := sbf
//
} (* end of [lexbuf_initize_fileref] *)

(* ****** ****** *)

implement
lexbuf_uninitize
  (buf) = () where
{
//
val () =
$CS0.cstream_free (buf.lexbuf_cstream)
val () =
$SBF.stringbuf_free (buf.lexbuf_stringbuf)
//
} (* end of [lexbuf_uninitize] *)

(* ****** ****** *)

(* end of [atexting_lexbuf.dats] *)

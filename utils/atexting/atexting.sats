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

#define
ATS_PACKNAME "ATEXTING"

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
DA =
"libats/SATS/dynarray.sats"
//
stadef dynarray = $DA.dynarray
//
(* ****** ****** *)
//
staload
SBF =
"libats/SATS/stringbuf.sats"
//
stadef stringbuf = $SBF.stringbuf
//
(* ****** ****** *)
//
staload
CS0 =
"{$LIBATSHWXI}\
/cstream/SATS/cstream.sats"
//
vtypedef cstream = $CS0.cstream
//
(* ****** ****** *)
//
abstype
filename_type = ptr
typedef
filename = filename_type
typedef fil_t = filename
//
val filename_dummy : fil_t
val filename_stdin : fil_t
//
fun
filename_make(path: string): fil_t
//
fun
fprint_filename : fprint_type(fil_t)
//
overload fprint with fprint_filename
//
(* ****** ****** *)
//
fun the_filename_get((*void*)): fil_t
//
fun the_filename_pop((*void*)): fil_t
fun the_filename_push(fil: fil_t): void
//
(* ****** ****** *)
//
typedef
position =
@{
, pos_ntot= int
, pos_nrow= int
, pos_ncol= int
} (* end of [position] *)
//
fun
fprint_position
(
  out: FILEref, pos: &position
) : void // end-of-function
//
overload fprint with fprint_position
//
fun position_byrow(&position >> _): void
//
fun position_incby_1(&position >> _): void
fun position_incby_n(&position >> _, n: intGte(0)): void
fun position_decby_n(&position >> _, n: intGte(0)): void
//
overload .incby with position_incby_1
overload .incby with position_incby_n
//
overload .decby with position_decby_n
//
(* ****** ****** *)

fun position_incby_char(&position >> _, c: int): void

(* ****** ****** *)
//
abstype
location_type = ptr
typedef
location = location_type
typedef loc_t = location
//
val location_dummy : loc_t
//
fun
fprint_location : fprint_type(loc_t)
//
overload fprint with fprint_location
//
fun
fprint_locrange : fprint_type(loc_t)
//
(* ****** ****** *)
//
fun
location_make_pos_pos
  (pos1: &position, pos2: &position): loc_t
fun
location_make_fil_pos_pos
  (fil: fil_t, pos1: &position, pos2: &position): loc_t
//
(* ****** ****** *)
//
fun
location_combine (loc1: loc_t, loc2: loc_t): loc_t
//
(* ****** ****** *)
//
datatype
token_node =
//
| TOKeof of ()
//
| TOKint of (string)
//
| TOKide of (string)
//
| TOKsym of (string)
//
| TOKspchr of (int)
//
| TOKsquote of ()
| TOKdquote of (string)
//
| TOKcode_beg of (string)
| TOKcode_end of (string)
//
| TOKspace of (string)
| TOKnewline of ((*void*))
//
where
token = $rec{
  token_loc= loc_t
, token_node= token_node
} (* end of [token] *)
//
and tokenlst = List0(token)
//
(* ****** ****** *)
//
typedef tnode = token_node
//
(* ****** ****** *)
//
fun token_get_loc(token): loc_t
//
fun token_make(loc_t, tnode): token
//
(* ****** ****** *)
//
fun
fprint_token : fprint_type(token)
fun
fprint_tnode : fprint_type(tnode)
fun
fprint_tokenlst : fprint_type(tokenlst)
//
overload fprint with fprint_token
//
(* ****** ****** *)
//
vtypedef
_lexbuf_vt0ype =
@{
//
lexbuf_ntot= int
,
lexbuf_nrow= int
,
lexbuf_ncol= int
,
//
lexbuf_nspace= int
//
,
//
lexbuf_cstream= cstream
//
,
lexbuf_nback= int
,
lexbuf_stringbuf= stringbuf
//
} // end of [_lexbuf_vt0ype]

(* ****** ****** *)
//
absvt@ype
lexbuf_vt0ype = _lexbuf_vt0ype
//
vtypedef lexbuf = lexbuf_vt0ype
//
(* ****** ****** *)
fun
lexbuf_initize_fileref
(
  buf: &lexbuf? >> _, inp: FILEref
) : void // end-of-function
//
(* ****** ****** *)

fun
lexbuf_uninitize(buf: &lexbuf >> _?): void

(* ****** ****** *)
//
fun
lexbuf_get_position
(
  buf: &RD(lexbuf), pos: &position? >> _
) : void // end-of-function
//
fun
lexbuf_set_position
(
  buf: &lexbuf >> _, pos0: &RD(position)
) : void // end-of-function

(* ****** ****** *)
//
fun
lexbuf_set_nback(buf: &lexbuf, nb: int): void
fun
lexbuf_incby_nback(buf: &lexbuf, nb: int): void
//
(* ****** ****** *)
//
fun
lexbuf_get_nspace (buf: &lexbuf): int
fun
lexbuf_set_nspace (buf: &lexbuf, n: int): void
//
(* ****** ****** *)
//
fun
lexbuf_remove
  (buf: &lexbuf >> _, nchr: intGte(0)): void
//
fun lexbuf_remove_all (buf: &lexbuf >> _): void
//
(* ****** ****** *)
//
fun
lexbuf_takeout
  (buf: &lexbuf >> _, nchr: intGte(0)): Strptr1
//
(* ****** ****** *)

fun lexbuf_get_char (buf: &lexbuf >> _): int

(* ****** ****** *)

fun lexbuf_get_token_any (buf: &lexbuf >> _): token
fun lexbuf_get_token_skip (buf: &lexbuf >> _): token

(* ****** ****** *)
//
fun
lexbufpos_get_location(buf: &lexbuf, pos: &position) : loc_t
//
fun
lexbuf_getbyrow_location(buf: &lexbuf): loc_t
fun
lexbuf_getincby_location(buf: &lexbuf, nchr: intGte(0)): loc_t
//
(* ****** ****** *)
//
fun
lexing_INTEGER(buf: &lexbuf): token
//
fun
lexing_IDENT_alp(buf: &lexbuf): token
//
(* ****** ****** *)

(* end of [atexting.sats] *)

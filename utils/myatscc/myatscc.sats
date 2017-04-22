(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: April, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
(*
HX-2017-04-22:
This is the default used by [myatscc]
*)
//
#define
MYATSCCDEF
"patscc -DATS_MEMALLOC_LIBC -o $fname($1) $1"
//
(* ****** ****** *)
//
abstype
location_type = ptr
typedef
location = location_type
//
(* ****** ****** *)
//
datatype
token_node =
  TOKide of string
| TOKint of ( int )
| TOKspchr of char
//
where token = $rec{ loc= location, tok=token_node }
//
(* ****** ****** *)

(* end of [myatscc.sats] *)

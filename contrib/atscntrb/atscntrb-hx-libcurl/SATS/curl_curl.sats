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
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: September, 2013
*)

(* ****** ****** *)
//
/*
const char
*curl_easy_strerror(CURLcode);
*/
fun
curl_easy_strerror(CURLcode): string = "mac#%"
//
(* ****** ****** *)

/*
CURLcode
curl_global_init(long flags);
*/
fun
curl_global_init(flags: lint): CURLcode = "mac#%"
//
(* ****** ****** *)
  
macdef
CURL_GLOBAL_DEFAULT =
$extval(lint, "CURL_GLOBAL_DEFAULT")
  
(* ****** ****** *)
//
/*
void curl_global_cleanup(void) ;
*/
fun curl_global_cleanup((*void*)): void = "mac#%"
//
(* ****** ****** *)

(* end of [curl_curl.sats] *)

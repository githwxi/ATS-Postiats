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
** Author: Hongwei Xi // MPZ and MPQ
** Authoremail: hwxi AT cs DOT bu DOT edu
*)

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libcurl"
#define ATS_STALOADFLAG 0 // no static loading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libcurl_" // prefix for external names

(* ****** ****** *)

%{#
#include "libcurl/CATS/curl.cats"
%} // end of [%{#]

(* ****** ****** *)

absvtype
CURLptr_vtype (l:addr) = ptr

(* ****** ****** *)

vtypedef
CURLptr (l:addr) = CURLptr_vtype (l)
vtypedef
CURLptr0 = [l:agez] CURLptr_vtype (l)
vtypedef
CURLptr1 = [l:addr | l > null] CURLptr_vtype (l)

(* ****** ****** *)

abst@ype CURLcode = $extype"CURLcode"

(* ****** ****** *)

/*
CURL *curl_easy_init();
*/
fun curl_easy_init (): CURLptr0 = "mac#%"
fun curl_easy_init_exn (): CURLptr1 = "mac#%"

(* ****** ****** *)

fun curl_easy_cleanup (curl: CURLptr1): void = "mac#%"

(* ****** ****** *)

/*
CURLcode
curl_easy_send
(
  CURL *curl , const void * buffer , size_t buflen , size_t *n
) ; // end of [curl_easy_send]
*/
fun curl_easy_send
  {m:int}{n:nat | n <= m}
(
  curl: !CURLptr1, buf: &bytes(m), len: size_t(m), n: &size_t(n) >> size_t(n2)
) : #[n2:int] CURLcode // end of [curl_easy_send]

(* ****** ****** *)

fun curl_version ((*void*)): string = "mac#%"

(* ****** ****** *)

(* end of [curl.sats] *)

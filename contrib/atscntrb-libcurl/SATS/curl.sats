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

%{#
#include \
"atscntrb-libcurl/CATS/curl.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.curl"
#define
ATS_EXTERN_PREFIX "atscntrb_curl_" // prefix for external names
//
(* ****** ****** *)
//
fun
curl_version(): string = "mac#%"
//
(* ****** ****** *)

absvtype CURLptr_vtype(l:addr) = ptr

(* ****** ****** *)
//
vtypedef
CURLptr(l:addr) = CURLptr_vtype(l)
vtypedef
CURLptr0 = [l:agez] CURLptr_vtype(l)
vtypedef
CURLptr1 = [l:addr | l > null] CURLptr_vtype(l)
//
(* ****** ****** *)
//
castfn
CURLptr2ptr
  {l:addr}(curl: !CURLptr(l)):<> ptr(l)
//
overload ptrcast with CURLptr2ptr
//
(* ****** ****** *)
//
abst0ype CURLcode = $extype"CURLcode"
absvt0ype CURLerror = $extype"CURLcode"
//
(* ****** ****** *)
//
castfn
CURLerror2code(err: CURLerror):<> CURLcode
//
(* ****** ****** *)
//
fun
eq_CURLcode_CURLcode
  (CURLcode, CURLcode):<> bool = "mac#%"
fun
neq_CURLcode_CURLcode
  (CURLcode, CURLcode):<> bool = "mac#%"
//
overload = with eq_CURLcode_CURLcode
overload != with neq_CURLcode_CURLcode
//
fun
eq_CURLerror_CURLcode
  (CURLerror, CURLcode):<> bool = "mac#%"
fun
neq_CURLerror_CURLcode
  (CURLerror, CURLcode):<> bool = "mac#%"
//
overload = with eq_CURLerror_CURLcode
overload != with neq_CURLerror_CURLcode
//
(* ****** ****** *)

macdef
CURLE_OK = $extval(CURLcode, "CURLE_OK")

(* ****** ****** *)
//
typedef CURL = lint
//
macdef
CURL_GLOBAL_ALL = $extval(CURL, "CURL_GLOBAL_ALL")
macdef
CURL_GLOBAL_SSL = $extval(CURL, "CURL_GLOBAL_SSL")
macdef
CURL_GLOBAL_WIN32 = $extval(CURL, "CURL_GLOBAL_WIN32")
//
(* ****** ****** *)
//
abst@ype CURLOPT = $extype"CURLOPT"
abst@ype CURLINFO = $extype"CURLINFO"
//
(* ****** ****** *)
//
macdef CURLOPT_URL = $extval(CURLOPT, "CURLOPT_URL") // 2
macdef CURLOPT_FILE = $extval(CURLOPT, "CURLOPT_FILE") // 1
macdef CURLOPT_PORT = $extval(CURLOPT, "CURLOPT_PORT") // 3
macdef CURLOPT_PROXY = $extval(CURLOPT, "CURLOPT_PROXY") // 4
macdef CURLOPT_USERPWD = $extval(CURLOPT, "CURLOPT_USERPWD") // 5
macdef CURLOPT_PROXYUSERPWD = $extval(CURLOPT, "CURLOPT_PROXYUSERPWD") // 6
macdef CURLOPT_RANGE = $extval(CURLOPT, "CURLOPT_RANGE") // 7
// HX: [8] is not used
macdef CURLOPT_INFILE = $extval(CURLOPT, "CURLOPT_INFILE") // 9
macdef CURLOPT_ERRORBUFFER = $extval(CURLOPT, "CURLOPT_ERRORBUFFER") // 10
macdef CURLOPT_WRITEFUNCTION = $extval(CURLOPT, "CURLOPT_WRITEFUNCTION") // 11
macdef CURLOPT_READFUNCTION = $extval(CURLOPT, "CURLOPT_READFUNCTION") // 12
macdef CURLOPT_TIMEOUT = $extval(CURLOPT, "CURLOPT_TIMEOUT") // 13
macdef CURLOPT_INFILESIZE = $extval(CURLOPT, "CURLOPT_INFILESIZE") // 14
macdef CURLOPT_POSTFIELDS = $extval(CURLOPT, "CURLOPT_POSTFIELDS") // 15
macdef CURLOPT_REFERER = $extval(CURLOPT, "CURLOPT_REFERER") // 16
macdef CURLOPT_FTPPORT = $extval(CURLOPT, "CURLOPT_FTPPORT") // 17
macdef CURLOPT_USERAGENT = $extval(CURLOPT, "CURLOPT_USERAGENT") // 18
//
macdef CURLOPT_READDATA = $extval(CURLOPT, "CURLOPT_READDATA") // = CURLOPT_INFILE
macdef CURLOPT_WRITEDATA = $extval(CURLOPT, "CURLOPT_WRITEDATA") // = CURLOPT_FILE
//
macdef CURLOPT_SSL_VERIFYPEER = $extval(CURLOPT, "CURLOPT_SSL_VERIFYPEER")
macdef CURLOPT_SSL_VERIFYHOST = $extval(CURLOPT, "CURLOPT_SSL_VERIFYHOST")
//
(* ****** ****** *)
//
macdef CURLINFO_TEXT = $extval(CURLINFO, "CURLINFO_TEXT")
macdef CURLINFO_HEADER_IN = $extval(CURLINFO, "CURLINFO_HEADER_IN")
macdef CURLINFO_HEADER_OUT = $extval(CURLINFO, "CURLINFO_HEADER_OUT")
macdef CURLINFO_DATA_IN = $extval(CURLINFO, "CURLINFO_DATA_IN")
macdef CURLINFO_DATA_OUT = $extval(CURLINFO, "CURLINFO_DATA_OUT")
//
(* ****** ****** *)
//
macdef CURLINFO_SSL_DATA_IN = $extval(CURLINFO, "CURLINFO_SSL_DATA_IN")
macdef CURLINFO_SSL_DATA_OUT = $extval(CURLINFO, "CURLINFO_SSL_DATA_OUT")
//
(* ****** ****** *)

#include "./curl_curl.sats"
#include "./curl_easy.sats"

(* ****** ****** *)

(* end of [curl.sats] *)

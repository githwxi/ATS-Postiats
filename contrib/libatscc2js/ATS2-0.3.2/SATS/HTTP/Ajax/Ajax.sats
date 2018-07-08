(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: September, 2014
*)

(* ****** ****** *)
//
(*
#define
ATS_STALOADFLAG 0
*)
//
#define
ATS_EXTERN_PREFIX
"ats2js_Ajax_" // prefix for external names
//
(* ****** ****** *)
//
#staload
"./../../../basics_js.sats"
//
(* ****** ****** *)
//
#staload
"./../../XMLDOC/XMLDOC.sats"
//
typedef Xmldoc = Xmldoc
typedef Xmldoclst = Xmldoclst
typedef Xmldocopt = Xmldocopt
//
(* ****** ****** *)
//
abstype
XMLHttpRequest_type
typedef
XMLHttpRequest = XMLHttpRequest_type
//
(* ****** ****** *)
//
fun
XMLHttpRequest_new
  ((*void*)): XMLHttpRequest = "mac#%"
//
(* ****** ****** *)
//
fun
XMLHttpRequest_open
(
  XMLHttpRequest
, method: string, URL: string, async: bool
) : void = "mac#%" // end-of-fun
//
fun
XMLHttpRequest_send_0
  (XMLHttpRequest): void = "mac#%"
fun
XMLHttpRequest_send_1
  (XMLHttpRequest, msg: string): void = "mac#%"
//
overload .open with XMLHttpRequest_open
overload .send with XMLHttpRequest_send_0
overload .send with XMLHttpRequest_send_1
//
(* ****** ****** *)
//
fun
XMLHttpRequest_setRequestHeader
  (XMLHttpRequest, header: string, value: string): void = "mac#%"
//
overload .setRequestHeader with XMLHttpRequest_setRequestHeader
//
(* ****** ****** *)
//
fun
XMLHttpRequest_get_responseXML
  (XMLHttpRequest): Xmldoc = "mac#%"
//
overload .responseXML with XMLHttpRequest_get_responseXML
//
fun
XMLHttpRequest_get_responseText
  (XMLHttpRequest): string = "mac#%"
//
overload .responseText with XMLHttpRequest_get_responseText
//
(* ****** ****** *)
//
fun
XMLHttpRequest_get_status
  (xmlhttpreq: XMLHttpRequest): int = "mac#%"
//
overload .status with XMLHttpRequest_get_status
//
fun
XMLHttpRequest_get_readyState
  (xmlhttpreq: XMLHttpRequest): int = "mac#%"
//
overload .readyState with XMLHttpRequest_get_readyState
//
fun
XMLHttpRequest_set_onreadystatechange
  (xmlhttpreq: XMLHttpRequest, f_action: cfun(void)): void = "mac#%"
//
overload .onreadystatechange with XMLHttpRequest_set_onreadystatechange
//
(* ****** ****** *)
//
// HX-2014-09: Some convenience functions
//
(* ****** ****** *)
//
fun
XMLHttpRequest_is_ready_okay
  (xmlhttpreq: XMLHttpRequest): bool = "mac#%"
//
overload .is_ready_okay with XMLHttpRequest_is_ready_okay
//
(* ****** ****** *)

(* end of [Ajax.sats] *)

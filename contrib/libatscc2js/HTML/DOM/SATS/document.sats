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
//
// HX-2017-11-25:
// Common functions
// for manipulating DOM objects
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "ats2js_HTML_"
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
#staload
"{$LIBATSCC2JS}/basics_js.sats"
#staload
"{$LIBATSCC2JS}/SATS/XMLDOC/xmldoc.sats"
//
(* ****** ****** *)
//
abstype
theDocument_type
typedef
theDocument = theDocument_type
//
macdef
theDocument =
$extval(theDocument, "document")
//
(* ****** ****** *)
//
fun
document_getById_exn
  (name: string): xmldoc = "mac#%"
fun
document_getById_opt
  (name: string): xmldocopt = "mac#%"
//
(* ****** ****** *)
//
fun
theDocument_getById_exn
(_: theDocument, name: string): xmldoc = "mac#%"
fun
theDocument_getById_opt
(_: theDocument, name: string): xmldocopt = "mac#%"
//
overload
.getById with theDocument_getById_exn
overload
.getById_opt with theDocument_getById_opt
//
(* ****** ****** *)

(* end of [document.sats] *)

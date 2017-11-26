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
// HX-2017-11:
//
#define
ATS_EXTERN_PREFIX
"ats2js_html_" //
// prefix for external names
//
(* ****** ****** *)
//
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
#staload
"{$LIBATSCC2JS}/basics_js.sats"
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

abstype Element_type
typedef Element = Element_type
typedef Elemopt = Option(Element)

(* ****** ****** *)
//
fun
document_getById_exn
  (id: string): Element = "mac#%"
fun
document_getById_opt
  (id: string): Elemopt = "mac#%"
//
fun
theDocument_getById_exn
(_: theDocument, id: string): Element = "mac#%"
fun
theDocument_getById_opt
(_: theDocument, id: string): Elemopt = "mac#%"
//
overload
.getById with theDocument_getById_exn
overload
.getById_opt with theDocument_getById_opt
//
(* ****** ****** *)
//
fun
document_createElement
  (tag: string): Element = "mac#%"
fun
theDocument_createElement
  (_: theDocument, tag: string): Element = "mac#%"
//
overload
.createElement with theDocument_createElement
//
(* ****** ****** *)
//
fun
Element_get_innerHTML
  (Element): string = "mac#%"
fun
Element_set_innerHTML
  (Element, text: string): void = "mac#%"
//
overload
.innerHTML with Element_get_innerHTML
overload
.innerHTML with Element_set_innerHTML
//
(* ****** ****** *)
//
fun
Element_get_childNodes
  (Element): JSarray(Element) = "mac#%"
fun
Element_set_childNodes
  (Element, nodes: JSarray(Element)): void = "mac#%"
//
overload .childNodes with Element_get_childNodes
overload .childNodes with Element_set_childNodes
//
fun
Element_get_childNode_at
  (Element, index: int): Element = "mac#%"
fun
Element_set_childNode_at
  (Element, index: int, node: Element): void = "mac#%"
//
overload .childNode_at with Element_get_childNode_at
overload .childNode_at with Element_set_childNode_at
//
(* ****** ****** *)

(* end of [document.sats] *)

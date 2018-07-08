(*
** API for libxml2 in ATS
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
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: August, 2013
*)

(* ****** ****** *)

%{#
#include \
"atscntrb-hx-libxml2/libxml/CATS/parser.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libxml2"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libxml2_" // prefix for external names

(* ****** ****** *)
//
staload "./xml0.sats"
//
(* ****** ****** *)

staload "./tree.sats"

(* ****** ****** *)

absvtype
xmlParserCtxtPtr(l:addr) = ptr (l)
vtypedef xmlParserCtxtPtr0 = [l:agez] xmlParserCtxtPtr(l)
vtypedef xmlParserCtxtPtr1 = [l:addr | l > null] xmlParserCtxtPtr(l)

castfn xmlParserCtxtPtr2ptr : {l:addr} (!xmlParserCtxtPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlParserInputPtr(l:addr) = ptr (l)
vtypedef xmlParserInputPtr0 = [l:agez] xmlParserInputPtr(l)
vtypedef xmlParserInputPtr1 = [l:addr | l > null] xmlParserInputPtr(l)

castfn xmlParserInputPtr2ptr : {l:addr} (!xmlParserInputPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlSAXHandlerPtr(l:addr) = ptr (l)
vtypedef xmlSAXHandlerPtr = [l:agez] xmlSAXHandlerPtr(l)
vtypedef xmlSAXHandlerPtr1 = [l:addr | l > null] xmlSAXHandlerPtr(l)

castfn xmlSAXHandlerPtr2ptr : {l:addr} (!xmlSAXHandlerPtr(l)) -<> ptr(l)

(* ****** ****** *)

overload ptrcast with xmlParserCtxtPtr2ptr
overload ptrcast with xmlParserInputPtr2ptr
overload ptrcast with xmlSAXHandlerPtr2ptr

(* ****** ****** *)

/*
void xmlInitParser (void);
*/
fun xmlInitParser((*void*)): void = "mac#%"

(* ****** ****** *)

/*
void xmlCleanupParser (void);
*/
fun xmlCleanupParser((*void*)): void = "mac#%"

(* ****** ****** *)

/*
xmlDocPtr xmlParseDoc (const xmlChar *cur);
*/
fun xmlParseDoc
  (cur: !xmlStrptr1): xmlDocPtr0 = "mac#%"
// end of [xmlParseDoc]

(* ****** ****** *)

/*
xmlDocPtr xmlParseFile (const char *filename);
*/
fun xmlParseFile
  (filename: string): xmlDocPtr0 = "mac#%"
// end of [xmlParseFile]

(* ****** ****** *)

/*
xmlDocPtr xmlParseMemory (const char *buffer, int size);
*/
fun
xmlParseMemory{n:int}
  (buf: &RD(array(char, n)), size: int (n)): xmlDocPtr0 = "mac#%"
// end of [xmlParseMemory]

(* ****** ****** *)

(* end of [parser.sats] *)

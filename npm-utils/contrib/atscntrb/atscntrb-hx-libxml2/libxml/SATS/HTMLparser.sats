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
"atscntrb-hx-libxml2/libxml/CATS/HTMLparser.cats"
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
staload "./parser.sats"

(* ****** ****** *)

stadef htmlDocPtr = xmlDocPtr
stadef htmlDocPtr0 = xmlDocPtr0
stadef htmlDocPtr1 = xmlDocPtr1

(* ****** ****** *)

stadef htmlNodePtr = xmlNodePtr
stadef htmlNodePtr0 = xmlNodePtr0
stadef htmlNodePtr1 = xmlNodePtr1

(* ****** ****** *)

stadef htmlParserCtxtPtr = xmlParserCtxtPtr
stadef htmlParserCtxtPtr0 = xmlParserCtxtPtr0
stadef htmlParserCtxtPtr1 = xmlParserCtxtPtr1

(* ****** ****** *)

stadef htmlParserInputPtr = xmlParserInputPtr
stadef htmlParserInputPtr0 = xmlParserInputPtr0
stadef htmlParserInputPtr1 = xmlParserInputPtr1

(* ****** ****** *)
//
abst@ype htmlParserOption = uint
//
macdef
HTML_PARSE_RECOVER = $extval(htmlParserOption, "HTML_PARSE_RECOVER")
macdef
HTML_PARSE_NODEFDTD = $extval(htmlParserOption, "HTML_PARSE_NODEFDTD")
macdef
HTML_PARSE_NOERROR = $extval(htmlParserOption, "HTML_PARSE_NOERROR")
macdef
HTML_PARSE_NOWARNING = $extval(htmlParserOption, "HTML_PARSE_NOWARNING")
macdef
HTML_PARSE_PEDANTIC = $extval(htmlParserOption, "HTML_PARSE_PEDANTIC")
macdef
HTML_PARSE_NOBLANKS = $extval(htmlParserOption, "HTML_PARSE_NOBLANKS")
macdef
HTML_PARSE_NONET = $extval(htmlParserOption, "HTML_PARSE_NONET")
macdef
HTML_PARSE_NOIMPLIED = $extval(htmlParserOption, "HTML_PARSE_NOIMPLIED")
macdef
HTML_PARSE_COMPACT = $extval(htmlParserOption, "HTML_PARSE_COMPACT")
macdef
HTML_PARSE_IGNORE_ENC = $extval(htmlParserOption, "HTML_PARSE_IGNORE_ENC")
//
(* ****** ****** *)
//
abst@ype htmlStatus = int
//
macdef HTML_NA = $extval(htmlStatus, "HTML_NA")
macdef HTML_INVALID = $extval(htmlStatus, "HTML_INVALID")
macdef HTML_DEPRECATED = $extval(htmlStatus, "HTML_DEPRECATED")
macdef HTML_VALID = $extval(htmlStatus, "HTML_VALID")
macdef HTML_REQUIRED = $extval(htmlStatus, "HTML_REQUIRED")
//
(* ****** ****** *)

/*
htmlParserCtxtPtr htmlNewParserCtxt(void);
*/
fun htmlNewParserCtxt (): htmlParserCtxtPtr0 = "mac#%"

(* ****** ****** *)

fun
htmlParserCtxtPtr_get1_myDoc
  {l:agz} (!htmlParserCtxtPtr(l)): xmlDocPtr0 = "mac#%"
// end of [htmlParserCtxtPtr_get1_myDoc]

(* ****** ****** *)

/*
htmlDocPtr
htmlParseDoc (xmlChar *cur, const char *encoding) ;
*/
fun htmlParseDoc
  (xmlString, stropt(*encoding*)): htmlDocPtr0 = "mac#%"
// end of [htmlParseDoc]

(* ****** ****** *)

/*
htmlDocPtr
htmlParseFile (const char * filename, const char * encoding)
*/
fun htmlParseFile
  (filename: string, encoding: stropt): htmlDocPtr0 = "mac#%"

(* ****** ****** *)

(* end of [HTMLparser.sats] *)

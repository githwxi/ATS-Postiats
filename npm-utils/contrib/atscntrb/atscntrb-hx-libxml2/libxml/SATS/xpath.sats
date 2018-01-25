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
** Start Time: December, 2013
*)

(* ****** ****** *)

%{#
#include \
"atscntrb-hx-libxml2/libxml/CATS/xpath.cats"
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
xmlNodeSetPtr(l:addr) = ptr (l)
vtypedef xmlNodeSetPtr0 = [l:agez] xmlNodeSetPtr(l)
vtypedef xmlNodeSetPtr1 = [l:addr | l > null] xmlNodeSetPtr(l)

castfn xmlNodeSetPtr2ptr : {l:addr} (!xmlNodeSetPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathAxisPtr(l:addr) = ptr (l)
vtypedef xmlXPathAxisPtr0 = [l:agez] xmlXPathAxisPtr(l)
vtypedef xmlXPathAxisPtr1 = [l:addr | l > null] xmlXPathAxisPtr(l)

castfn xmlXPathAxisPtr2ptr : {l:addr} (!xmlXPathAxisPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathCompExprPtr(l:addr) = ptr (l)
vtypedef xmlXPathCompExprPtr0 = [l:agez] xmlXPathCompExprPtr(l)
vtypedef xmlXPathCompExprPtr1 = [l:addr | l > null] xmlXPathCompExprPtr(l)

castfn xmlXPathCompExprPtr2ptr : {l:addr} (!xmlXPathCompExprPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathContextPtr(l:addr) = ptr (l)
vtypedef xmlXPathContextPtr0 = [l:agez] xmlXPathContextPtr(l)
vtypedef xmlXPathContextPtr1 = [l:addr | l > null] xmlXPathContextPtr(l)

castfn xmlXPathContextPtr2ptr : {l:addr} (!xmlXPathContextPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathFuncPtr(l:addr) = ptr (l)
vtypedef xmlXPathFuncPtr0 = [l:agez] xmlXPathFuncPtr(l)
vtypedef xmlXPathFuncPtr1 = [l:addr | l > null] xmlXPathFuncPtr(l)

castfn xmlXPathFuncPtr2ptr : {l:addr} (!xmlXPathFuncPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathObjectPtr(l:addr) = ptr (l)
vtypedef xmlXPathObjectPtr0 = [l:agez] xmlXPathObjectPtr(l)
vtypedef xmlXPathObjectPtr1 = [l:addr | l > null] xmlXPathObjectPtr(l)

castfn xmlXPathObjectPtr2ptr : {l:addr} (!xmlXPathObjectPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathParserContextPtr(l:addr) = ptr (l)
vtypedef xmlXPathParserContextPtr0 = [l:agez] xmlXPathParserContextPtr(l)
vtypedef xmlXPathParserContextPtr1 = [l:addr | l > null] xmlXPathParserContextPtr(l)

castfn xmlXPathParserContextPtr2ptr : {l:addr} (!xmlXPathParserContextPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathTypePtr(l:addr) = ptr (l)
vtypedef xmlXPathTypePtr0 = [l:agez] xmlXPathTypePtr(l)
vtypedef xmlXPathTypePtr1 = [l:addr | l > null] xmlXPathTypePtr(l)

castfn xmlXPathTypePtr2ptr : {l:addr} (!xmlXPathTypePtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlXPathVariablePtr(l:addr) = ptr (l)
vtypedef xmlXPathVariablePtr0 = [l:agez] xmlXPathVariablePtr(l)
vtypedef xmlXPathVariablePtr1 = [l:addr | l > null] xmlXPathVariablePtr(l)

castfn xmlXPathVariablePtr2ptr : {l:addr} (!xmlXPathVariablePtr(l)) -<> ptr(l)

(* ****** ****** *)
//
abst@ype xmlXPathError = int
//
macdef XPATH_EXPRESSION_OK = $extval(xmlXPathError, "XPATH_EXPRESSION_OK")
macdef XPATH_NUMBER_ERROR = $extval(xmlXPathError, "XPATH_NUMBER_ERROR")
macdef XPATH_UNFINISHED_LITERAL_ERROR = $extval(xmlXPathError, "XPATH_UNFINISHED_LITERAL_ERROR")
macdef XPATH_START_LITERAL_ERROR = $extval(xmlXPathError, "XPATH_START_LITERAL_ERROR")
macdef XPATH_VARIABLE_REF_ERROR = $extval(xmlXPathError, "XPATH_VARIABLE_REF_ERROR")
macdef XPATH_UNDEF_VARIABLE_ERROR = $extval(xmlXPathError, "XPATH_UNDEF_VARIABLE_ERROR")
macdef XPATH_INVALID_PREDICATE_ERROR = $extval(xmlXPathError, "XPATH_INVALID_PREDICATE_ERROR")
macdef XPATH_EXPR_ERROR = $extval(xmlXPathError, "XPATH_EXPR_ERROR")
macdef XPATH_UNCLOSED_ERROR = $extval(xmlXPathError, "XPATH_UNCLOSED_ERROR")
macdef XPATH_UNKNOWN_FUNC_ERROR = $extval(xmlXPathError, "XPATH_UNKNOWN_FUNC_ERROR")
macdef XPATH_INVALID_OPERAND = $extval(xmlXPathError, "XPATH_INVALID_OPERAND")
macdef XPATH_INVALID_TYPE = $extval(xmlXPathError, "XPATH_INVALID_TYPE")
macdef XPATH_INVALID_ARITY = $extval(xmlXPathError, "XPATH_INVALID_ARITY")
macdef XPATH_INVALID_CTXT_SIZE = $extval(xmlXPathError, "XPATH_INVALID_CTXT_SIZE")
macdef XPATH_INVALID_CTXT_POSITION = $extval(xmlXPathError, "XPATH_INVALID_CTXT_POSITION")
macdef XPATH_MEMORY_ERROR = $extval(xmlXPathError, "XPATH_MEMORY_ERROR")
macdef XPTR_SYNTAX_ERROR = $extval(xmlXPathError, "XPTR_SYNTAX_ERROR")
macdef XPTR_RESOURCE_ERROR = $extval(xmlXPathError, "XPTR_RESOURCE_ERROR")
macdef XPTR_SUB_RESOURCE_ERROR = $extval(xmlXPathError, "XPTR_SUB_RESOURCE_ERROR")
macdef XPATH_UNDEF_PREFIX_ERROR = $extval(xmlXPathError, "XPATH_UNDEF_PREFIX_ERROR")
macdef XPATH_ENCODING_ERROR = $extval(xmlXPathError, "XPATH_ENCODING_ERROR")
macdef XPATH_INVALID_CHAR_ERROR = $extval(xmlXPathError, "XPATH_INVALID_CHAR_ERROR")
macdef XPATH_INVALID_CTXT = $extval(xmlXPathError, "XPATH_INVALID_CTXT")
macdef XPATH_STACK_ERROR = $extval(xmlXPathError, "XPATH_STACK_ERROR")
macdef XPATH_FORBID_VARIABLE_ERROR = $extval(xmlXPathError, "XPATH_FORBID_VARIABLE_ERROR")
//
(* ****** ****** *)

/*
xmlXPathObjectPtr xmlXPathConvertNumber (xmlXPathObjectPtr val);
xmlXPathObjectPtr xmlXPathConvertString (xmlXPathObjectPtr val);
xmlXPathObjectPtr xmlXPathConvertBoolean (xmlXPathObjectPtr val);
*/

(* ****** ****** *)

fun xmlXPathConvertNumber (!xmlXPathObjectPtr0): xmlXPathObjectPtr0 = "mac#"
fun xmlXPathConvertString (!xmlXPathObjectPtr0): xmlXPathObjectPtr0 = "mac#"
fun xmlXPathConvertBoolean (!xmlXPathObjectPtr0): xmlXPathObjectPtr0 = "mac#"

(* ****** ****** *)

fun xmlXPathFreeObject (xmlXPathObjectPtr0): void = "mac#%"

(* ****** ****** *)

fun xmlXPathNewContext
  (doc: !xmlDocPtr1): xmlXPathContextPtr0 = "mac#%"

fun xmlXPathFreeContext (xmlXPathContextPtr0): void = "mac#%"

(* ****** ****** *)

(* end of [xpath.sats] *)

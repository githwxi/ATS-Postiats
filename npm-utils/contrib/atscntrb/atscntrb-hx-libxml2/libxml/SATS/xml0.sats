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
//
#include \
"atscntrb-hx-libxml2/libxml/CATS/xml0.cats"
//
%} // end of [%{#]

(* ****** ****** *)

abst@ype xmlChar = $extype"xmlChar"

(* ****** ****** *)

abstype xmlString = string // xmlChar*

(* ****** ****** *)

castfn
xmlString2string (xmlString):<> string
castfn
string2xmlString (str: string):<> xmlString

(* ****** ****** *)
//
fun{}
fprint_xmlString (FILEref, xmlString): void
overload fprint with fprint_xmlString
//
(* ****** ****** *)

absvtype
xmlStrptr(l:addr) = ptr(l) // xmlChar*
vtypedef xmlStrptr0 = [l:agez] xmlStrptr(l)
vtypedef xmlStrptr1 = [l:addr | l > null] xmlStrptr(l)

(* ****** ****** *)

castfn xmlStrptr2ptr {l:addr} (!xmlStrptr(l)):<> ptr(l)

(* ****** ****** *)

castfn xmlStrptr2strptr{l:addr} (xmlStrptr(l)):<> strptr(l)

(*
castfn strptr2xmlStrptr{l:addr} (str: strptr(l)):<> xmlStrptr(l)
castfn strnptr2xmlStrptr{l:addr}{n:int} (str: strnptr(l,n)):<> xmlStrptr(l)
*)

(* ****** ****** *)

overload ptrcast with xmlStrptr2ptr

(* ****** ****** *)

fun xmlFreeStrptr (xmlStrptr0): void = "mac#%"

(* ****** ****** *)

symintr __name
symintr __type
symintr __ns _doc
symintr __next
symintr __prev
symintr __parent
symintr __children
symintr __last
symintr __content
symintr __properties

(* ****** ****** *)

(* end of [xml0.sats] *)

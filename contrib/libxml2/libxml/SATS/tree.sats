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
#include "libxml2/libxml/CATS/tree.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.libxml2"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_libxml2_" // prefix for external names

(* ****** ****** *)

staload "./xmlheader.sats"

(* ****** ****** *)

absvtype
xmlDocPtr(l:addr) = ptr(l) // xmlDocPtr
vtypedef xmlDocPtr0 = [l:agez] xmlDocPtr(l)
vtypedef xmlDocPtr1 = [l:addr | l > null] xmlDocPtr(l)

castfn xmlDocPtr2ptr : {l:addr} (!xmlDocPtr(l)) -<> ptr(l)

(* ****** ****** *)

absvtype
xmlNodePtr(l:addr) = ptr(l) // xmlNodePtr
vtypedef xmlNodePtr0 = [l:agez] xmlNodePtr(l)
vtypedef xmlNodePtr1 = [l:addr | l > null] xmlNodePtr(l)

castfn xmlNodePtr2ptr : {l:addr} (!xmlNodePtr(l)) -<> ptr(l)

(* ****** ****** *)

overload ptrcast with xmlDocPtr2ptr
overload ptrcast with xmlNodePtr2ptr

(* ****** ****** *)

/*
void xmlFreeDoc (xmlDocPtr cur)
*/
fun xmlFreeDoc (cur: xmlDocPtr0): void = "mac#%"

(* ****** ****** *)

(* end of [tree.sats] *)

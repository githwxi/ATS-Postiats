(*
** API in ATS for HTML/document
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
** Author: Will Blair
** Authoremail: wdblairATgmailDOTcom
** Start Time: October, 2013
*)
(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: October, 2013
*)

(* ****** ****** *)

#define
ATS_PACKNAME "ATSCNTRB.HTML"

(* ****** ****** *)

#define ATS_STALOADFLAG 0 // no staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_html_" // prefix for external names

(* ****** ****** *)

fun document_get_documentElement_clientWidth (): int = "ext#%"
fun document_get_documentElement_clientHeight (): int = "ext#%"

(* ****** ****** *)
//
absvtype element_vtype (l:addr) = ptr(l)
//
vtypedef element (l:addr) = element_vtype (l)
vtypedef element0 = [l:agez] element (l)
vtypedef element1 = [l:addr | l > null] element (l)
//
castfn
element2ptr{l:addr} (elt: !element(l)):<> ptr(l)
overload ptrcast with element2ptr
//
(* ****** ****** *)
//
absvtype event_vtype (l:addr) = ptr(l)
//
vtypedef event (l:addr) = event_vtype (l)
vtypedef event0 = [l:agez] event (l)
vtypedef event1 = [l:addr | l > null] event (l)
//
castfn
event2ptr{l:addr} (event: !event(l)):<> ptr(l)
overload ptrcast with event2ptr
//
(* ****** ****** *)

fun document_element_free (elt: element0): void = "ext#%"

(* ****** ****** *)

fun document_getElementById (id: string): element0 = "ext#%"

(* ****** ****** *)

fun document_element_get_width (!element1): int = "ext#%"
fun document_element_get_height (!element1): int = "ext#%"
fun document_element_set_width (!element1, width: int): void = "ext#%"
fun document_element_set_height (!element1, height: int): void = "ext#%"

(* ****** ****** *)

fun document_element_get_value_int (!element1): int = "ext#%"
fun document_element_get_value_string (!element1): string = "ext#%"
  
(* ****** ****** *)

fun document_event_free (event: event0): void = "ext#%"

(* ****** ****** *)

fun document_event_get_keyCode (!event1): int = "ext#%"

fun document_event_get_target (e: !event1): element1 = "ext#%"

(* ****** ****** *)

(* end of [document.sats] *)

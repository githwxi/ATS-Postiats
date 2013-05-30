(*
** API for json-c in ATS
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
**
** Time: May, 2013
** Author Hongwei Xi (gmhwxi AT gmail DOT com)
**
*)

(* ****** ****** *)

%{#
#include "json-c/CATS/json.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.json"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_" // prefix for external names

(* ****** ****** *)

fun json_c_version (): string = "mac#%"
fun json_c_version_num (): int = "mac#%"

(* ****** ****** *)

#include "./json_header.sats"

(* ****** ****** *)

(*
#include "./linkhash.sats" // HX: for hashtable implementation
*)

(* ****** ****** *)

(*
#include "./arraylist.sats" // HX: for dynamic arrays
*)

(* ****** ****** *)

(*
#include "./printbuf.sats" // HX: for buffered printing
*)

(* ****** ****** *)

#include "./json_util.sats"

(* ****** ****** *)

#include "./json_object.sats"

(* ****** ****** *)

#include "./json_tokener.sats"

(* ****** ****** *)

(* end of [json.sats] *)

(*
** API in ATS for json-c
*)

(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
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
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: May, 2013
**
*)

(* ****** ****** *)

%{#
#include \
"atscntrb-libjson-c/CATS/json.cats"
%} // end of [%{#]

(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.jsonc"
//
// HX: prefix for external names
//
#define
ATS_EXTERN_PREFIX "atscntrb_jsonc_"
//
(* ****** ****** *)

fun json_c_version(): string = "mac#%"
fun json_c_version_num(): int = "mac#%"

(* ****** ****** *)

#include "./mybasis.sats"

(* ****** ****** *)

(*
#include "./linkhash.sats" // HX: for hashtable
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
#include "./json_object_iterator.sats"

(* ****** ****** *)

#include "./json_tokener.sats"

(* ****** ****** *)

(* end of [json.sats] *)

(* ****** ****** *)
//
// API in ATS for PCRE
// A quasi ML-style API in ATS for pcre
//
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

#define ATS_PACKNAME "ATSCNTRB.pcre_ML"
#define ATS_EXTERN_PREFIX "atscntrb_pcre_ML_" // prefix for external names

(* ****** ****** *)

staload "./../SATS/pcre.sats"

(* ****** ****** *)
//
fun{
} regstr_match_string
  (regstr: string, subject: string): int
//
fun{
} regstr_match_substring
  {n:int}{st,ln:int | st+ln <= n}
(
  regstr: string
, subject: string(n), st: size_t st, ln: size_t ln
) : int // end of [regstr_match_substring]
//
(* ****** ****** *)

fun{
} regstr_match2_string{n:int}
(
  regstr: string, subject: string(n)
, matched_beg: &int? >> int(n0), matched_end: &int? >> int(n1)
) : #[n0,n1:int | n0 <= n1; n1 <= n] int // end-of-fun

fun{
} regstr_match2_substring
  {n:int}{st,ln:int | st+ln <= n}
(
  regstr: string
, subject: string(n), st: size_t st, ln: size_t ln
, matched_beg: &int? >> int(n0), matched_end: &int? >> int(n1)
) : #[n0,n1:int | n0 <= n1; n1 <= st+ln] int // end-of-fun

(* ****** ****** *)

fun{
} regstr_match3_string
  {n:int}
(
  regstr: string
, subject: string(n)
, matched_beg: &int? >> int(n0)
, matched_end: &int? >> int(n1)
, err: &int? >> int
) : #[n0,n1:int | n0 <= n1; n1 <= n] List0_vt(Strptr0)

fun{
} regstr_match3_substring
  {n:int}{st,ln:int | st+ln <= n}
(
  regstr: string
, subject: string(n)
, st: size_t st, ln: size_t ln
, matched_beg: &int? >> int(n0)
, matched_end: &int? >> int(n1)
, err: &int? >> int
) : #[n0,n1:int | n0 <= n1; n1 <= st+ln] List0_vt(Strptr0)

(* ****** ****** *)

(* end of [pcre_ML.sats] *)

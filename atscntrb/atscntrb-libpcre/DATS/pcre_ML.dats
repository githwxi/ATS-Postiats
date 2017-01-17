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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"
staload "./../SATS/pcre_ML.sats"

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match_string
  (regstr, subject) = let
//
val subject = g1ofg0 (subject)
//
in
//
regstr_match_substring
  (regstr, subject, i2sz(0), length(subject))
//
end // end of [regstr_match_string]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match_substring
  (regstr, subject, st, ln) = let
//
var errptr: ptr
var erroffset: int
val tableptr = the_null_ptr
//
val code =
pcre_compile
  (regstr, 0u, errptr, erroffset, tableptr)
//
val p_code = pcreptr2ptr(code)
//
in
//
if p_code > 0 then let
  val ret =
  pcre_match_substring (code, subject, st, ln)
  val ((*freed*)) = pcre_free (code)
in
  ret
end else let
  prval () = pcre_free_null (code)
in
  ~1(*PCRE_ERROR_NOMATCH*)
end // end of [if]
//
end // end of [regstr_match_substring]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match2_string
(
  regstr, subject, matched_beg, matched_end
) = let
in
//
regstr_match2_substring
(
  regstr, subject
, i2sz(0), length(subject), matched_beg, matched_end)
//
end // end of [regstr_match2_string]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match2_substring
(
  regstr, subject, st, ln
, matched_beg, matched_end
) = let
//
prval () =
  lemma_g1uint_param (st)
prval () =
  lemma_g1uint_param (ln)
//
var errptr: ptr
var erroffset: int
val tableptr = the_null_ptr
//
val code =
pcre_compile
  (regstr, 0u, errptr, erroffset, tableptr)
//
val p_code = pcreptr2ptr(code)
//
in
//
if p_code > 0 then let
  val ret =
  pcre_match2_substring
    (code, subject, st, ln, matched_beg, matched_end)
  val ((*freed*)) = pcre_free (code)
in
  ret
end else let
  prval () = pcre_free_null (code)
  val () = matched_beg := ~1 and () = matched_end := ~1
in
  ~1(*PCRE_ERROR_NOMATCH*)
end // end of [if]
//
end // end of [regstr_match2_substring]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match3_string
(
  regstr, subject, matched_beg, matched_end, err
) = let
in
//
regstr_match3_substring
(
  regstr, subject
, i2sz(0), length(subject), matched_beg, matched_end, err)
//
end // end of [regstr_match3_string]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match3_substring
(
  regstr, subject, st, ln, matched_beg, matched_end, err
) = let
//
prval () =
  lemma_g1uint_param (st)
prval () =
  lemma_g1uint_param (ln)
//
var errptr: ptr
var erroffset: int
val tableptr = the_null_ptr
//
val code =
pcre_compile
  (regstr, 0u, errptr, erroffset, tableptr)
//
val p_code = pcreptr2ptr(code)
//
in
//
if p_code > 0 then let
  val ret =
  pcre_match3_substring
    (code, subject, st, ln, matched_beg, matched_end, err)
  val ((*freed*)) = pcre_free (code)
in
  ret
end else let
  prval () = pcre_free_null (code)
  val () = err := ~1
  val () = matched_beg := ~1 and () = matched_end := ~1
in
  list_vt_nil((*void*))
end // end of [if]
//
end // end of [regstr_match3_substring]

(* ****** ****** *)

(* end of [pcre_ML.dats] *)

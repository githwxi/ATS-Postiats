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
val subject = g1ofg0(subject)
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
if
(p_code > 0)
then
rets where
{
  val
  rets =
  pcre_match_substring
    (code, subject, st, ln)
  // end of [val]
  val ((*freed*)) = pcre_free(code)
} else let
  prval ((*freed*)) = pcre_free_null(code)
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
, i2sz(0), length(subject), matched_beg, matched_end
) (* regstr_match2_substring *)
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
  lemma_g1uint_param(st)
prval () =
  lemma_g1uint_param(ln)
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
if
(p_code > 0)
then
rets where
{
  val
  rets =
  pcre_match2_substring
    (code, subject, st, ln, matched_beg, matched_end)
  // end of [val]
  val ((*freed*)) = pcre_free(code)
} else let
  val () = matched_beg := ~1
  and () = matched_end := ~1
  prval ((*freed*)) = pcre_free_null(code)
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
  regstr, subject
, matched_beg, matched_end, err
) = let
//
val st = i2sz(0)
and ln = length(subject)
//
in
//
regstr_match3_substring
(
  regstr, subject, st, ln, matched_beg, matched_end, err
) (* regstr_match3_substring *)
//
end // end of [regstr_match3_string]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match3_substring
(
  regstr, subject, st, ln
, matched_beg, matched_end, err
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
if
(p_code > 0)
then
rets where
{
  val
  rets =
  pcre_match3_substring
    (code, subject, st, ln, matched_beg, matched_end, err)
  // end of [val]
  val ((*freed*)) = pcre_free(code)
} else let
  val () = err := ~1
  val () = matched_beg := ~1
  and () = matched_end := ~1
  prval ((*freed*)) = pcre_free_null(code)
in
  list_vt_nil((*void*))
end // end of [if]
//
end // end of [regstr_match3_substring]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match3_string_easy
  (regstr, subject) = let
//
val subject = g1ofg0(subject)
//
in
  regstr_match3_substring_easy(regstr, subject, i2sz(0), length(subject))
end // end of [regstr_match3_string_easy]

(* ****** ****** *)

implement
{}(*tmp*)
regstr_match3_substring_easy
  (regstr, subject, st, ln) = let
//
var _beg_: int
and _end_: int
var _err_: int
//
val rets =
regstr_match3_substring
  (regstr, subject, st, ln, _beg_, _end_, _err_)
//
in
//
if
(_err_ >= 0)
then
Some_vt(rets)
else
None_vt(*void*) where
{
val () = loop(rets) where
{
  fun
  loop(xs: List_vt(Strptr0)): void =
  (
    case+ xs of
    | ~list_vt_nil() => ()
    | ~list_vt_cons(x, xs) => (strptr_free(x); loop(xs))
  )
} (* end of [val] *)
} (* end of [else] *)
//
end // end of [regstr_match3_string_easy]

(* ****** ****** *)

(* end of [pcre_ML.dats] *)

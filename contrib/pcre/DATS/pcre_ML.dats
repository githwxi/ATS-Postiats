(*
** A quasi ML-style API in ATS for pcre
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"
staload "./../SATS/pcre_ML.sats"

(* ****** ****** *)

implement{
} regstr_match_string
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

implement{
} regstr_match_substring
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

implement{
} regstr_match2_string
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

implement{
} regstr_match2_substring
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

(* end of [pcre_ML.dats] *)

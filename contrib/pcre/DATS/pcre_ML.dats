(*
** A quasi ML-style API for pcre in ATS
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

(* end of [pcre_ML.dats] *)

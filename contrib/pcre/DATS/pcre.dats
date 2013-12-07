(*
** A direct API for pcre in ATS
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"

(* ****** ****** *)

implement{
} pcre_match_string
  (code, subject) = let
//
val subject = g1ofg0 (subject)
//
in
//
pcre_match_substring
  (code, subject, i2sz(0), length (subject))
//
end // end of [pcre_match_string]

(* ****** ****** *)

implement{
} pcre_match_substring
  {n}{st,ln}
(
  code, subject, st, ln
) = let
//
prval () = lemma_g1uint_param (st)
prval () = lemma_g1uint_param (ln)
//
val extra =
  $UN.castvwtp0{pcreptr_extra(null)}(0)
val subject =
  $UN.cast{arrayref(char, st+ln)}(subject)
val length = sz2i(st+ln) and startoffset = sz2i(st) and options = 0u
val ovector = $UN.cast{arrayref(int,0)}(0)
val ret =
  pcre_exec (code, extra, subject, length, startoffset, options, ovector, 0)
prval ((*void*)) = pcre_free_study_null (extra)
//
in
  ret
end // end of [pcre_match_substring]

(* ****** ****** *)

implement{
} pcre_match2_substring
  {n}{st,ln}
(
  code, subject, st, ln
, matched_beg, matched_end
) = let
//
prval () = lemma_g1uint_param (st)
prval () = lemma_g1uint_param (ln)
//
val extra =
  $UN.castvwtp0{pcreptr_extra(null)}(0)
val subject =
  $UN.cast{arrayref(char, st+ln)}(subject)
val length = sz2i(st+ln) and startoffset = sz2i(st) and options = 0u
var int3 = @[int][3]()
val ovector = $UN.cast{arrayref(int,3)}(addr@int3)
val ret =
  pcre_exec (code, extra, subject, length, startoffset, options, ovector, 3)
prval ((*void*)) = pcre_free_study_null (extra)
//
val [n0:int] int3_0 = $UN.cast{Int}(int3.[0])
val [n1:int] int3_1 = $UN.cast{Int}(int3.[1])
val () = matched_beg := int3_0 and () = matched_end := int3_1
prval (
) = __assert () where
{
  extern praxi __assert (): [n0 <= n1; n1 <= st+ln] void
} (* end of [prval] *)
//
in
  ret
end // end of [pcre_match2_substring]

(* ****** ****** *)

(* end of [pcre.dats] *)

//
// Some code for testing the API in ATS for pcre
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"
staload "./../SATS/pcre_ML.sats"

(* ****** ****** *)

staload _ = "./../DATS/pcre.dats"
staload _ = "./../DATS/pcre_ML.dats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val ret0 =
regstr_match_string ("http", "http://www.ats-lang.org")
val () = println! ("ret0 = ", ret0)
//
val ret0_2 =
regstr_match_string ("^http", "http://www.ats-lang.org")
val () = println! ("ret0_2 = ", ret0_2)
//
val ret1 =
regstr_match_string ("ats-lang", "http://www.ats-lang.org")
val () = println! ("ret1 = ", ret1)
//
val ret1_2 =
regstr_match_string ("^ats-lang", "http://www.ats-lang.org")
val () = println! ("ret1_2 = ", ret1_2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

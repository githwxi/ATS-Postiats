(* ****** ****** *)
//
// Some code for testing the API in ATS for pcre
//
(* ****** ****** *)

(*
##myatsccdef=\
patscc \
-I./../.. \
-DATS_MEMALLOC_LIBC \
-o $fname($1) $1 -lpcre
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

#include "./../mylibies.hats"
#staload $PCRE_ML // opening it

(* ****** ****** *)
//
local
#include "./../mylibies_link.hats"
in (*nothing*) end
//
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

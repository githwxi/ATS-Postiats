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
val str = "http://www.ats-lang.org"
//
val ret0 =
regstr_match_string ("\\..*\\.", str)
val () = println! ("ret0 = ", ret0)
//
var ibeg: int and iend: int
val ret0_2 =
regstr_match2_string ("\\..*\\.", str, ibeg, iend)
//
val () = println! ("ret0_2 = ", ret0_2)
val () = println! ("ibeg = ", ibeg, " and iend = ", iend)
//
val () = assertloc (ibeg >= 0)
//
val str2 =
string_make_substring (str, i2sz(ibeg), i2sz(iend-ibeg))
val str2 = strnptr2strptr (str2)
val ((*void*)) = println! ("str2 = ", str2)
//
val ((*void*)) = strptr_free (str2)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)

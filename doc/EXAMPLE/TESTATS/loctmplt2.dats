//
// Some code involving
// locally defined templates
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: September, 2015
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

local

fun{}
foo(): int = 0

in (* in-of-local *)

fun{}
foo2(): int = foo() + 1

end // end of [local]

(* ****** ****** *)

implement main0 () = {
val n = foo2()
val- 1 = n
val () =
println! ("foo2() = ", n)
}

(* ****** ****** *)

(* end of [loctmplt2.dats] *)

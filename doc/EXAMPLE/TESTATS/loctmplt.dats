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

implement main0 () = println! ("foo2() = ", foo2())

(* ****** ****** *)

(* end of [loctmplt.dats] *)

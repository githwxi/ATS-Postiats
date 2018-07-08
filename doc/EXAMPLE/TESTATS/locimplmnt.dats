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
//
extern
fun{}
foo((*void*)): int
//
extern
fun{}
foo2((*void*)): int
//
(* ****** ****** *)

implement{} foo() = 0
implement{} foo2() = foo() + 1

(* ****** ****** *)

implement main0 () =
{
//
val () = assertloc (foo2() = 1)
//
local
//
implement foo<> () = 1
//
in
//
val () = assertloc (foo2() = 2)
//
end // end of [local]
//
val () = assertloc (foo2() = 1)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [locimplmnt.dats] *)

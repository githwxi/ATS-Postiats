(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Feb of 2013
// Authoremail: gmhwxi@gmail.com
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "prelude/DATS/tuple.dats"

(* ****** ****** *)

implement
fprint_tup$beg<> (out) = fprint_string (out, "(")
implement
fprint_tup$end<> (out) = fprint_string (out, ")")
implement
fprint_tup$sep<> (out) = fprint_string (out, ", ")

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
val () = fprint_tupval2<int,char> (out, @(0, 'a'))
val () = fprint_newline (out)
val () = fprint_tupval2<int,tup(bool,char)> (out, @(0, (true, 'a')))
val () = fprint_newline (out)
val () = fprint_tupval3<int,tup(bool,char),string> (out, @(0, (true, 'a'), "hello!"))
val () = fprint_newline (out)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fprtuple.dats] *)

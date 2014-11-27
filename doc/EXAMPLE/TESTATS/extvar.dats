//
// extvar-declaration
//
// Author: Hongwei Xi (2014-09)
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
val xs = 1
//
extvar "xs" = xs
extvar "ys" = $extval(int, "xs") + xs
//
(* ****** ****** *)
//
%{^
int xs, ys;
%}
//
%{^
void print_xs_ys () { printf ("xs = %i and ys = %i\n", xs, ys); }
%}
//
(* ****** ****** *)

implement
main0 () = $extfcall(void, "print_xs_ys")

(* ****** ****** *)

(* end of [extvar.dats] *)

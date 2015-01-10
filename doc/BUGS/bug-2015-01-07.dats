(*
** Bug causing erroneous handling
** of mutually recursive templates
*)

(* ****** ****** *)

(*
** Source: Reported by WB-2015-01-07
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2015-01-10
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

extern fun{} foo(): int
extern fun{} bar1(int): int
extern fun{} bar2(int): int

(* ****** ****** *)
//
implmnt
{}(*tmp*)
bar1 (x) = bar2 (x)
implmnt
{}(*tmp*)
bar2 (x) =
  if x > 0 then foo() + bar1 (x-1) else 0
//
(* ****** ****** *)

implement
main0(argc
    , argv) = let
//
implement
{}(*tmp*)
foo((*void*)) = argc
//
// HX-2015-01-08:
// This seems to be reasonable:
// HX-2015-01-10:
// This is now implemented, and it works!
//
val () = $closurenv(argc)
//
in
  println! ("bar2(10) = ", bar2(10))
end // end of [main]

(* ****** ****** *)

(* end of [bug-2015-01-07.dats] *)

(* ****** ****** *)
//
// HX-2014-11:
// A running example
// from ATS2 to Perl5
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2PL}/SATS/integer.sats"
//
(* ****** ****** *)
//
extern
fun f91 : int -> int = "mac#f91"
//
implement
f91 (x) =
if x >= 101
  then x - 10 else f91(f91(x+11))
//
(* ****** ****** *)

%{^
require "./libatscc2pl/libatscc2pl_all.pl";
%} // end of [%{^]

(* ****** ****** *)

%{$
//
$ans = f91(23); print "f91(23) = $ans\n";
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [f91.dats] *)

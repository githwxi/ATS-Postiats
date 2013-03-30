//
// A gnumber-based implementation
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Time: the 30th of March, 2013
//
(* ****** ****** *)

staload
INT = "prelude/DATS/integer.dats"
staload
FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

staload _ = "prelude/DATS/gorder.dats"
staload _ = "prelude/DATS/gnumber.dats"

(* ****** ****** *)

extern fun{a:t@ype} gfact (x: a): a

(* ****** ****** *)

implement
{a}
gfact (x) = let
//
macdef ggt = ggt_val<a>
//
macdef gmul = gmul_val<a>
macdef gpred = gpred_val<a>
//
macdef gn = gnumint<a>
//
in
//
if x \ggt gn(0) then x \gmul gfact<a> (gpred (x)) else gn(1)
//
end // end of [gfact]

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("fact(12) = ", gfact<int> (12))
val () = println! ("fact(12) = ", gfact<double> (12.0))
//
} // end of [main0]

(* ****** ****** *)

(* end of [gfact.dats] *)
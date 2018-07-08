(* ****** ****** *)
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

extern fun{a:t@ype} gfact (x: int): a

(* ****** ****** *)
//
(*
fun fact (x: int): int =
  if x > 0 then x * fact (x-1) else 1
*)
//
implement
{a}(*tmp*)
gfact (x) = let
//
macdef gint = gnumber_int<a>
//
overload > with ggt_val_int
//
overload * with gmul_int_val
//
in
//
if x > 0 then x * gfact<a> (x - 1) else gint(1)
//
end // end of [gfact]
//
(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
val () = fprintln! (out, "fact(12) = ", gfact<int> (12))
val () = fprintln! (out, "fact(12) = ", gfact<double> (12))
//
} // end of [main0]

(* ****** ****** *)

(* end of [gfact.dats] *)

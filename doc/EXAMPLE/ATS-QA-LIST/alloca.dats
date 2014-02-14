(*
** Some safety support for alloca
*)

(* ****** ****** *)
//
staload "libc/SATS/alloca.sats"
//
(* ****** ****** *)

fun foo() = let
//
var dummy: void = ()
val (pfat, fpf | p) = alloca (view@dummy | i2sz(1024))
prval () = view@dummy := fpf (pfat)
//
in
  // nothing
end // end of [foo]
  
(* ****** ****** *)

implement
main0 () =
{
val () = foo ()
} (* end of [main0] *)

(* ****** ****** *)

(* end of [alloca.dats] *)

(*
** Bug in handling struct
*)
(*
** Source reported by Will Blair
*)

(* ****** ****** *)

(*
** Status: Fixed by HX-2013-10-30
** Changes are made to [auxmain] for [emit_primval_select]
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

typedef
planet = @{
   x= double,
   y= double,
   z= double
}

implement
main0 () = let
  var solar_system = @[planet][8](@{x=0.0,y=0.0,z=0.0})
in
(*
** syntax errors in the C code generated for the following assignments
*)
  solar_system.[0].x := 1.0;
  solar_system.[0].y := 1.0;
  solar_system.[0].z := 1.0;
end // end of [main0]

(* ****** ****** *)

(* end of [bug-2013-10-30-2.dats] *)

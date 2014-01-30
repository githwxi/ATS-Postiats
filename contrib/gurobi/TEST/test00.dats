(*
** Testing API for GUROBI
*)

(* ****** ****** *)

staload "./../SATS/gurobi.sats"

(* ****** ****** *)

val () = let
  var major: int
  and minor: int
  and technical: int
  val () = GRBversion (major, minor, technical)
in
  println! ("Gurobi(version) = ", major, ".", minor, ".", technical)
end // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)

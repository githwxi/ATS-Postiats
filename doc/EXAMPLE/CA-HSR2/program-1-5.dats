//
// Evaluating an arithmetic expression
//

(* ****** ****** *)

staload FLOAT = "prelude/DATS/float.dats"

(* ****** ****** *)

macdef
abc_mac (a, b, c) =
(
let
  val a = ,(a) val b = ,(b) val c = ,(c)
in
  a + b + b * c + (a + b - c) / (a + b) + 4.0f
end
) // end of [abc_mac]

(* ****** ****** *)

fun abc_fun
(
  a: float, b: float, c: float
) : float =
(
  a + b + b * c + (a + b - c) / (a + b) + 4.0f
) // end of [abc_fun]

(* ****** ****** *)

implement
main0 () = let
  val a = 1.0f and b = 10.0f and c = 100.0f
in
  assertloc (abc_fun (a, b, c) = abc_mac (a, b, c))
end // end of [main0]

(* ****** ****** *)

(* end of [program-1-5.dats] *)

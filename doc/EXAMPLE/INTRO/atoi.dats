//
// Converting a string to an integer
//
// Author: Hongwei Xi (February 22, 2013)
//

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

fun atoi
  (str: string): int = let
//
var env: int = 0
implement{env}
string_foreach$cont (c, env) = isdigit (c)
implement
string_foreach$fwork<int>
  (c, env) = env := 10 * env + (c - '0')
//
val _ = string_foreach_env<int> (g1ofg0(str), env)
//
in
  env
end // end of [atoi]

(* ****** ****** *)

fn atoi_usage
  (cmd: string): void =
  prerrln! ("Usage: ", cmd, " [integer]")
// end of [atoi_usage]

(* ****** ****** *)

implement
main0 (
  argc, argv
) = {
//
(*
val () =
  if (argc <= 1) then atoi_usage (argv[0])
*)
val rep =
  (if argc >= 2 then argv[1] else "123456789"): string
val () = println! ("atoi(\"", rep, "\") = ", atoi(rep))
//
} // end of [main0]

(* ****** ****** *)

(* end of [atoi.dats] *)

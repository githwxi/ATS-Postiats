(* ****** ****** *)
//
// A naive implementation
// of the factorial function
// Author: Hongwei Xi (August 2007)
//
(* ****** ****** *)
//
(*
//
// HX-2017-05-22:
// For remote typechecking only!
//
##myatsccdef=\
curl --data-urlencode mycode@$1 \
http://www.ats-lang.org/SERVER/MYCODE/atslangweb_patsopt_tcats_0_.php | \
php -R 'if (\$argn != \"\") echo(json_decode(urldecode(\$argn))[1].\"\\n\");'
//
*)
//
(* ****** ****** *)
//
// How to test:
//   ./fact1
// How to compile:
//   atscc -o fact1 fact1.dats
//
(* ****** ****** *)

staload "prelude/DATS/integer.dats"

(* ****** ****** *)
//
// HX: [fun] declares a recursive function
//
fun fact (x: int): int =
  if x > 0 then x * fact (x-1) else 1
//
(* ****** ****** *)
//
// [fn] declares a non-recursive function
// It is fine to replace [fn] with [fun] as a non-recursive function
// is a special kind of recursive function that does not call itself.
// [@(...)] is used in ATS to group arguments for variadic functions
//
fn fact_usage
  (cmd: string): void =
  prerrln! ("Usage: ", cmd, " [integer]")
// end of [fact_usage]

(* ****** ****** *)

implement
main (argc, argv) = let
in
//
if argc >= 2 then let
  val n = g0string2int_int(argv[1])
  val (
  ) = println! ("factorial of ", n, " = ", fact (n))
in
  0 (*normal*)
end else let
  val () = fact_usage (argv[0]) in exit(1)
end // end of [if]
//
end // end of [main]

(* ****** ****** *)

(* end of [fact1.dats] *)

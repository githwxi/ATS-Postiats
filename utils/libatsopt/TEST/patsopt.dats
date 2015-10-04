(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
(*
//
// HX-2015-10-02:
// This is actually in ATS2!
//
*)
//
extern
fun
patsopt_main
  {n:pos}
(
  argc: int(n), argc: !argv(n)
) : void = "ext#libatsopt_patsopt_main"
//
extern
fun
libatsopt_dynloadall((*void*)): void = "ext#"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
(
//
if
(argc >= 2)
then let
//
val () =
  libatsopt_dynloadall()
in
  patsopt_main (argc, argv)
end // end of [then]
else prerrln! ("Hello from ATS2(ATS/Postiats)!")
// end of [if]
) (* end of [main0] *)

(* ****** ****** *)

(* end of [patsopt.dats] *)

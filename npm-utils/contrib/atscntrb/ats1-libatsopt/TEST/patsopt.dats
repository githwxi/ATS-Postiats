(*
//
// HX-2015-10-02:
// this is in ATS1!
//
*)
(* ****** ****** *)
//
(*
staload
"./../DATS/libatsopt_ext.dats"
*)
//
(* ****** ****** *)
//
extern
fun
libatsopt_dynloadall
(
(*void*)
) : void = "ext#libatsopt_dynloadall"
//
(* ****** ****** *)
//
extern
fun
patsopt_main_opt
  {n:pos}
(
  argc: int(n), argv: &(@[string][n])
) : bool = "ext#libatsopt_patsopt_main_opt"
//
(* ****** ****** *)

implement
main(argc, argv) =
(
//
if
(argc >= 2)
then let
//
val () =
  libatsopt_dynloadall()
val opt =
  patsopt_main_opt(argc, argv)
in
//
if
opt
then println! ("[patsopt] exited normally!")
else println! ("[patsopt] exited abnormally!")
//
end // end of [then]
else prerrln! ("Hello from ATS2(ATS/Postiats)!")
// end of [if]
//
) (* end of [main0] *)

(* ****** ****** *)

(* end of [patsopt.dats] *)

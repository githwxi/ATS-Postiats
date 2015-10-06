(*
//
// HX-2015-10-02: this is in ATS1!
//
*)
(* ****** ****** *)

staload "./../SATS/libatsopt_ext.sats"

(* ****** ****** *)

implement
main (argc, argv) =
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
//
) (* end of [main0] *)

(* ****** ****** *)

(* end of [patsopt.dats] *)

(*
//
// HX-2015-10-02: this is in ATS1!
//
*)
(* ****** ****** *)

staload "./../../SATS/libatsopt_ext.sats"

(* ****** ****** *)
//
%{^
//
#include <emscripten.h>
//
void
PATSHOME_mount()
{
//
#if(JS_TYPE==NODEJS)
EM_ASM(
  FS.mkdir('/PATSHOME');
  FS.mount(NODEFS, { root: './PATSHOME' }, '/PATSHOME');
); // EM_ASM
#endif // end of [#if]
//
return ;
//
} /* PATSHOME_mount */

%} // end of [%{^]
//
extern
fun PATSHOME_mount(): void = "mac#"
//
(* ****** ****** *)

extern
fun
libatsopt_the_fixity_load
  (PATHSOME: string): void = "ext#"

(* ****** ****** *)

implement
main (argc, argv) = let
//
val () = PATSHOME_mount()
//
in
//
if
(argc >= 2)
then let
//
val () =
  libatsopt_dynloadall()
(*
val () =
  println! ("libatsopt_dynloadall: finished")
*)
//
val opt =
  patsopt_main_opt (argc, argv)
in
//
if
opt
then println! ("[patsopt] finished normally!")
else println! ("[patsopt] terminated abnormally!")
//
end // end of [then]
else prerrln! ("Hello from ATS2(ATS/Postiats)!")
// end of [if]
//
end (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt.dats] *)

(* ****** ****** *)
(*
//
// HX-2015-10-02:
// this is in ATS1!!!
//
*)
(* ****** ****** *)
//
(*
staload
"./../../DATS/libatsopt_ext.dats"
*)
//
extern
fun
libatsopt_dynloadall
(
(*void*)
) : void = "ext#libatsopt_dynloadall"
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
fun
PATSHOME_mount(): void = "mac#"
//
(* ****** ****** *)
//
extern
fun
libatsopt_the_fixity_load
  (PATHSOME: string): void = "ext#"
//
(* ****** ****** *)

implement
main(argc, argv) = let
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
val
opt =
patsopt_main_opt(argc, argv)
//
in
//
if
opt
then prerrln! ("[patsopt] finished normally!")
else prerrln! ("[patsopt] terminated abnormally!")
//
end // end of [then]
else prerrln! ("Hello from ATS2(ATS/Postiats)!")
// end of [if]
//
end (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt.dats] *)

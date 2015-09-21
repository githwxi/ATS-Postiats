(*
** For generating CATS-files
** targeting various platforms
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./CATS/integer_gen.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val () = integer_gen_main(out)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [prelude_cats.dats] *)

(* ****** ****** *)
(*
** For testing libatsrec
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)

val line1 = "[name]:"

(* ****** ****** *)

implement
main0() = () where
{
//
val-
~Some_vt(key) = line_get_key(line1)
//
val ((*void*)) = println! ("line1: key = ", key)
//
val ((*void*)) = strptr_free(key)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

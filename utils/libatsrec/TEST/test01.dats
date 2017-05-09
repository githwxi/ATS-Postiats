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

val line1 = "[name]: what is my name?\\"
val line2 = " My name is very strange!!!\\"
val line3 = " My name is very strange!!!"

(* ****** ****** *)

implement
main0() = () where
{
//
val ke = line_is_key(line1)
//
val () = assertloc (ke >= 0)
//
val key = line_get_key(line1, ke)
//
val ((*void*)) = println! ("line1: key = ", key)
//
val ((*void*)) = strptr_free(key)
//
val (key, value) = line_lines_get_key_value(line1, list_pair(line2, line3))
//
val ((*void*)) = println! ("line1: key = (", key, ")")
val ((*void*)) = println! ("line1: value = (", value, ")")
//
val ((*void*)) = strptr_free(key)
val ((*void*)) = strptr_free(value)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

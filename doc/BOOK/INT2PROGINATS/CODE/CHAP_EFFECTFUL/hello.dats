(*
** Some code
** used in the book INT2PROGINATS
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail hwxiATcsDOTbuDOTedu
** Time: January, 2011
*)

(* ****** ****** *)

(*
** Ported to ATS2 by HX-2013-09
*)

(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

implement
main0 () =
{
//
val out =
fileref_open_exn
  ("hello.txt", file_mode_w)
//
val () =
fprint_string (out, "Hello, world!\n")
//
val ((*closed*)) = fileref_close (out)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [hello.dats] *)

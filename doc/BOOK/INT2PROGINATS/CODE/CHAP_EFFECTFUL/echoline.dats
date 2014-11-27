(*
** Some code used
** in the book INT2PROGINATS
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
main0 (
// argumentless
) = loop () where
{
//
fun loop (): void = let
  val isnot = fileref_isnot_eof (stdin_ref)
in
//
if isnot then let
  val line =
    fileref_get_line_string (stdin_ref)
  val ((*void*)) = fprintln! (stdout_ref, line)
  val ((*void*)) = strptr_free (line)
in
  loop ()
end else ((*loop exits as the end-of-file is reached*))
//
end (* end of [loop] *)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [echoline.dats] *)

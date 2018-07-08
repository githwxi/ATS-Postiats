(* ****** ****** *)
(*
** For testing libatsrec
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
macdef
streamize_fileref_line =
streamize_fileref_line
//
(* ****** ****** *)
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $LIBATSREC // opening it
#staload $STRINGBUF // opening it
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)

implement
main0(argc, argv) =
fileref_close(inp) where
{
//
val opt =
fileref_open_opt
  ("DATA/theQuestionDB.arec", file_mode_r)
val-
~Some_vt(inp) = opt
//
val xs = streamize_fileref_gvhashtbl(inp, 8)
//
val ((*void*)) =
  stream_vt_foreach_cloptr(xs, lam(x) => fprintln!(stdout_ref, x))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test03.dats] *)

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
process_key_value<>
  (key, value) = let
//
val () = println!("key = (", key, ")")
val () = println!("value = (", value, ")")
//
in
  strptr_free(key) ; strptr_free(value)
end // end of [process_key_value]

(* ****** ****** *)

implement
main0(argc, argv) = let
//
val opt =
fileref_open_opt
  ("DATA/theQuestionDB.arec", file_mode_r)
val-
~Some_vt(inp) = opt
val xs =
  streamize_fileref_line(inp)
//
val lines =
  stream_vt_imap_fun(xs, lam(n, x) => LINENUM(n, x))
//
val glines = lines_grouping(lines)
//
val ((*void*)) =
  stream_vt_foreach_cloptr(glines, lam(x) => process_linenumlst(x))
//
in
  fileref_close(inp)
end // end of [main0]

(* ****** ****** *)

(* end of [test02.dats] *)

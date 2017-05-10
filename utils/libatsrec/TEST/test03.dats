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
#include "./../mylibies_link.hats"
//
(* ****** ****** *)
//
#staload "libats/SATS/stringbuf.sats"
#staload _ = "libats/DATS/stringbuf.dats"
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

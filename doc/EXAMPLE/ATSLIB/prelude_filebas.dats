(*
** for testing [prelude/filebas]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
val inp = stdin_ref
val ( ) = while (true)
{
  val str =
    fileref_get_line_string (inp)
  val iseof = fileref_is_eof (inp)
  val () =
    if ~iseof then println! (str)
  val () = strptr_free (str)
  val () = if iseof then $break
}
val ( ) = fileref_close (inp)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_filebas.dats] *)

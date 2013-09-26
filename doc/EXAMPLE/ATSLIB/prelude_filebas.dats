(*
** for testing [prelude/filebas]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
val name =
"/home/hwxi/research/Postiats/git/doc/EXAMPLE/ATSLIB/prelude_filebas.dats"
//
val (fpf | ext) = filename_get_ext (name)
val out = stdout_ref
val () = fprintln! (out, "ext = ", ext)
prval () = fpf (ext)
//
val (fpf | base) = filename_get_base (name)
val out = stdout_ref
val () = fprintln! (out, "base = ", base)
prval () = fpf (base)
//
} // end of [val]

(* ****** ****** *)

val () =
{
val inp =
fileref_open_exn
  ("./prelude_filebas.dats", file_mode_r)
//
val (
) = while (true)
{
  val line =
    fileref_get_line_string (inp)
  val iseof = fileref_is_eof (inp)
  val () = if ~iseof then println! (line)
  val () = strptr_free (line)
  val () = if iseof then $break
}
//
val () = fileref_close (inp)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_filebas.dats] *)

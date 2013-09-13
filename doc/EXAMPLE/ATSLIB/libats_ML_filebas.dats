(*
** for testing [libats/ML/filebas]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

staload "libats/ML/SATS/filebas.sats"

(* ****** ****** *)

val () =
{
//
val-~Some_vt(filr) =
  fileref_open_opt ("./libats_ML_filebas.dats", file_mode_r)
//
fun loop
(
  out: FILEref, i: int
) : void = let
  val isnot = fileref_isnot_eof (filr)
in
  if isnot then let
    val line = fileref_get_line_string (filr)
    val ((*void*)) = fprintln! (out, "line ", i, ":", line)
  in
    loop (out, i+1)
  end else
    fileref_close (filr)
  // end of [if]
end // end of [loop]
//
val () = loop (stdout_ref, 1(*i*))
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val-~Some_vt(filr) =
  fileref_open_opt ("./libats_ML_filebas.dats", file_mode_r)
//
fun loop
(
  out: FILEref, xs: list0 (string), i: int
) : void =
(
  case+ xs of
  | list0_nil () => ()
  | list0_cons (x, xs) =>
    (
      fprintln! (out, "line(", i, ") = ", x); loop (out, xs, i+1)
    ) (* end of [cons0] *)
)
//
val lines = fileref_get_lines_stringlst (filr)
//
val () = loop (stdout_ref, lines, 1)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val out = stdout_ref
val fnames = dirname_get_fnamelst (".")
val () = fprintln! (out, "fnames(.) = ", fnames)
val out = stdout_ref
val fnames = dirname_get_fnamelst ("..")
val () = fprintln! (out, "fnames(..) = ", fnames)
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_filebas.dats] *)

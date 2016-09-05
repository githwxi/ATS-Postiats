(*
** For testing
** [prelude/filebas]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/sys/stat.sats"
staload "libc/SATS/sys/types.sats"

(* ****** ****** *)
//
fun
test_file_ixusr
  (path: string): int = let
  macdef S_IXUSR = $UN.cast{uint}(S_IXUSR)
in
  test_file_mode_fun (path, lam (mode) => (mode land S_IXUSR) != 0u)
end // end of [test_file_ixusr]
//
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
//
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

val () =
{
//
val inp =
fileref_open_exn
  ("./prelude_filebas.dats", file_mode_r)
//
val () =
while (true)
{
  val word = fileref_get_word<> (inp)
  val isnot = ptrcast (word) > the_null_ptr
  val () =
  if isnot then fprintln! (stdout_ref, word)
  val () = strptr_free (word)
  val () = if isnot then $continue else $break
}
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
val inp =
fileref_open_exn
  ("./prelude_filebas.dats", file_mode_r)
//
implement
{env}(*tmp*)
fileref_foreach$fwork (c, env) = fprint_char (stdout_ref, toupper(c))
//
val () = fileref_foreach (inp)
//
val ((*void*)) = fileref_close (inp)
//
} (* end of [val] *)

(* ****** ****** *)

val () = assertloc (test_file_isdir(".") = 1)  
val () = assertloc (test_file_ixusr("./prelude_filebas.exe") = 1)
val () = assertloc (test_file_isreg("./prelude_filebas.dats") = 1)
  
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_filebas.dats] *)

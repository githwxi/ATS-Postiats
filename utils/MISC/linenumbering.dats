(*
** This is mainly for numbering lines in a program
*)

(*
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)
//
staload _(*anon*) = "prelude/DATS/integer.dats"
//
(* ****** ****** *)

fun linecopy
(
  inp: FILEref, out: FILEref, nl: int, pos: int
) : void = let
//
val c = fgetc (inp)
//
in
//
if c >= 0 then let
//
  val () =
  if pos = 0 then
  {
    val () = fprint! (out, "(*")
    val _(*err*) = $extfcall (int, "fprintf", out, "%.4d", nl)
    val () = fprint! (out, "*) ")
  } (* end of [val] *)
  val () = fputc_exn (c, out)
//
in
  if c != '\n' then linecopy (inp, out, nl, pos+1) else fflush_exn (out)
end (* end of [if] *)
//
end (* end of [linecopy] *)

(* ****** ****** *)

fun linecopy2
(
  inp: FILEref, out: FILEref, nl: int
) : void = let
in
  linecopy (inp, out, nl, 0)
end (* end of [linecopy2] *)

(* ****** ****** *)

fun linenumbering
(
  inp: FILEref, out: FILEref, nl: int
) : int = let
//
val iseof = feof (inp)
//
in
//
if iseof = 0 then let
  val () = linecopy2 (inp, out, nl)
in
  linenumbering (inp, out, nl + 1)
end else (nl) // end of [if]
//
end // end of [linenumbering]

(* ****** ****** *)

implement
main0 (argc, argv) = let
//
var inp: FILEref = stdin_ref
var out: FILEref = stdout_ref
//
val () =
if argc >= 2 then
  inp := fileref_open_exn (argv[1], file_mode_r)
val () =
if argc >= 3 then
  out := fileref_open_exn (argv[2], file_mode_w)
//
val ntot = linenumbering (inp, out, 0)
//
val () = if argc >= 2 then fclose_exn (inp)
val () = if argc >= 3 then fclose_exn (out)
//
in
  // nothing
end (* end of [main0] *)

(* ****** ****** *)

(* end of [linenumbering.dats] *)

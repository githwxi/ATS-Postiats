(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Somewhere in 2016
//
(* ****** ****** *)
(*
**
** RosettaCode:
** Remove_lines_from_a_file
**
*)
(* ****** ****** *)

(*

Remove a specific line or a number of lines from a file.

This should be implemented as a routine that takes three parameters
(filename, starting line, and the number of lines to be removed).

For the purpose of this task, line numbers and the number of lines start at
one, so to remove the first two lines from the file foobar.txt, the
parameters should be: foobar.txt, 1, 2

Empty lines are considered and should still be counted, and if the
specified line is empty, it should still be removed.

An appropriate message should appear if an attempt is made to remove lines
beyond the end of the file.

*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#staload
"libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)
//
extern
fun
Remove_lines_from_a_file
(
  path: string, start: intGte(1), nrmvd: intGte(1)
) : void // Remove_lines_from_a_file
//
(* ****** ****** *)

implement
Remove_lines_from_a_file
  (path, start, nrmvd) = let
//
val
opt = fileref_open_opt(path, file_mode_r)
//
fnx
loop1
(
  filr: FILEref, i: int
) : void = (
//
if
fileref_isnot_eof(filr)
then let
val
line =
fileref_get_line_string(filr)
//
val
line2 =
  $UNSAFE.strptr2string(line)
//
val () =
if (start <= i && i < start+nrmvd) then () else println! (line2)
//
val ((*void*)) = strptr_free(line)
//
in
  loop1(filr, i+1)
end // end of [then]
//
) (* end of [loop1] *)
//
in
//
case+ opt of
//
| ~Some_vt(filr) => loop1 (filr, 1)
//
| ~None_vt((*void*)) =>
  (
    prerrln!("The given file [", path, "] cannot be opened!")
  ) (* end of [None_vt] *)
//
end // end of [Remove_lines_from_a_file]

(* ****** ****** *)

implement
main0(argc, argv) = () where
{
//
(*
val () =
println!
(
"Hello from [Remove_lines_from_a_file]!"
) (* println! *)
*)
//
val start = (if argc >= 2 then atoi(argv[1]) else 1): int
val nrmvd = (if argc >= 3 then atoi(argv[2]) else 1): int
//
val start = g1ofg0(start)
val start = ckastloc_gintGte(start, 1)
val nrmvd = g1ofg0(nrmvd)
val nrmvd = ckastloc_gintGte(nrmvd, 1)
//
val () = Remove_lines_from_a_file("Remove_lines_from_a_file.dats", start, nrmvd)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Remove_lines_from_a_file.dats] *)

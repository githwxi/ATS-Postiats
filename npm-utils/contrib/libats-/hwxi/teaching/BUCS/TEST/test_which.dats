(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
STDLIB =
"libats/libc/SATS/stdlib.sats"

(* ****** ****** *)

#include "./../DATS/BUCS320.dats"

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val () =
if
(argc <= 1)
then
{
val () =
fprintln!
(
stderr_ref, "Usage: ", argv[0], " ", "<command>"
) (* end of [val] *)
} (* end of [if] *)
//
val () =
assertloc(argc >= 2)
//
val command = argv[1]
//
val (fpf | path) = $STDLIB.getenv("PATH")
//
val () =
if
(
strptr2ptr(path) = 0
) then
{
//
val () =
prerrln! ("The environment variable [PATH] is undefined!")
val () = exit(1){void}
//
} (* end of [if] *)
//
(*
val () = println! ("PATH = ", path)
*)
//
fun test
(
  dir: string, command: string
) : int = let
//
val path =
  string_append(dir, "/", command)
val answer =
  test_file_ixoth ($UN.strptr2string(path))
//
val ((*void*)) = strptr_free(path)
//
in
  answer
end // end of [test]
//
val () =
assertloc (strptr2ptr(path) > 0)
//
val dirs =
string_split_delim_string($UN.strptr2string(path), ":")
//
prval ((*void*)) = fpf (path)
//
val () = let
//
fun loop
(
  dirs: List_vt(Strptr1), command: string
) : void =
  case+ dirs of
  | ~list_vt_nil () => ()
  | ~list_vt_cons
      (dir, dirs) => let
      val ans =
        test ($UN.strptr2string(dir), command)
      val ((*void*)) =
        if ans >= 1 then println! (dir, "/", command)
      val ((*freed*)) = strptr_free(dir)
    in
      loop (dirs, command)
    end // end of [list_vt_cons]
//
in
  loop (dirs, command)
end // end of [val]
//
} (* end of [main0] *)
  
(* ****** ****** *)

(* end of [test_which.dats] *)

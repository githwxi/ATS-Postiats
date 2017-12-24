(* ****** ****** *)
(*
** Testing find_cli
*)
(* ****** ****** *)
//
// HX-2017-12-14:
// This is a memory clean
// implementation. Please
// use [valgrind] to check it!
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#include "./../mylibies.hats"

(* ****** ****** *)

#staload "libats/libc/DATS/dirent.dats"
#staload "prelude/DATS/filebas_dirent.dats"

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val
dir =
(
if argc >= 2 then argv[1] else "."
) : string
//
val-
~Some_vt
(fnames) =
$FindCli.streamize_dirname_fname<>(dir)
//
val ((*void*)) =
(fnames).foreach()(lam(x) => (println!(x); free(x)))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

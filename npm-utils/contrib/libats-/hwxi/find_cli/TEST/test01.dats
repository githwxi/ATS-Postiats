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

#staload "libats/libc/SATS/fnmatch.sats"

(* ****** ****** *)

#staload "libats/libc/DATS/dirent.dats"
#staload "prelude/DATS/filebas_dirent.dats"

(* ****** ****** *)

local

val
streamize_dirname_fname$recurse_ =
$FindCli.streamize_dirname_fname$recurse<>

in (* in-of-local *)
//
implement
$FindCli.streamize_dirname_fname$recurse<>
(
l0, dir, fname
) =
ifcase
| fnmatch_null
  (".*", fname) = 0 => false
| _(* else *) =>
  streamize_dirname_fname$recurse_(l0, dir, fname)
//
implement
$FindCli.streamize_dirname_fname$select<>
(
l0, dir, fname
) =
(
ifcase
| fnmatch_null
  ("*~", fname) = 0 => true | _(* else *) => false
)
//
end // end of [streamize_dirname_fname$select]

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

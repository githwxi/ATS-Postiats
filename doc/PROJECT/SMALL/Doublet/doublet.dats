(*
** Implementing the doublet game
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/strarr.sats"
//
staload _ = "libats/ML/DATS/list0.dats"
staload _ = "libats/ML/DATS/array0.dats"
staload _ = "libats/ML/DATS/strarr.dats"
//
(* ****** ****** *)

staload "./doublet.sats"

(* ****** ****** *)
//
dynload "./doublet.sats"
//
(* ****** ****** *)
//
dynload "./doublet_dict.dats"
dynload "./doublet_word.dats"
dynload "./doublet_search.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () =
if (argc < 3) then
{
//
val () =
  println! ("Usage: ", argv[0], " <word1>", " <word2>")
//
} (* end of [if] *)
val () = if (argc < 3) then exit (1) // HX: abnormal exit
//
val () =
println!
  ("Starting the doublet game:")
//
val src =
  (if argc >= 2 then argv[1] else ""): string
val dst =
  (if argc >= 3 then argv[2] else ""): string
//
val src = strarr_make_string (src)
val dst = strarr_make_string (dst)
//
val opt = doublet_search (src, dst)
//
val () =
(
case+ opt of
| ~Some_vt (ws) =>
  {
    val ws = list0_reverse (ws)
    val () =
    println! ("[", src, "] and [", dst, "] are a doublet: ", ws)
  }
| ~None_vt ((*void*)) =>
    println! ("[", src, "] and [", dst, "] are not a doublet!")
)
//
val () =
println!
  ("Finishing the doublet game.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [doublet.dats] *)

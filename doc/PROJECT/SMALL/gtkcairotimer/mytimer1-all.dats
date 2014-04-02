(* ****** ****** *)
//
// HX-2014-03-31:
// This is a single-file
// version of mytimer1.dats
//
(* ****** ****** *)

staload
gtkcairotimer_toplevel =
{
#include "./gtkcairotimer_toplevel.dats"
}

(* ****** ****** *)

staload
mytimer1 =
{
#define MYTIMER1_ALL 1; #include "./mytimer1.dats"
}

(* ****** ****** *)

(* end of [mytimer1-all.dats] *)

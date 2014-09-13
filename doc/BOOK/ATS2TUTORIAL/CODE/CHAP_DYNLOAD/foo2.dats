(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define DYNLOADFLAG 0

(* ****** ****** *)

staload "./foo.dats"

(* ****** ****** *)

dynload "./foo.dats" // for initialization

(* ****** ****** *)

implement
main0 () =
{
//
val () = assertloc (4003000 = sum_x_y_z())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [foo2.dats] *)


(* ****** ****** *)
//
// HX-2014-06-18
//
(* ****** ****** *)
//
//
#include
"share/atspre_staload.hats"
//
// How to compile:
// patscc -DATS_MEMALLOC_LIBC -o $@ $<
//
(* ****** ****** *)

fun
make_rand
(
// argumentless
) : () -<cloref1> ulint = let
  val state = ref<ulint> (31415926536UL)
in
//
lam
(
// argumentless
) : ulint => let
  val old = !state
  val new = (old * 196314165UL) + 907633515UL
  val ((*void*)) = !state := new
in
  new
end // end of [lam]
//
end // end of [make_rand]
          
(* ****** ****** *)
          
implement
main0 () =
{
//
val rand = make_rand()
//
val () = println! ("rand() = ", rand())
val () = println! ("rand() = ", rand())
val () = println! ("rand() = ", rand())
//
} (* end of [main0] *)
          
(* ****** ****** *)

(* end of [qa-list-285.dats] *)

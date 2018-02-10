//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
(*
**
** Linear random number generator
**
*)
(* ****** ****** *)
//
// How to test:
// ./randerlin
// valgrind ./randerlin
//
// How to compile:
// patscc -DATS_MEMALLOC_LIBC -o randerlin randerlin.dats
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

vtypedef
randerlin = streamer_vt (ulint)

(* ****** ****** *)

extern
fun randerlin_make (): randerlin

(* ****** ****** *)

implement
randerlin_make () = let
//
fun aux
(
  state: ulint
) : stream_vt (ulint) = $ldelay
(
//
let
//
val state =
  (state * 196314165UL) + 907633515UL
//
in
  stream_vt_cons (state, aux (state))
end
//
) (* end of [$ldelay] *) // end of [val]
//
in
  streamer_vt_make (aux (31435926536UL(*init*)))
end // end of [randerlin_make]

(* ****** ****** *)

implement
main0 () =
{
//
val r0 = randerlin_make ()
//
val () = println! ("randerlin(r0) = ", r0[])
val () = println! ("randerlin(r0) = ", r0[])
val () = println! ("randerlin(r0) = ", r0[])
//
val () = ~r0 // freeing the random number generator
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [randerlin.dats] *)

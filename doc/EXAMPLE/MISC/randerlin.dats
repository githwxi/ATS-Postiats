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
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

datavtype
rander = RANDER of stream_vt (ulint)

(* ****** ****** *)

extern
fun
rander (!rander): ulint

(* ****** ****** *)

extern
fun rander_make (): rander
extern
fun rander_free (r: rander): void
overload ~ with rander_free

(* ****** ****** *)

implement
rander (r) = let
//
val+@RANDER (xs) = r
val-~stream_vt_cons (x, xs2) = !xs
val () = xs := xs2
prval () = fold@ (r)
//
in
  x
end // end of [rander]

(* ****** ****** *)

implement
rander_make () = let
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
  RANDER (aux (31435926536UL(*init*)))
end // end of [rander_make]

(* ****** ****** *)

implement
rander_free (r) = let val~RANDER(xs) = r in ~xs end

(* ****** ****** *)

implement
main0 () =
{
//
val r0 = rander_make ()
//
val () = println! ("rander(r0) = ", rander(r0))
val () = println! ("rander(r0) = ", rander(r0))
val () = println! ("rander(r0) = ", rander(r0))
//
val () = ~r0 // freeing the random number generator
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [randerlin.dats] *)

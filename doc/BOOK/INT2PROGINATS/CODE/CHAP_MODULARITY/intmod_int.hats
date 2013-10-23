(*
** implementing some integer operations based on doubles
*)

(* ****** ****** *)

#ifndef INTMOD_INT
#define INTMOD_INT 1

(* ****** ****** *)

typedef T = T_INTMOD_INT

(* ****** ****** *)

implement ofint0<T> = 0
implement ofint1<T> = 1

(* ****** ****** *)

implement ofint<T> (x) = x
implement fprint_int<T> (out, x) = fprintf (out, "%i", @(x))

implement intneg<T> (x) = ~x
implement intadd<T> (x, y) = x + y
implement intsub<T> (x, y) = x - y
implement intmul<T> (x, y) = x * y
implement intdiv<T> (x, y) = x / y
implement intmod<T> (x, y) = op mod (x, y)

(* ****** ****** *)

implement intcmp<T> (x, y) = compare (x, y)

(* ****** ****** *)

#endif // end of [INTMOD_INT]

(* ****** ****** *)

(* end of [intmod_int.hats] *)

(*
** implementing some integer operations based on doubles
*)

(* ****** ****** *)

#ifndef INTMOD_DBL
#define INTMOD_DBL 1

(* ****** ****** *)

typedef T = T_INTMOD_DBL

(* ****** ****** *)

implement ofint0<T> = 0.0
implement ofint1<T> = 1.0

(* ****** ****** *)

implement ofint<T> (x) = double_of (x)
implement fprint_int<T> (out, x) = fprintf (out, "%.0f", @(x))

implement intneg<T> (x) = ~x
implement intadd<T> (x, y) = x + y
implement intsub<T> (x, y) = x - y
implement intmul<T> (x, y) = x * y
implement intdiv<T> (x, y) = $M.trunc (x / y)

implement intmod<T> (x, y) = $M.fmod (x, y)

(* ****** ****** *)

implement intcmp<T> (x, y) = compare (x, y)

(* ****** ****** *)

#endif // end of [INTMOD_DBL]

(* ****** ****** *)

(* end of [intmod_dbl.hats] *)

(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/list0.dats"

(* ****** ****** *)

typedef charint = (char, int)
typedef intchar = (int, char)
fun swap_char_int (xy: charint): intchar = (xy.1, xy.0)
fun swap_int_char (xy: intchar): charint = (xy.1, xy.0)

fun{a,b:t@ype}
swap (xy: (a, b)): (b, a) = (xy.1, xy.0)
fun swap_char_int (xy: charint): intchar = swap<char,int> (xy)
fun swap_int_char (xy: intchar): charint = swap<int,char> (xy)

fun{a:t@ype}{b:t@ype}
swap2 (xy: (a, b)): (b, a) = (xy.1, xy.0)
fun swap_char_int (xy: charint): intchar = swap2<char><int> (xy)
fun swap_int_char (xy: intchar): charint = swap2<int><char> (xy)

(* ****** ****** *)

typedef cfun (t1:t@ype, t2:t@ype) = t1 -<cloref1> t2

fun{a,b,c:t@ype} compose
  (f: cfun (a, b), g: cfun (b, c)):<cloref1> cfun (a, c) = lam x => g(f(x))
// end of [compose]

val plus1 = lam (x:int): int =<cloref> x+1
val times2 = lam (x:int): int =<cloref> x*2

val f_2x_1: cfun (int, int) = compose (times2, plus1)
val f_2x_2: cfun (int, int) = compose (plus1, times2)

(* ****** ****** *)

val () = assertloc (f_2x_1 (100) = 201)
val () = assertloc (f_2x_2 (100) = 202)

(* ****** ****** *)

fun{a:t@ype}
list0_length (xs: list0 a): int = case+ xs of
  | list0_cons (_, xs) => 1 + list0_length (xs) | list0_nil () => 0
// end of [list0_length]

fun{a:t@ype}
list0_last (xs: list0 a): option0 (a) = let
  fun loop (x: a, xs: list0 a): a = case+ xs of
    | list0_nil () => x | list0_cons (x, xs) => loop (x, xs)
  // end of [loop]
in
  case+ xs of
  | list0_nil () => option0_none ()
  | list0_cons (x, xs) => option0_some (loop (x, xs))
end // end of [list0_last]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement randgen<T> () = drand48 ()
implement fprint_elt<T> (out, x) = fprint_double (out, x)

(* ****** ****** *)

implement
main () = () where {
//
  #define N 100
  val xs = list0_randgen<T> (N)
  val () = assertloc (list0_length (xs) = N)
  val- option0_some last = list0_last (xs)
  val () = assertloc (last = list0_head_exn (list0_reverse (xs)))
//
} // end of [main]

(* ****** ****** *)

(* end of [misc.dats] *)

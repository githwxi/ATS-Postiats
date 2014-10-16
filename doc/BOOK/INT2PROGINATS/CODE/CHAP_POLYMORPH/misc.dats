(*
** Some code
// used in the book INT2PROGINATS
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

typedef
charint = (char, int)
typedef
intchar = (int, char)

(* ****** ****** *)

fun swap_char_int (xy: charint): intchar = (xy.1, xy.0)
fun swap_int_char (xy: intchar): charint = (xy.1, xy.0)

(* ****** ****** *)
//
fun{
a,b:t@ype
} swap (xy: (a, b)): (b, a) = (xy.1, xy.0)
//
fun swap_char_int (xy: charint): intchar = swap<char,int> (xy)
fun swap_int_char (xy: intchar): charint = swap<int,char> (xy)
//
(* ****** ****** *)

fun
{a:t@ype}
{b:t@ype}
swap2 (xy: (a, b)): (b, a) = (xy.1, xy.0)
fun swap_char_int (xy: charint): intchar = swap2<char><int> (xy)
fun swap_int_char (xy: intchar): charint = swap2<int><char> (xy)

(* ****** ****** *)

typedef
cfun (t1:t@ype, t2:t@ype) = t1 -<cloref1> t2

(* ****** ****** *)

fun{
a,b,c:t@ype
} compose (
  f: cfun (a, b), g: cfun (b, c)
) :<cloref1> cfun (a, c) = lam x => g(f(x))

val plus1 = lam (x:int): int =<cloref> x+1
val times2 = lam (x:int): int =<cloref> x*2

val f_2x_1 = compose<int,int,int> (times2, plus1)
val f_2x_2 = compose<int,int,int> (plus1, times2)

(* ****** ****** *)

val () = assertloc (f_2x_1 (100) = 201)
val () = assertloc (f_2x_2 (100) = 202)

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _(*anon*) = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

fun{
a:t@ype
} list0_length
  (xs: list0 a): int =
(
  case+ xs of
  | list0_cons
      (_, xs) => 1 + list0_length<a> (xs)
  | list0_nil () => 0
) // end of [list0_length]

(* ****** ****** *)

fun{
a:t@ype
} list0_last
  (xs: list0 a): option0 (a) = let
  fun loop
  (
    x: a, xs: list0 a
  ) : a =
  (
    case+ xs of
    | list0_nil () => x
    | list0_cons (x, xs) => loop (x, xs)
  ) // end of [loop]
in
  case+ xs of
  | list0_nil () => None0 ()
  | list0_cons (x, xs) => Some0{a}(loop (x, xs))
end // end of [list0_last]

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"

(* ****** ****** *)
//
#define
ATSCNTRB_sourceloc
"http://www.ats-lang.org/LIBRARY/contrib"
#define
ATSCNTRB_targetloc "../.INT2PROGINATS-atscntrb"
//
staload RG =
"{$ATSCNTRB}/libats-hwxi/testing/SATS/randgen.sats"
staload _(*RG*) =
"{$ATSCNTRB}/libats-hwxi/testing/DATS/randgen.dats"
//
(* ****** ****** *)

typedef T = double
implement $RG.randgen_val<T> () = drand48 ()

(* ****** ****** *)

implement
main0 () =
{
//
#define N 100
val xs = g0ofg1 ($RG.randgen_list<T> (N))
val ((*void*)) = assertloc (list0_length<T> (xs) = N)
//
val-Some0(xz) = list0_last<T> (xs)
val ((*void*)) = assertloc (xz = list0_head_exn (list0_reverse (xs)))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [misc.dats] *)

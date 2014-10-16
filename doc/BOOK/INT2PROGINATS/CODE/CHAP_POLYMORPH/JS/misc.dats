(*
** Some code used
** in the book INT2PROGINATS
*)

(* ****** ****** *)

(*
** Ported to ATSCC2JS
** by Hongwei Xi (gmhwxiATgmailDOTcom)
** Time: October 14, 2014
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)

%{$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

typedef
charint = '(char, int)
typedef
intchar = '(int, char)

(* ****** ****** *)

fun swap_char_int (xy: charint): intchar = '(xy.1, xy.0)
fun swap_int_char (xy: intchar): charint = '(xy.1, xy.0)

(* ****** ****** *)
//
fun{
a,b:t@ype
} swap (xy: '(a, b)): '(b, a) = '(xy.1, xy.0)
//
fun swap_char_int (xy: charint): intchar = swap<char,int> (xy)
fun swap_int_char (xy: intchar): charint = swap<int,char> (xy)
//
(* ****** ****** *)

fun
{a:t@ype}
{b:t@ype}
swap2 (xy: '(a, b)): '(b, a) = '(xy.1, xy.0)
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

val plus1 = lam (x:int): int =<cloref1> x+1
val times2 = lam (x:int): int =<cloref1> x*2

val f_2x_1 = compose<int,int,int> (times2, plus1)
val f_2x_2 = compose<int,int,int> (plus1, times2)

(* ****** ****** *)

val () = println! ("f_2x_1(100) = ", f_2x_1(100))
val () = println! ("f_2x_2(100) = ", f_2x_2(100))

(* ****** ****** *)
//
typedef
list0(a:t@ype) = List0(a)
//
#define list0_nil list_nil
#define list0_cons list_cons
//
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
//
typedef
option0(a:t@ype) = Option(a)
//
#define Some0 Some
#define None0 None

(* ****** ****** *)

fun{
a:t@ype
} list0_last
  (xs: list0 a): option0 (a) = let
//
fun loop
(
  x: a, xs: list0 a
) : a =
(
  case+ xs of
  | list0_nil () => x
  | list0_cons (x, xs) => loop (x, xs)
) (* end of [loop] *)
//
in
  case+ xs of
  | list0_nil () => None0 ()
  | list0_cons (x, xs) => Some0{a}(loop (x, xs))
end // end of [list0_last]

(* ****** ****** *)

typedef T = int

(* ****** ****** *)

#define :: list_cons
#define cons list_cons
#define nil list_nil

(* ****** ****** *)

val () =
{
//
val xs =
(
  0 :: 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: 8 :: 9 :: nil
) : list0 (T)
//
val () = println! ("xs = ", xs)
val () = println! ("length(xs) = ", list0_length<T>(xs))
//
val-Some0(xz) = list0_last<T> (xs)
val () = println! ("last(xs) = ", xz)
//
} (* end of [val] *)

(* ****** ****** *)

(* end of [misc.dats] *)

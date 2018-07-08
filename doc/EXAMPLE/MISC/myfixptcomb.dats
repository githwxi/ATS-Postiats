//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
//
// Implementing fixed-point operator
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
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
fun
myfix
{a:type}
(
 f: lazy(a) -<cloref1> a
) : lazy(a) = $delay(f(myfix(f)))
//
val
fact =
myfix{int-<cloref1>int}
(
lam(ff)(x) => if x > 0 then x * !ff(x-1) else 1
)
(* ****** ****** *)

typedef
cfun(a:t@ype, b:t@ype) = a -<cloref1> b

(* ****** ****** *)
//
fun
{
a:t@ype
}{
b:t@ype
} myfix2
(
 f: cfun(a, b) -> cfun(a, b)
) : cfun(a, b) = lam x => f(myfix2(f))(x)
//
(* ****** ****** *)
//
val
fact2 =
myfix2<int><int>
(
lam(ff)(x) => if x > 0 then x * ff(x-1) else 1
)
(* ****** ****** *)
//
implement main0 () =
{
  val () = println! ("fact(10) = ", !fact(10))
  val () = println! ("fact2(10) = ", fact2(10))
}
//
(* ****** ****** *)

(* end of [myfixptcomb.dats] *)

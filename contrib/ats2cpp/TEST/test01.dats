(*
** For testing ats2cpp
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
extern
fun
fact(n: int): int = "ext#"
//
implement
fact(n) = if n > 0 then n * fact(n-1) else 1
//
(* ****** ****** *)
//
extern
fun
ffact(n: int): double = "ext#"
//
implement
ffact(n) = if n > 0 then n * ffact(n-1) else 1.0
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () = println! ("fact(10) = ", fact(10))
val () = println! ("ffact(10) = ", ffact(10))
//
} (* end of [main0] *)

(* ****** ****** *)

/*
%{$

#include <stdio.h>

int main()
{
  printf("fact(10) = %i\n", fact(10));
  printf("ffact(10) = %f\n", ffact(10));
  return 0;
}

%} // end of [%{$]
*/

(* ****** ****** *)

(* end of [test01.dats] *)

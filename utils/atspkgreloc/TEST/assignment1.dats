//
// Title:
// Concepts of Programming Languages
// Number: CAS CS 320
// Semester: Summer-1 2014
// Class Time: TR 10:00-12:00
// Instructor: Hongwei Xi (hwxiATbuDOTedu)
//
(*
//
// Assignment #1
//
*)
(* ****** ****** *)
//
#define
CS320WEBROOT "\
http://www.cs.bu.edu\
/~hwxi/academic/courses/CS320/Summer14\
"//
(* ****** ****** *)
//
#define
ATSPKGRELOCROOT ".CS320WEBROOT"
//
(* ****** ****** *)
//
#include
"{$CS320WEBROOT}/assignments/CS320-2014-Summer.hats"
//
(* ****** ****** *)
//
staload "{$CS320WEBROOT}/assignments/01/assignment1.sats"
//
(* ****** ****** *)

implement
triangle_test (x, y, z) =
(
  if x + y > z
    then
      if y + z > x
        then
          if z + x > y then true else false
        else false
      // end of [if]
    else false
  // end of [if]
)

(* ****** ****** *)
//
implement
fib (n) =
  if n >= 2 then fib(n-1) + fib(n-2) else n
//
(* ****** ****** *)

implement
fib2 (n, res1, res2) =
  if n >= 2
    then fib2 (n-1, res2, res1+res2)
    else (if n = 0 then res1 else res2)
  // end of [if]

(* ****** ****** *)

implement
main0 () = () where
{
//
val N = 10
//
val () = println! ("fib(", N, ") = ", fib(N))
val () = println! ("fib2(", N, ") = ", fib2(N, 0, 1))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [assignment1.dats] *)

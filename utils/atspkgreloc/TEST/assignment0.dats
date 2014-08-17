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
// Assignment #0
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
staload "{$CS320WEBROOT}/assignments/00/assignment0.dats"
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

implement
main0 () = () where
{
//
val N = 10
//
val () = assertloc (triangle_test (2, 3, 4)) // true
val () = assertloc (triangle_test (3, 4, 5)) // true
val () = assertloc (~triangle_test (1, 5, 6)) // ~false = true
//
val () = println! ("Good news: [assignment0] has passed initial testing!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [assignment0.dats] *)

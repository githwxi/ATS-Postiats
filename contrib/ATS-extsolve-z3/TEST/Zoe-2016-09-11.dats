(* ****** ****** *)
(*
** Solving a problem
** in Zoe's math book
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"libats/SATS/Number/real.sats"
//
(* ****** ****** *)
//
// the distance for the race
//
stacst H: real
//
(* ****** ****** *)
//
// the distance Sunny gained
// over Wendy at the end of the first race
//
stacst D: real
//
(* ****** ****** *)
//
// the time for the first race
//
stacst T1: real
//
// the time for the second race
//
stacst T2: real
//
(* ****** ****** *)

stacst VS: real // velocity of Sunny
stacst VW: real // velocity of Wendy

(* ****** ****** *)
//
extern
prfun
constraint1(): [H==VS*T1] void
extern
prfun
constraint2(): [H-D==VW*T1] void
extern
prfun
constraint3(): [H+D==VS*T2] void
//
(* ****** ****** *)

extern
prfun
myconclusion{H>0}(): [H-VW*T2==(D*D)/H] void

(* ****** ****** *)
//
primplement
myconclusion() = () where
{
  prval () = constraint1()
  prval () = constraint2()
  prval () = constraint3()
} (* end of [myconclusion] *)
//
(* ****** ****** *)

(* end of [zoe-2016-09-11.dats] *)

(*
**
//
// Factorials via GMP
//
** Author: Hongwei Xi
** Authoremail: hwxi AT gmail DOT com
** Start Time: February, 2013
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload T = "./../SATS/intinf_t.sats"
staload VT = "./../SATS/intinf_vt.sats"

(* ****** ****** *)

staload _(*T*) = "./../DATS/intinf_t.dats"
staload _(*VT*) = "./../DATS/intinf_vt.dats"

(* ****** ****** *)

overload print with $T.print_intinf
overload print with $VT.print_intinf

(* ****** ****** *)

fun
fact_t{i:nat}
(
  x: int (i)
) : $T.Intinf = let
in
//
if x > 0 then let
  val r1 = fact_t (x - 1)
in
  $T.mul_int_intinf (x, r1)
end else
  $T.int2intinf (1)
// end of [if]
//
end // end of [fact_t]

(* ****** ****** *)

fun
fact_vt{i:nat}
(
  x: int (i)
) : $VT.Intinf = let
in
//
if x > 0 then let
  val r1 = fact_vt (x - 1)
in
  $VT.mul_int_intinf0 (x, r1)
end else
  $VT.int2intinf (1)
// end of [if]
//
end // end of [fact]

(* ****** ****** *)

extern
fun atoi: string -> int = "mac#atoi"

(* ****** ****** *)

implement
main (
  argc, argv
) = let
  val N = 10
  val N = (
    if argc >= 2 then atoi (argv[1]) else N
  ) : int // end of [val]
  val N = g1ofg0_int (N)
  val () = assertloc (N >= 0)
//
  val res = fact_t (N)
  val () = println! ("fact_t(", N, ") = ", res)
//
  val res = fact_vt (N)
  val () = println! ("fact_vt(", N, ") = ", res)
  val () = $VT.intinf_free (res)
//
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)

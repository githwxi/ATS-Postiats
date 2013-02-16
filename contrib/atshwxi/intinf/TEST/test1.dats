(*
**
** Author: Hongwei Xi (hwxi AT gmail DOT com)
** Start Time: February, 2013
**
*)

(* ****** ****** *)

staload "atshwxi/intinf/SATS/intinf.sats"

(* ****** ****** *)

#define int2intinf (x) intinf_make_int (x)

(* ****** ****** *)

fun fact
  {i:nat} (
  x: int (i)
) : Intinf = let
in
//
if x > 0 then let
  val r1 = fact (x - 1)
  val r0 = x * r1
  val () = intinf_free (r1)
in
  r0
end else
  int2intinf (1)
// end of [if]
//
end // end of [fact]

(* ****** ****** *)

extern
fun atoi: string -> int = "ext#atslib_atoi"

implement
main (argc, argv) = let
  val N = 10
  val N = (
    if argc >= 2 then atoi (argv[1]) else N
  ) : int // end of [val]
  val N = g1ofg0_int (N)
  val () = assertloc (N >= 0)
  val res = fact (N)
  val () = println! ("fact(", N, ") = ", res)
  val () = intinf_free (res)
in
  0(*normalexit*)
end // end of [main]

(* ****** ****** *)

(* end of [test1.dats] *)
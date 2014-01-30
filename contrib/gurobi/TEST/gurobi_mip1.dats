(*
** Testing API for GUROBI
*)

(* ****** ****** *)

staload "./../SATS/gurobi.sats"

(* ****** ****** *)

fun mytest () =
{
//
var env: ptr
//
val errno =
GRBloadenv (env, stropt_some"gurobi_mip1.log")
val () =
if errno > 0 then prerrln! ("GRBloadenv: errno = ", errno)
//
val () = assertloc (errno = 0)
prval () = opt_unsome{GRBenvptr1}(env)
//
val () = GRBfreeenv (env)
//
} (* end of [mytest] *)

(* ****** ****** *)

implement
main0 () = () where
{
//
val () = println! ("Hello from [gurobi_mip1]!")
//
val () = mytest ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test00.dats] *)

(*
** Testing API for GUROBI
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/gurobi.sats"
staload "./../DATS/gurobi.dats"

(* ****** ****** *)

#define cap carrayptr
#define NULL the_null_ptr

(* ****** ****** *)

extern
fun mytest (): void
extern
fun mytest_main (!GRBenvptr1, !GRBmodelptr1): void

(* ****** ****** *)

implement mytest () =
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
prval ((*void*)) = opt_unsome (env)
//
var model: ptr
val errno =
GRBnewmodel_null (env, model, "mip1")
val () = fprint_GRBerrormsg_if (stderr_ref, env, errno)
val () = assertloc (errno = 0)
prval ((*void*)) = opt_unsome (model)
//
val () = mytest_main (env, model)
//
val errno = GRBfreemodel (model)
val () = assertloc (errno = 0)
//
val ((*freed*)) = GRBfreeenv (env)
//
} (* end of [mytest] *)

(* ****** ****** *)

implement
mytest_main (env, model) =
{
//
val () = println! ("Hello from [mytest_main]!")
//
} (* end of [mytest_main] *)

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

(* end of [gurobi_mip1.dats] *)

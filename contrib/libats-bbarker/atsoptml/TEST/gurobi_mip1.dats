(*
** Testing API for GUROBI
*)


//
// This is to test the low-level gurobi interface. 
// For the same problem using the atsoptml abstraction
// see mip1.dats

//
// Based on mip1_c.c in gurobi_dir/examples/c/
// (Gurobi version 5.6)
//

(* ****** ****** *)
//
//#include
//"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/gurobi.sats"
staload "./../DATS/gurobi.dats"

(* ****** ****** *)

//staload
//UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

//staload "libc/SATS/stdlib.sats"
//staload "libc/SATS/unistd.sats"

(* ****** ****** *)

(*
//NULLs ... not the greatest:
val NULL = stropt_none()
val NULD = $UN.ptr2cptr{double} ($UN.cast2Ptr0{stropt} (NULL)) 
val NULI = $UN.ptr2cptr{int} ($UN.cast2Ptr0{stropt} (NULL)) 
val NULC = $UN.ptr2cptr{char} ($UN.cast2Ptr0{stropt} (NULL)) 
//val NULCC = //  maybe need an array_make_nil fun
val NULCC = (arrayptr)$arrpsz{$GRB.varname}() 
*)

(* ****** ****** *)

extern
fun mytest (): void
//
extern
fun mytest_main (!GRBenvptr1, !GRBmodelptr1): void

(* ****** ****** *)

implement mytest () =
{
// Set up essential Gurobi varirables
var env: ptr
var model: ptr

//
//  Safe exit function closure
//  (may make a default overloaded fun and move 
//   gurobi.sats).
//

(*
fun QUIT(errno: int):<linclo1> void =
let
//
fun printErr(errno: int):<linclo1> int = 
($extfcall(int, "printf", "ERROR: %s\n", $GRB.geterrormsg(env)))
// end of [printErr]
val _ = if (errno != 0) then printErr(errno)
//
// Free potentially shared memory:
//  model and then environment
//
val errno = $GRB.freemodel(model)
val _ = if (errno != 0) then printErr(errno)
val errno = $GRB.freeenv(env)
val _ = if (errno != 0) then printErr(errno)
in
  exit(errno)
end // end of [QUIT]
*)

//
// Create environment
//
val errno =
GRBloadenv (env, stropt_some"gurobi_mip1.log")
val () =
if errno > 0 then prerrln! ("GRBloadenv: errno = ", errno)
//
val () = assertloc (errno = 0)
prval ((*void*)) = opt_unsome (env)
//val () = if error != 0 then QUIT(error)
//

//
// Create an empty model
//
val errno =
GRBnewmodel_null (env, model, "mip1")
val () = fprint_GRBerrormsg_if (stderr_ref, env, errno)
val () = assertloc (errno = 0)
prval ((*void*)) = opt_unsome (model)

//
// Build, run, and free model.
// 
val () = mytest_main (env, model)
//
val errno = GRBfreemodel (model)
val () = assertloc (errno = 0)
//
val ((*freed*)) = GRBfreeenv (env)
//
} (* end of [mytest] *)


implement
mytest_main (env, model) =
{
//
val () = println! ("Hello from [mytest_main]!")
//


//
// Add variables
//
val obj = (arrayptr)$arrpsz{double}(1.0, 1.0, 2.0)
val objc = carrayptr(obj)
val vtype = (arrayptr)$arrpsz{GRB_VARTYPE}
  (GRB_BINARY, GRB_BINARY, GRB_BINARY)
val vtypec = carrayptr(vtype) 
//
val errno = GRBaddvars_nocon_noname(model, 3, 0, objc, vtypec)
val () = assertloc (errno = 0)


//
//Change objective sense to maximization 
//
val errno = GRBsetintattr(model, GRB_INT_ATTR_MODELSENSE, GRB_MAXIMIZE)
val () = assertloc (errno = 0)

//
// Integrate new variables */
//
val errno = GRBupdatemodel(model);
val () = assertloc (errno = 0)

//
// First constraint: x + 2 y + 3 z <= 4
//
val ind = (arrayptr)$arrpsz{int}(0, 1, 2)
val indc = carrayptr(ind)
val cval = (arrayptr)$arrpsz{double}(1.0, 2.0, 3.0)
val cvalc = carrayptr(cval)
val errno = GRBaddconstr(model, 3, indc, cvalc, GRB_LESS_EQUAL, 4.0, "c0")
val () = assertloc (errno = 0)

(* Need to reimplement: 

//
// Second constraint: x + y >= 1 
//
val ind2 = (arrayptr)$arrpsz{int}(0, 1)
val cval2 = (arrayptr)$arrpsz{int}(1, 2)
val error = $GRB.addconstr(model, 2, ind2, cval2, $GRB.G, 1.0, "c1");
val () = if error != 0 then QUIT(error)

//
// Optimize model
//
val error = $GRB.optimize(model)
val () = if error != 0 then QUIT(error)

//
// Write model to 'mip1.lp' 
//
val error = $GRB.write(model, "mip1.lp")
val () = if error != 0 then QUIT(error)

//
// Since we didn't use stack-allocated arrays, we need to free
// these manually.
// 
val () = arrayptr_free(ind)
val () = arrayptr_free(cval)
val () = arrayptr_free(ind2)
val () = arrayptr_free(cval2)
//
val () = QUIT(error)
//
// Don't forget to test with valgrind; compare to C version
//
*)
val () = arrayptr_free(obj)
val () = arrayptr_free(vtype)
val () = arrayptr_free(ind)
val () = arrayptr_free(cval)

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

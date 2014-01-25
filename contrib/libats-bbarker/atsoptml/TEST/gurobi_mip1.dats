

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
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload "libc/SATS/unistd.sats"

staload 
GRB = "contrib/libats-bbarker/atsoptml/SATS/gurobi.sats"
// GRB = "${LIBATSBBARKER}/atsoptml/SATS/gurobi.sats"
// TRY setting environmental variable for LIBATSBBARKER
// (didn't work)
(* ****** ****** *)

//NULLs ... not the greatest:
val NULL = stropt_none()
val NULD = $UN.ptr2cptr{double} ($UN.cast2Ptr0{stropt} (NULL)) 
val NULI = $UN.ptr2cptr{int} ($UN.cast2Ptr0{stropt} (NULL)) 
val NULC = $UN.ptr2cptr{char} ($UN.cast2Ptr0{stropt} (NULL)) 
//val NULCC = //  maybe need an array_make_nil fun
val NULCC = (arrayptr)$arrpsz{$GRB.varname}() 
implement
main0 () = 
{
// Set up varirables
var env: $GRB.env?
var model: $GRB.model? 
//
//  Safe exit function closure
//  (may make a default overloaded fun and move 
//   gurobi.sats).
//
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

//
// Create environment
//
val error = $GRB.loadenv(env, "gurobi_mip1.log") //&env in C
val () = if error != 0 then QUIT(error)

//
// Create an empty model
//
val error = $GRB.newmodel(env, model, "mip1", 0, 
NULD, NULD, NULD, "", NULCC) // just env in C, &model
val () = if error != 0 then QUIT(error)

//
// Add variables
//
val obj = (arrayptr)$arrpsz{double}(1.0, 1.0, 2.0)
val vtype = (arrayptr)$arrpsz{$GRB.vartyp}
  ($GRB.BT, $GRB.BT, $GRB.BT) 
// Is there a praxi somewhere that it is equivalent to a string? What about
// a null terminator?? may need to change to:
// val vtype =  $GRB.BT + $GRB.BT + $GRB.BT
val error = $GRB.addvars(model, 3, 0, (), (), (), $UN.ptr2cptr{double}(obj), (), (), vtype, ())
val () = if error != 0 then QUIT(error)

//
//Change objective sense to maximization 
//
val error = $GRB.setintattr(model, $GRB.MSENS, $GRB.MAX)
val () = if error != 0 then QUIT(error)

//
// Integrate new variables */
//
val error = $GRB.updatemodel(model);
val () = if error != 0 then QUIT(error)

//
// First constraint: x + 2 y + 3 z <= 4
//
val ind = (arrayptr)$arrpsz{int}(0, 1, 2)
val cval = (arrayptr)$arrpsz{int}(1, 2, 3)
val error = $GRB.addconstr(model, 3, ind, cval, $GRB.L, 4.0, "c0")
val () = if error != 0 then QUIT(error)

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
val () = arrayptr_free(obj)
val () = arrayptr_free(vtype)
//
val () = QUIT(error)
//
// Don't forget to test with valgrind; compare to C version
//
}
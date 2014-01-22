

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

(* ****** ****** *)


staload 
GRB = "atsoptml/SATS/gurobi.sats"

implement
main0 () = 
{
// Set up varirables
var env: GRBenv_vt0ype?
var model: GRBmodel_vt0ype? 
//
// Create environment
//
val error = $GRB.loadenv(env, "gurobi_mip1.log") //&env in C
val () =  assertloc(error == 0)
//
// Create an empty model
//
val error = $GRB.newmodel(env, model, "mip1", 0, (), (), (), (), ()) // just env in C, &model
val () = assertloc(error == 0)
//
// Add variables
//
val obj = (arrayptr)$arrpsz{int}(1, 1, 2)
val vtype = (arrayptr)$arrpsz{GRBvartype_vt0ype}
  (GRB_BINARY, GRB_BINARY, GRB_BINARY) 
val error = $GRB.addvars(model, 3, 0, (), (), (), obj, (), (), vtype, ())
val () = assertloc(error == 0)
//
//Change objective sense to maximization 
//
val error = $GRB.setintattr(model, GRB_INT_ATTR_MODELSENSE, GRB_MAXIMIZE)
val () = assertloc(error == 0)
//
// Integrate new variables */
//
val error = $GRB.updatemodel(model);
val () = assertloc(error == 0)
//
// First constraint: x + 2 y + 3 z <= 4
//
val ind = (arrayptr)$arrpsz{int}(0, 1, 2)
val cval = (arrayptr)$arrpsz{int}(1, 2, 3)
val error = $GRB.addconstr(model, 3, ind, cval, GRB_LESS_EQUAL, 4.0, "c0")
val () = assertloc(error == 0)
//
// Second constraint: x + y >= 1 
//
val ind2 = (arrayptr)$arrpsz{int}(0, 1)
val cval2 = (arrayptr)$arrpsz{int}(1, 2)
val error = $GRB.addconstr(model, 2, ind2, cval2, GRB_GREATER_EQUAL, 1.0, "c1");
val () = assertloc(error == 0)
//
// Optimize model
//
val error = $GRB.optimize(model)
val () = assertloc(error == 0)
//
// Write model to 'mip1.lp' 
//
val error = GRBwrite(model, "mip1.lp")
val () = assertloc(error == 0)

// !!! Need to change val error assertloc to possibly a safe analog of goto QUIT.

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
// Free model and then environment
//
val () = $GRB.freemodel(model)
val () = $GRB.freeenv(env)
//
// Don't forget to test with valgrind; compare to C version
//
}
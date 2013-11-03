//
// A simple implementation of Co-routines
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "../SATS/coroutine.sats"
staload _ = "../DATS/coroutine.dats"

(* ****** ****** *)
//
fun intfrom
  (x: int): cortn (unit, int) =
  lcfun2cortn{unit,int}(llam _ => (x, intfrom (x+1)))
//
(* ****** ****** *)
//
var co = intfrom (0)
val n0 = co_run<unit,int> (co, unit)
val () = println! ("n0 = ", n0)
val n1 = co_run<unit,int> (co, unit)
val () = println! ("n1 = ", n1)
//
var co2 = co_fmap<unit,int,int> (co, lam (x) => 2 * x)
val n2 = co_run<unit,int> (co2, unit)
val () = println! ("n2 = ", n2)
val n3 = co_run<unit,int> (co2, unit)
val () = println! ("n3 = ", n3)
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test1.dats] *)

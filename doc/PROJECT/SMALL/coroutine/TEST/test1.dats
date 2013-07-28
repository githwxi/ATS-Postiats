//
// A simple implementation of Co-routines
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "../coroutine.sats"
staload _ = "../coroutine.dats"

(* ****** ****** *)
//
fun intfrom
  (x: int): cortn (unit, int) =
  lcfun2cortn{unit,int}(llam _ => (x, intfrom (x+1)))
//
var co = intfrom (0)
val n0 = co_run<unit,int> (co, unit)
val () = println! ("n0 = ", n0)
val n1 = co_run<unit,int> (co, unit)
val () = println! ("n1 = ", n1)
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test1.dats] *)

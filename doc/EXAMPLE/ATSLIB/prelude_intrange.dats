(*
** for testing [prelude/intrange]
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
fun fact
  (n:int): int = let
//
typedef tenv = int
implement
intrange_foreach$fwork<tenv> (i, env) = env := (i+1) * env
//
var env: tenv = 1
val _ = intrange_foreach_env<int> (0, n, env)
//
in
  env
end (* end of [fact] *)
//
val () = assertloc (fact (10) = 1*2*3*4*5*6*7*8*9*10)
//
}

(* ****** ****** *)

val () =
{
//
fun fact
  (n:int): int = let
//
typedef tenv = int
implement
intrange_rforeach$fwork<tenv> (i, env) = env := (i+1) * env
//
var env: tenv = 1
val _ = intrange_rforeach_env<int> (0, n, env)
//
in
  env
end (* end of [fact] *)
//
val () = assertloc (fact (10) = 10*9*8*7*6*5*4*3*2*1)
//
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_intrange.dats] *)

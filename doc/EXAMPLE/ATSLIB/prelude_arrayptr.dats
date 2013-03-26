(*
** for testing [prelude/arrayptr]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A = (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
val i = 2
val () = assertloc (A[i] = i)
val () = A[i] := ~i
val () = assertloc (A[i] = ~i)
val () = arrayptr_interchange (A, (i2sz)0, (i2sz)4)
val () = assertloc (A[0] = 4 && A[4] = 0)
val A = A // HX: a puzzling existential unpacking :)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = double
//
val asz = i2sz(5)
val A = (arrayptr)$arrpsz{T}(0.0, 1.0, 2.0, 3.0, 4.0)
implement(env)
array_iforeach$fwork<T><env> (i, x, env) =
  let val () = if i > 0 then print ", " in print (x) end
val () = assertloc (asz = arrayptr_iforeach (A, asz))
val () = println! ()
//
typedef tenv = int
implement
array_rforeach$fwork<T><tenv> (x, i) = 
  let val () = if i > 0 then print ", " in i := i+1; print (x) end
var i: int = 0
val () = assertloc (asz = arrayptr_rforeach_env<T><tenv> (A, asz, i))
val () = println! ()
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_arrayptr.dats] *)

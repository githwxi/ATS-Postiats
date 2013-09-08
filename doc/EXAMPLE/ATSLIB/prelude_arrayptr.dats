(*
** for testing [prelude/arrayptr]
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
typedef T = int
//
val out = stdout_ref
//
val A_elt =
arrayptr_make_elt<T> (i2sz(3), 0)
val () = fprint (out, "A_elt = ")
val () = fprint (out, A_elt, i2sz(3))
val () = fprint_newline (out)
val () = arrayptr_free (A_elt)
//
val xs = list_nil{T}()
val xs = list_cons{T}(3, xs)
val xs = list_cons{T}(2, xs)
val xs = list_cons{T}(1, xs)
//
val A_list =
arrayptr_make_list<T> (3, xs)
val () = fprint (out, "A_list = ")
val () = fprint (out, A_list, i2sz(3))
val () = fprint_newline (out)
val () = arrayptr_free (A_list)
//
val A_rlist =
arrayptr_make_rlist<T> (3, xs)
val () = fprint (out, "A_rlist = ")
val () = fprint (out, A_rlist, i2sz(3))
val () = fprint_newline (out)
val () = arrayptr_free (A_rlist)
//
} (* end of [val] *)

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
//
val A = A // HX: a puzzling existential unpacking :)
//
val out = stdout_ref
val () = fprint! (out, "A = ")
val () = fprint_arrayptr_sep (out, A, i2sz(5), "; ")
val () = fprintln! (out)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val l = 0 and r = 10
val A = arrayptr_make_intrange (l, r)
val () = fprint (out, "A[0, 10) = ")
val () = fprint_arrayptr<int> (out, A, i2sz(r))
val () = fprint_newline (out)
//
val () = arrayptr_free (A)
//
} (* end of [val] *)

(* ****** ****** *)

val () =
{
//
typedef T = double
//
val asz = i2sz(5)
val A = (arrayptr)$arrpsz{T}(0.0, 1.0, 2.0, 3.0, 4.0)
//
implement(tenv)
array_iforeach$fwork<T><tenv> (i, x, env) =
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

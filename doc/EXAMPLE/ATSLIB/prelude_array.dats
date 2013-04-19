(*
** for testing [prelude/array]
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
val (pf | p) = arrayptr_takeout_viewptr (A)
val i = 2
val () = assertloc (p->[i] = i)
val () = p->[i] := ~i
val () = assertloc (p->[i] = ~i)
val () = array_interchange (!p, (i2sz)0, (i2sz)4)
val () = assertloc (p->[0] = 4 && p->[4] = 0)
//
prval () = arrayptr_addback (pf | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
typedef T = int
//
val A =
  (arrayptr)$arrpsz{T}(0, 1, 2, 3, 4)
//
val (pfat | p) = arrayptr_takeout_viewptr (A)
//
val out = stdout_ref
//
local
implement(te)
array_foreach$fwork<T><te>
  (x, env) = fprint (out, x)
in (* in of [local] *)
val _(*asz*) = array_foreach (!p, (i2sz)5)
val () = fprint_newline (out)
end (* end of [local] *)
//
local
//
implement(te)
array_iforeach$fwork<T><te>
  (i, x, env) = let
  val () =
    if i > 0 then fprint (out, "; ")
  // end of [val]
in
  fprint! out i ": " x
end (* end of [array_iforeach$fwork] *)
//
in (* in of [local] *)
val _(*asz*) = array_iforeach (!p, (i2sz)5)
val () = fprint_newline (out)
end (* end of [local] *)
//
local
//
implement(te)
array_foreach2$fwork<T,T><te>
  (x1, x2, env) = fprint! out "(" x1 ", " x2 ")"
//
in (* in of [local] *)
val _(*asz*) = array_foreach2 (!p, !p, (i2sz)5)
val () = fprint_newline (out)
end (* end of [local] *)
//
local
implement(te)
array_rforeach$fwork<T><te>
  (x, env) = fprint (out, x)
in (* in of [local] *)
val _(*asz*) = array_rforeach (!p, (i2sz)5)
val () = fprint_newline (out)
end (* end of [local] *)
//
prval () = arrayptr_addback (pfat | A)
//
val () = arrayptr_free (A)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_array.dats] *)

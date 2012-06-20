(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

staload
F = "contrib/atshwxi/testing/foreach.sats"

(* ****** ****** *)

staload "contrib/atshwxi/testing/tprint.sats"

(* ****** ****** *)

implement{a}
tprint (x) = let
  val out = tprint__out () in fprint_elt<a> (out, x)
end // end of [tprint]

implement{} tprint__out () = stdout_ref

(* ****** ****** *)

implement{}
tprint_list__sep () = ","
implement{}
tprint_list__beg () = "("
implement{}
tprint_list__end () = ")"

implement{a}
tprint_list (xs) = let
//
val sep = tprint_list__sep ()
//
implement
$F.iforeach_list__fwork<a>
  (i, x) = let
  val () = if i > 0 then tprint (sep) in tprint<a> (x)
end // end of [__fwork]
//
val _beg = tprint_list__beg ()
and _end = tprint_list__end ()
//
in
  tprint(_beg); $F.iforeach_list (xs); tprint(_end)
end // end of [tprint_list]

implement(a) tprint<List(a)> (xs) = tprint_list<a> (xs)

(* ****** ****** *)

implement{}
tprint_array__sep () = ","
implement{}
tprint_array__beg () = "["
implement{}
tprint_array__end () = "]"

implement{a}
tprint_array (A, n) = let
//
val sep = tprint_array__sep ()
//
implement
$F.iforeach_array__fwork<a>
  (i, x) = let
  val i = g1ofg0_uint (i)
  val () = if i > 0 then tprint (sep) in tprint<a> (x)
end // end of [__fwork]
//
val _beg = tprint_list__beg ()
and _end = tprint_list__end ()
//
in
  tprint(_beg); $F.iforeach_array (A, n); tprint(_end)
end // end of [tprint_array]

implement{a}
tprint_arrayptr
  (A, n) = () where {
  val p = ptrcast (A)
  prval pf = arrayptr_takeout (A)
  val () = tprint_array<a> (!p, n)
  prval () = arrayptr_addback (pf | A)
} // end of [tprint_arrayptr]

(* ****** ****** *)

(* end of [tprint.dats] *)

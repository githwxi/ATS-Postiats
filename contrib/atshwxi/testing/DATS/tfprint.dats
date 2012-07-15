(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

staload F =
"contrib/atshwxi/testing/SATS/foreach.sats"
// end of [staload]

(* ****** ****** *)

staload
"contrib/atshwxi/testing/SATS/tfprint.sats"
// end of [staload]

(* ****** ****** *)

implement{a}
tfprint (x) = let
  val out = tfprint__out () in fprint_val<a> (out, x)
end // end of [tfprint]

implement{} tfprint__out () = stdout_ref

(* ****** ****** *)

implement{}
tfprint_list__sep () = ","
implement{}
tfprint_list__beg () = "("
implement{}
tfprint_list__end () = ")"

implement{a}
tfprint_list (xs) = let
//
val sep = tfprint_list__sep ()
//
implement
$F.iforeach_list__fwork<a>
  (i, x) = let
  val () = if i > 0 then tfprint (sep) in tfprint<a> (x)
end // end of [__fwork]
//
val _beg = tfprint_list__beg ()
and _end = tfprint_list__end ()
//
in
  tfprint(_beg); $F.iforeach_list (xs); tfprint(_end)
end // end of [tfprint_list]

implement(a) tfprint<List(a)> (xs) = tfprint_list<a> (xs)

(* ****** ****** *)

implement{}
tfprint_array__sep () = ","
implement{}
tfprint_array__beg () = "["
implement{}
tfprint_array__end () = "]"

implement{a}
tfprint_array (A, n) = let
//
val sep = tfprint_array__sep ()
//
implement
$F.iforeach_array__fwork<a>
  (i, x) = let
  val i = g1ofg0_uint (i)
  val () = if i > 0 then tfprint (sep) in tfprint<a> (x)
end // end of [__fwork]
//
val _beg = tfprint_list__beg ()
and _end = tfprint_list__end ()
//
in
  tfprint(_beg); $F.iforeach_array (A, n); tfprint(_end)
end // end of [tfprint_array]

implement{a}
tfprint_arrayptr
  (A, n) = () where {
  val p = ptrcast (A)
  prval pf = arrayptr_takeout (A)
  val () = tfprint_array<a> (!p, n)
  prval () = arrayptr_addback (pf | A)
} // end of [tfprint_arrayptr]

(* ****** ****** *)

(* end of [tfprint.dats] *)

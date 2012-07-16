(*
** Some print functions to faciliate testing
*)

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
val out = tfprint__out ()
val sep = tfprint_list__sep ()
val _beg = tfprint_list__beg ()
and _end = tfprint_list__end ()
//
val () = fprint_string (out, _beg)
val () = fprint_list_sep (out, xs, sep)
val () = fprint_string (out, _end)
//
in
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
val out = tfprint__out ()
val sep = tfprint_array__sep ()
val _beg = tfprint_list__beg ()
and _end = tfprint_list__end ()
//
val () = fprint_string (out, _beg)
val () = fprint_array_sep (out, A, n, sep)
val () = fprint_string (out, _end)
//
in
  // nothing
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

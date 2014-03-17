(* ****** ****** *)
//
// HX-2014-03-17
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

implement
main0 () =
{
//
local
implement
array_tabulate$fopr<int> (i) = sz2i(i)
in(*in-of-local*)
val (pf, pfgc | p) = array_ptr_tabulate<int> (i2sz(10))
end // end of [local]
//
prval (pf1, pf2) = array_v_split{int}{..}{10}{1} (pf) 
//
val () = fprint_array_sep (stdout_ref, !p, i2sz(1), ",")
val () = fprint_newline (stdout_ref)
//
val p2 = ptr_add<int> (p, 1)
val (pf2 | p2) = viewptr_match (pf2 | p2)
val () = fprint_array_sep (stdout_ref, !p2, i2sz(9), ",")
val () = fprint_newline (stdout_ref)
//
val () = array_ptr_free (array_v_unsplit (pf1, pf2), pfgc | p)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-223.dats] *)

(*
** Some tostring functions to faciliate testing
*)

(* ****** ****** *)

staload
"contrib/atshwxi/testing/SATS/tostring.sats"
// end of [staload]

(* ****** ****** *)

implement{a}
tostring_with_fprint_val (x) = let
  val str = tostrptr_with_fprint_val<a> (x)
in
//
if strptr2ptr (str) > 0 then
  stropt_some (string_of_strptr (str))
else let
  val () = strptr_free_null (str) in stropt_none ()
end // end of [if]
//
end // end of [tostring_with_fprint_val]

implement{a}
tostring_with_fprint_ref (x) = tostring_with_fprint_val<a> (x)

(* ****** ****** *)

(* end of [tostring.dats] *)

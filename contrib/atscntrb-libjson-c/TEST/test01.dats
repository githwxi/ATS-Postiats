(*
** Some testing code for [json]
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT edu
** Time: May, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/linkhash.sats"

(* ****** ****** *)

implement
main0 () =
{
//
fun
free_fn
(
  x: lh_entry0
) : void = let
//
val
ptr = $UN.castvwtp0{ptr}(x)
//
in
  println! ("[free_fn] is called")
end // end of [free_fn]
//
val HT = lh_kchar_table_new (10, "mytable_kchar", free_fn)
val () = assertloc (ptrcast(HT) > 0)
//
val () = assertloc (lh_table_insert (HT, string2ptr"girl1", string2ptr"Zoe") = 0)
val () = assertloc (lh_table_insert (HT, string2ptr"girl2", string2ptr"Chloe") = 0)
//
local
var x0: ptr
val found = lh_table_lookup_ex(HT, string2ptr"girl1", x0)
in
val () =
  assertloc (found > 0)
val () = println! ("HT[girl1] = ", $UN.cast{string}(x0))
end // end of [local]
//
local
val
(
fpf | ent
) =
lh_table_lookup_entry
  (HT, string2ptr"girl2")
in
//
val () =
  assertloc (ptrcast(ent) > 0)
//
val k0 = lh_entry_get_key(ent) and x0 = lh_entry_get_val(ent)
//
val () = println! ("HT[", $UN.cast{string}(k0), "] = ", $UN.cast{string}(x0))
//
prval ((*returned*)) = fpf (ent)
//
end // end of [local]
//
local
val
(
fpf | ent
) =
lh_table_lookup_entry
  (HT, string2ptr"girl3")
in
val () = assertloc (ptrcast(ent) = 0)
prval ((*returned*)) = fpf(ent)
end // end of [local]
//
val () = assertloc (lh_table_delete (HT, string2ptr"girl1") = 0)
val () = assertloc (lh_table_delete (HT, string2ptr"girl2") = 0)
val () = assertloc (lh_table_delete (HT, string2ptr"girl3") < 0)
//
val () = lh_table_free (HT)
//
} // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)

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
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "json-c/SATS/json.sats"

(* ****** ****** *)

implement
main0 () =
{
//
fun free_fn
  (x: lh_entry0): void =
  let val ptr = $UN.castvwtp0{ptr}(x) in println! ("[free_fn] is called") end
//
val HT = lh_kchar_table_new (10, "mytable_kchar", free_fn)
val () = assertloc (ptrcast(HT) > 0)
//
val () = assertloc (lh_table_insert (HT, string2ptr"girl1", string2ptr"Zoe") = 0)
val () = assertloc (lh_table_insert (HT, string2ptr"girl2", string2ptr"Chloe") = 0)
//
val item = lh_table_lookup (HT, string2ptr"girl1")
val () = assertloc (item > 0)
val () = println! ("HT[girl1] = ", $UN.cast{string}(item))
//
val item = lh_table_lookup (HT, string2ptr"girl2")
val () = assertloc (item > 0)
val () = println! ("HT[girl2] = ", $UN.cast{string}(item))
//
val item = lh_table_lookup (HT, string2ptr"girl3")
val () = assertloc (item = 0)
val () = println! ("HT[girl3] = ", item)
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

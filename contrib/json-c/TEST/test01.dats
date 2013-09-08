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

%{^
#include "json-c/CATS/json.cats"
%}

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
val itm = lh_table_lookup (HT, string2ptr"girl1")
val () = assertloc (itm > 0)
val () = println! ("HT[girl1] = ", $UN.cast{string}(itm))
//
val (fpf | ent) = lh_table_lookup_entry (HT, string2ptr"girl2")
val () = assertloc (ptrcast(ent) > 0)
val key = lh_entry_get_key (ent) and itm = lh_entry_get_val (ent)
val () = println! ("HT[", $UN.cast{string}(key), "] = ", $UN.cast{string}(itm))
prval () = fpf (ent)
//
val (fpf | ent) = lh_table_lookup_entry (HT, string2ptr"girl3")
val () = println! ("HT[girl3] = ", ptrcast(ent))
prval () = fpf (ent)
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

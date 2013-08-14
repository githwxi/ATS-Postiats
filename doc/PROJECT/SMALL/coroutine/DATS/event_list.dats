//
// a list-based implementation of events
//

(* ****** ****** *)

staload "../SATS/event.sats"

(* ****** ****** *)

assume
evset_vtype (a:vt0p) = List0_vt (a)

(* ****** ****** *)

implement{a}
evset_size (xs) = list_vt_length (xs)

(* ****** ****** *)

implement{a}
evset_takeout_atbeg
  (xs0) = let
in
//
case+ xs0 of
| list_vt_cons _ => let
    val x =
      list_vt_uncons (xs0)
    // end of [val]
  in
    Some_vt{a}(x)
  end // end of [list_vt_cons]
| list_vt_nil () => None_vt{a}((*void*))
//
end // end of [evset_takeout_atbeg]

(* ****** ****** *)

implement{a}
evset_takeout_atend
  (xs0) = let
in
//
case+ xs0 of
| list_vt_cons _ => let
    val x =
      list_vt_unsnoc (xs0)
    // end of [val]
  in
    Some_vt{a}(x)
  end // end of [list_vt_cons]
| list_vt_nil () => None_vt{a}()
//
end // end of [evset_takeout_atend]

(* ****** ****** *)

(* end of [event_list.dats] *)


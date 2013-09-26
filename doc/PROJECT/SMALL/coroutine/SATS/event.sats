//
// A linear type for events
//
(* ****** ****** *)

absvtype
evset_vtype (a:vt@ype+) = ptr
vtypedef
evset (a:vt0p) = evset_vtype (a)

(* ****** ****** *)

fun{a:vt0p}
evset_size (xs: !evset(a)): intGte(0)

(* ****** ****** *)

fun{a:vt0p}
evset_takeout_atbeg (xs: &evset(a) >> _): Option_vt(a)
fun{a:vt0p}
evset_takeout_atend (xs: &evset(a) >> _): Option_vt(a)

(* ****** ****** *)

(* end of [event.sats] *)

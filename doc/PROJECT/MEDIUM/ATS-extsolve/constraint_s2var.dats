(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./constraint.sats"

(* ****** ****** *)

typedef
s2var_struct = @{
  s2var_name= symbol
, s2var_stamp= stamp
} (* end of [s2var_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume s2var_type = ref (s2var_struct)
//
in (* in of [local] *)

implement
s2var_make
  (name, stamp) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<s2var_struct> ()
//
val () = p->s2var_name := name
val () = p->s2var_stamp := stamp
//
in
  $UN.castvwtp0{s2var}((pfat, pfgc | p))
end // end of [s2var_make]

implement
s2var_get_name
  (s2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2v)
in
  p->s2var_name
end // end of [let]
) (* end of [s2var_get_name] *)

implement
s2var_get_stamp
  (s2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2v)
in
  p->s2var_stamp
end // end of [let]
) (* end of [s2var_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_s2var
  (out, s2v) =
  fprint! (out, s2v.name, "(", s2v.stamp, ")")
// end of [fprint_s2var]

(* ****** ****** *)

implement
compare_s2var_s2var
  (s2v1, s2v2) = compare (s2v1.stamp, s2v2.stamp)
// end of [compare_s2var_s2var]

(* ****** ****** *)

(* end of [constraint_s2var.dats] *)

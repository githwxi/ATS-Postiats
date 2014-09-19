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
s2cst_struct = @{
  s2cst_name= symbol
, s2cst_stamp= stamp
} (* end of [s2cst_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume s2cst_type = ref (s2cst_struct)
//
in (* in of [local] *)

implement
s2cst_make
  (name, stamp) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<s2cst_struct> ()
//
val () = p->s2cst_name := name
val () = p->s2cst_stamp := stamp
//
in
  $UN.castvwtp0{s2cst}((pfat, pfgc | p))
end // end of [s2cst_make]

implement
s2cst_get_name
  (s2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2c)
in
  p->s2cst_name
end // end of [let]
) (* end of [s2cst_get_name] *)

implement
s2cst_get_stamp
  (s2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (s2c)
in
  p->s2cst_stamp
end // end of [let]
) (* end of [s2cst_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_s2cst
  (out, s2c) =
  fprint! (out, s2c.name, "(", s2c.stamp, ")")
// end of [fprint_s2cst]

(* ****** ****** *)

implement
compare_s2cst_s2cst
  (s2c1, s2c2) = compare (s2c1.stamp, s2c2.stamp)
// end of [compare_s2cst_s2cst]

(* ****** ****** *)

(* end of [constraint_s2cst.dats] *)

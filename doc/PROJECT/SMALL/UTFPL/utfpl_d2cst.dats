(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)
//
implement
eq_d2cst_d2cst
  (d2c1, d2c2) = compare (d2c1, d2c2) = 0
implement
neq_d2cst_d2cst
  (d2c1, d2c2) = compare (d2c1, d2c2) != 0
//
(* ****** ****** *)

typedef
d2cst_struct =
@{
  d2cst_name= symbol
, d2cst_stamp= stamp
} (* end of [d2cst_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume d2cst_type = ref (d2cst_struct)
//
in (* in of [local] *)

implement
d2cst_make
  (name, stamp) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<d2cst_struct> ()
//
val () = p->d2cst_name := name
val () = p->d2cst_stamp := stamp
//
in
  $UN.castvwtp0{d2cst}((pfat, pfgc | p))
end // end of [d2cst_make]

implement
d2cst_get_name
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->d2cst_name
end // end of [let]
) (* end of [d2cst_get_name] *)

implement
d2cst_get_stamp
  (d2c) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2c)
in
  p->d2cst_stamp
end // end of [let]
) (* end of [d2cst_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_d2cst
  (out, d2c) =
  fprint! (out, d2c.name, "(", d2c.stamp, ")")
// end of [fprint_d2cst]

(* ****** ****** *)

implement
compare_d2cst_d2cst
  (d2c1, d2c2) = compare (d2c1.stamp, d2c2.stamp)
// end of [compare_d2cst_d2cst]

(* ****** ****** *)

(* end of [utfpl_d2cst.dats] *)

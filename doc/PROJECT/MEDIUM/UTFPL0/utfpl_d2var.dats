(*
** Implementing UTFPL
** with closure-based evaluation
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
eq_d2var_d2var
  (d2v1, d2v2) = compare (d2v1, d2v2) = 0
implement
neq_d2var_d2var
  (d2v1, d2v2) = compare (d2v1, d2v2) != 0
//
(* ****** ****** *)

typedef
d2var_struct =
@{
  d2var_name= symbol
, d2var_bind= Ptr0 (*d2exp*)
, d2var_stamp= stamp
} (* end of [d2var_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume d2var_type = ref (d2var_struct)
//
in (* in of [local] *)

implement
d2var_make
  (name, stamp) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<d2var_struct> ()
//
val () = p->d2var_name := name
val () = p->d2var_bind := the_null_ptr
val () = p->d2var_stamp := stamp
//
in
  $UN.castvwtp0{d2var}((pfat, pfgc | p))
end // end of [d2var_make]

(* ****** ****** *)

implement
d2var_get_name
  (d2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2v)
in
  p->d2var_name
end // end of [let]
) (* end of [d2var_get_name] *)

(* ****** ****** *)

implement
d2var_get_stamp
  (d2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2v)
in
  p->d2var_stamp
end // end of [let]
) (* end of [d2var_get_stamp] *)

(* ****** ****** *)

implement
d2var_get_bind
  (d2v) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2v)
in
  p->d2var_bind
end // end of [let]
) (* end of [d2var_get_bind] *)

implement
d2var_set_bind
  (d2v, d2e) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2v)
in
  p->d2var_bind := $UN.cast{Ptr1}(d2e)
end // end of [let]
) (* end of [d2var_set_bind] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_d2var
  (out, d2v) =
  fprint! (out, d2v.name, "(", d2v.stamp, ")")
// end of [fprint_d2var]

(* ****** ****** *)

implement
compare_d2var_d2var
  (d2v1, d2v2) = compare (d2v1.stamp, d2v2.stamp)
// end of [compare_d2var_d2var]

(* ****** ****** *)

(* end of [utfpl_d2var.dats] *)

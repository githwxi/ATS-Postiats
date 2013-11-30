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

typedef
d2sym_struct =
@{
  d2sym_name= symbol
, d2sym_name2= symbol
} (* end of [d2sym_struct] *)

(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
assume d2sym_type = ref (d2sym_struct)
//
in (* in of [local] *)

implement
d2sym_make (name) = let
//
val (
  pfat, pfgc | p
) = ptr_alloc<d2sym_struct> ()
//
val () = p->d2sym_name := name
//
in
  $UN.castvwtp0{d2sym}((pfat, pfgc | p))
end // end of [d2sym_make]

implement
d2sym_get_name
  (d2s) = $effmask_ref
(
let
  val (vbox _ | p) = ref_get_viewptr (d2s)
in
  p->d2sym_name
end // end of [let]
) (* end of [d2sym_get_name] *)

end // end of [local]

(* ****** ****** *)

implement
fprint_d2sym
  (out, d2s) = fprint! (out, d2s.name, "(", ")")
// end of [fprint_d2sym]

(* ****** ****** *)

(* end of [utfpl_d2sym.dats] *)

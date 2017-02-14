(*
** For writing ATS code
** that translates into Javascript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_reference_"
//
(* ****** ****** *)
//
#staload UN =
  "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_js.sats"
#staload "./../SATS/JSarray.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/reference.sats"
//
(* ****** ****** *)
//
(*
assume
ref_vt0ype_type(a:t@ype) = JSarray(a)
*)
//
(* ****** ****** *)
//
implement
ref (x) = ref_make_elt (x)
//
implement
ref_make_elt{a}(x) = $UN.cast{ref(a)}(JSarray_sing(x))
//
(* ****** ****** *)

implement
ref_get_elt{a}(r) = let
  val r = $UN.cast{JSarray(a)}(r) in JSarray_get_at(r, 0)
end // end of [ref_get_elt]

(* ****** ****** *)

implement
ref_set_elt{a}(r, x0) = let
  val r = $UN.cast{JSarray(a)}(r) in JSarray_set_at(r, 0, x0)
end // end of [ref_set_elt]

(* ****** ****** *)

implement
ref_exch_elt{a}(r, x0) = let
  val r =
    $UN.cast{JSarray(a?)}(r)
  // end of [val]
  val x1 = JSarray_get_at(r, 0)
in
  JSarray_set_at(r, 0, $UN.castvwtp0{a?}(x0)); $UN.castvwtp0{a}(x1)
end // end of [ref_exch_elt]

(* ****** ****** *)

(* end of [reference.dats] *)

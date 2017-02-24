(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_reference_"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
#staload "./../SATS/PHPref.sats"
#staload "./../SATS/reference.sats"
//
(* ****** ****** *)
//
implement
ref{a}(x) = ref_make_elt{a}(x)
//
implement
ref_make_elt{a}(x) = $UN.cast{ref(a)}(PHPref_new(x))
//
(* ****** ****** *)

implement
ref_get_elt{a}(r) = let
  val r = $UN.cast{PHPref(a)}(r) in PHPref_get_elt(r)
end // end of [ref_get_elt]

(* ****** ****** *)

implement
ref_set_elt{a}(r, x) = let
  val r = $UN.cast{PHPref(a)}(r) in PHPref_set_elt(r, x)
end // end of [ref_set_elt]

(* ****** ****** *)

(* end of [reference.dats] *)

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
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_arrayref_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
//
#staload "./../SATS/integer.sats"
//
#staload "./../SATS/PHParref.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/intrange.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/arrayref.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/arrayref.dats"
//
(* ****** ****** *)
//
(*
assume
arrayref_vt0ype_type(a, n) = PHParref(a)
*)
//
(* ****** ****** *)
//
implement
arrayref_make_elt
  {a}{n}(n, x) =
(
$UN.cast{arrayref(a,n)}(PHParref_make_elt(n, x))
)
//
(* ****** ****** *)

implement
arrayref_get_at
  {a}(A, i) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_get_at(A, i)
//
end // end of [arrayref_get_at]

(* ****** ****** *)

implement
arrayref_set_at
  {a}(A, i, x) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_set_at(A, i, x)
//
end // end of [arrayref_set_at]

(* ****** ****** *)
//
// Array-with-size
//
(* ****** ****** *)
//
implement
arrszref_make_arrayref
  {a}(A, n) = $UN.cast{arrszref(a)}(A)
//
(* ****** ****** *)
//
implement
arrszref_size{a}(A) =
(
  PHParref_length($UN.cast{PHParref(a)}(A))
) (* end of [arrszref_size] *)
//
(* ****** ****** *)
//
implement
arrszref_get_at{a}(A, i) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_get_at(A, i)
//
end // end of [arrszref_get_at]
//
implement
arrszref_set_at{a}(A, i, x) = let
//
val A =
$UN.cast{PHParref(a)}(A) in PHParref_set_at(A, i, x)
//
end // end of [arrszref_set_at]
//
(* ****** ****** *)

(* end of [arrayref.dats] *)

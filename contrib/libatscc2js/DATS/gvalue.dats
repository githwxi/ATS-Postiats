(*
** For writing ATS code
** that translates into Javascript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2015-12
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_gvalue_"
//
(* ****** ****** *)
//
#staload "./../SATS/gvalue.sats"
//
(* ****** ****** *)

implement
gvalue_nil() = GVnil()

(* ****** ****** *)

implement
gvalue_int(x) = GVint(x)

(* ****** ****** *)

implement
gvalue_bool(x) = GVbool(x)

(* ****** ****** *)

implement
gvalue_float(x) = GVfloat(x)
implement
gvalue_string(x) = GVstring(x)

(* ****** ****** *)

(* end of [gvalue.dats] *)

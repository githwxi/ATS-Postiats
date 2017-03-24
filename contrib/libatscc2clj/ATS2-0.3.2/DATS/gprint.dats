(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
#define
ATS_STATIC_PREFIX "_ats2cljpre_gprint_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)

staload "./../SATS/gprint.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/gprint.dats"
//
(* ****** ****** *)
//
extern
fun
tostring
{a:t@ype}(x: a): string = "mac#%"
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
gprint_val(x) = gprint_string(tostring(x))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_int(x) = gprint_string(tostring(x))
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_bool(x) =
  gprint_string(if x then "true" else "false")
//
(* ****** ****** *)

implement
{}(*tmp*)
gprint_char(x) = gprint_string(tostring(x))

(* ****** ****** *)

implement
{}(*tmp*)
gprint_double(x) = gprint_string(tostring(x))

(* ****** ****** *)

(* end of [gprint.dats] *)

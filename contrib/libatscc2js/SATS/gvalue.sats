(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_js.sats"
//
#include "{$LIBATSCC}/SATS/gvalue.sats"
//
(* ****** ****** *)
//
datatype gvalue =
//
  | GVnil of ()
//
  | GVint of (int)
//
  | GVbool of (bool)
//
  | GVfloat of (double)
//
  | GVstring of (string)
//
  | GVobject of (JSobj)
//
  | GVlist of gvlist
  | GVarray of gvarray
  | GVhashtbl of gvhashtbl
//
(* ****** ****** *)
//
fun gvalue_nil(): gvalue = "mac#%"
//
fun gvalue_int(int): gvalue = "mac#%"
//
fun gvalue_bool(bool): gvalue = "mac#%"
//
fun gvalue_float(double): gvalue = "mac#%"
//
fun gvalue_string(string): gvalue = "mac#%"
//
(* ****** ****** *)
//
fun
gvhashtbl_get_atkey
  (tbl: gvhashtbl, k: string): gvalue = "mac#%"
fun
gvhashtbl_set_atkey
  (tbl: gvhashtbl, k: string, x: gvalue): void = "mac#%"
fun
gvhashtbl_exch_atkey
  (tbl: gvhashtbl, k: string, x: gvalue): gvalue = "mac#%"
//
(* ****** ****** *)
//
overload [] with gvhashtbl_get_atkey
overload [] with gvhashtbl_set_atkey
//
(* ****** ****** *)

(* end of [gvalue.sats] *)

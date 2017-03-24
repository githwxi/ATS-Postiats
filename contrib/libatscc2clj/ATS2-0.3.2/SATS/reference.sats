(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX-2016-06:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
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
#include "{$LIBATSCC}/SATS/reference.sats"
//
(* ****** ****** *)
//
// HX:
// linear references
//
(* ****** ****** *)
//
absvtype
ref_vt0ype_vtype(a:vt@ype) = ptr
vtypedef ref_vt(a:vt0p) = ref_vt0ype_vtype(a)
//
(* ****** ****** *)
//
fun ref_vt{a:vt0p}(x: a): ref_vt(a) = "mac#%"
//
fun
ref_vt_make_elt{a:vt0p} (x: a): ref_vt(a) = "mac#%"
//
(* ****** ****** *)
//
fun
ref_vt_get_elt{a:t0p} (r: !ref_vt a): a = "mac#%"
fun
ref_vt_set_elt{a:t0p} (r: !ref_vt a, x0: a): void = "mac#%"
//
fun
ref_vt_exch_elt{a:vt0p} (r: !ref_vt a, x0: a): (a) = "mac#%"
//
(* ****** ****** *)

overload [] with ref_vt_get_elt
overload [] with ref_vt_set_elt

(* ****** ****** *)
//
fun
ref_vt_getfree_elt{a:t0p} (r: ref_vt(a)): a = "mac#%"
//
(* ****** ****** *)
//
absview ref_vt_takeout_v(a:vt@ype)
//
fun
ref_vt_takeout
  {a:vt0p}(!ref_vt(a)): (ref_vt_takeout_v(a) | a) = "mac#%"
fun
ref_vt_addback
  {a:vt0p}(ref_vt_takeout_v(a) | !ref_vt(a), x0: a): void= "mac#%"
//
(* ****** ****** *)

(* end of [reference.sats] *)

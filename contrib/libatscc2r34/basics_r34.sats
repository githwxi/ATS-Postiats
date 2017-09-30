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
ATS_PACKNAME
"ATSCC2R34.basics"
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/basics.sats"
//
(* ****** ****** *)
(*
typedef char = int
*)
(* ****** ****** *)
//
abstype R34obj // generic
//
abstype R34filr // nominal!
//
(* ****** ****** *)
//
fun
lazy2cloref
  {a:t@ype}
  (lazy(a)): ((*void*)) -<cloref1> (a) = "mac#%"
//
(* ****** ****** *)
//
fun
assert_errmsg_bool0
  (claim: bool, msg: string): void = "mac#%"
fun
assert_errmsg_bool1
  {b:bool}
  (claim: bool(b), msg: string): [b] void = "mac#%"
//
overload
assert_errmsg with assert_errmsg_bool0 of 100
overload
assert_errmsg with assert_errmsg_bool1 of 110
//
macdef
assertloc(claim) = assert_errmsg(,(claim), $mylocation)
//
(* ****** ****** *)
//
(*
typedef strchr = string(1)
*)
//
(* ****** ****** *)
//
fun
fun2cloref0
{res:t@ype}
  (fopr: () -> res): cfun(res) = "mac#%"
fun
fun2cloref1
{a:t@ype}{res:t@ype}
  (fopr: (a) -> res): cfun(a, res) = "mac#%"
fun
fun2cloref2
{a1,a2:t@ype}{res:t@ype}
  (fopr: (a1, a2) -> res): cfun(a1, a2, res) = "mac#%"
fun
fun2cloref3
{a1,a2,a3:t@ype}{res:t@ype}
  (fopr: (a1, a2, a3) -> res): cfun(a1, a2, a3, res) = "mac#%"
//
(* ****** ****** *)

(* end of [basics_r34.sats] *)

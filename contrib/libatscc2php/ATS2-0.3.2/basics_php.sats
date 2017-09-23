(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_PACKNAME "ATSCC2PHP"
#define
ATS_EXTERN_PREFIX "ats2phppre_"
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
#include "{$LIBATSCC}/basics.sats"
//
(* ****** ****** *)

abstype PHPobj

(* ****** ****** *)

abstype PHPfilr

(* ****** ****** *)

absvtype PHPfilp(l:addr)
vtypedef PHPfilp0 = [l:addr] PHPfilp(l)
vtypedef PHPfilp1 = [l:addr | l > null] PHPfilp(l)

(* ****** ****** *)
//
fun
PHPfilp_is_null
  {l:addr}(!PHPfilp(l)): bool(l==null) = "mac#%"
fun
PHPfilp_isnot_null
  {l:addr}(!PHPfilp(l)): bool(l > null) = "mac#%"
//
overload iseqz with PHPfilp_is_null
overload isneqz with PHPfilp_isnot_null
//
(* ****** ****** *)
//
abstype PHPref(a:vt@ype) // reference
//
abstype PHParray(a:vt@ype) // risk on your own!!!
abstype PHParref(a:vt@ype) // reference to PHParray
//
(* ****** ****** *)
//
fun{
a:t0p
} echo_tmp(obj: a): void
//
fun
echo_obj{a:t0p}(obj: a): void = "mac#%"
//
(* ****** ****** *)
//
symintr echo
//
fun{
} echo0(): void
fun{
a1:t0p
} echo1 (INV(a1)): void
fun{
a1,a2:t0p
} echo2 (INV(a1), INV(a2)): void
fun{
a1,a2,a3:t0p
} echo3 (INV(a1), INV(a2), INV(a3)): void
fun{
a1,a2,a3,a4:t0p
} echo4 (INV(a1), INV(a2), INV(a3), INV(a4)): void
fun{
a1,a2,a3,a4,a5:t0p
} echo5 (INV(a1), INV(a2), INV(a3), INV(a4), INV(a5)): void
fun{
a1,a2,a3,a4,a5,a6:t0p
} echo6 (INV(a1), INV(a2), INV(a3), INV(a4), INV(a5), INV(a6)): void
fun{
a1,a2,a3,a4,a5,a6,a7:t0p
} echo7 (INV(a1), INV(a2), INV(a3), INV(a4), INV(a5), INV(a6), INV(a7)): void
fun{
a1,a2,a3,a4,a5,a6,a7,a8:t0p
} echo8 (INV(a1), INV(a2), INV(a3), INV(a4), INV(a5), INV(a6), INV(a7), INV(a8)): void
//
overload echo with echo0
overload echo with echo1
overload echo with echo2
overload echo with echo3
overload echo with echo4
overload echo with echo5
overload echo with echo6
overload echo with echo7
overload echo with echo8
//
(* ****** ****** *)
//
typedef strchr = string(1)
//
(* ****** ****** *)
//
fun
intval(rep: string): int = "mac#%"
fun
floatval(rep: string): double = "mac#%"
//
(* ****** ****** *)
//
fun
lazy2cloref
  {a:t0p}
(
  lazy(a)
) : ((*void*)) -<cloref1> (a) = "mac#%"
//
(* ****** ****** *)
//
fun
assert_errmsg_bool0
  (x: bool, msg: string): void = "mac#%"
//
fun
assert_errmsg_bool1
  {b:bool}
  (x: bool b, msg: string): [b] void = "mac#%"
//
overload
assert_errmsg with assert_errmsg_bool0 of 100
overload
assert_errmsg with assert_errmsg_bool1 of 110
//
(* ****** ****** *)
//
macdef
assertloc(x) = assert_errmsg (,(x), $mylocation)
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

(* end of [basics_php.sats] *)

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
abstype optarg // nominal
//
(* ****** ****** *)
//
abstype R34obj // generic
//
abstype R34filr // nominal!
//
(* ****** ****** *)
//
abstype
R34list(a:t@ype, n:int)
abstype
R34vector(a:t@ype, n:int)
abstype
R34dframe(a:t@ype, m:int, n:int)
abstype
R34matrix(a:t@ype, m:int, n:int)
//
(* ****** ****** *)
//
typedef
R34list
(
a:t@ype
) = [n:nat] R34list(a:t@ype, n)
//
typedef
R34vector
(
  a:t@ype
) = [n:nat] R34vector(a:t@ype, n)
//
typedef
R34dframe
(a:t@ype) =
[m,n:nat] R34dframe(a:t@ype, m, n)
//
typedef
R34matrix
(a:t@ype) =
[m,n:nat] R34matrix(a:t@ype, m, n)
//
(* ****** ****** *)
//
castfn
R34vector_int2double
{n:int}
(R34vector(int, n)):<> R34vector(double, n)
castfn
R34matrix_int2double
{m,n:int}
(R34matrix(int, m, n)):<> R34matrix(double, m, n)
//
overload int2double with R34vector_int2double
overload int2double with R34matrix_int2double
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
//
fun
cloref2fun0
{res:t@ype}
(fopr: cfun(res)): (() -> res) = "mac#%"
fun
cloref2fun1
{a:t@ype}{res:t@ype}
(fopr: cfun(a, res)): ((a) -> res) = "mac#%"
fun
cloref2fun2
{a1,a2:t@ype}{res:t@ype}
(fopr: cfun(a1, a2, res)): ((a1, a2) -> res) = "mac#%"
fun
cloref2fun3
{a1,a2,a3:t@ype}{res:t@ype}
(fopr: cfun(a1, a2, a3, res)): ((a1, a2, a3) -> res) = "mac#%"
//
(* ****** ****** *)

(* end of [basics_r34.sats] *)

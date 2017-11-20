(* ****** ****** *)
(*
** For writing ATS code
** that translates into Scheme
*)
(* ****** ****** *)
//
// HX-2015-06:
// prefix for external names
//
#define
ATS_PACKNAME 
"ATSCC2SCM.basics"
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
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
//
abstype SCMval_type
typedef SCMval = SCMval_type
//
(* ****** ****** *)
//
fun
lazy2cloref
  {a:t0p}
(
  lazyval: lazy(a)
) : ((*void*)) -<cloref1> (a) = "mac#%"
//
(* ****** ****** *)
//
fun
cloref0_app{b:t0p}(cfun0(b)): b = "mac#%"
//
fun
cloref1_app
  {a:t0p}{b:t0p}(cfun1(a, b), a): b = "mac#%"
//
fun
cloref2_app
  {a1,a2:t0p}{b:t0p}
  (cfun2(a1, a2, b), a1, a2): b = "mac#%"
fun
cloref3_app
  {a1,a2,a3:t0p}{b:t0p}
  (cfun3(a1, a2, a3, b), a1, a2, a3): b = "mac#%"
//
overload cloref_app with cloref0_app
overload cloref_app with cloref1_app
overload cloref_app with cloref2_app
overload cloref_app with cloref3_app
//
(* ****** ****** *)
//
abstype SCMfilr(*fileref*)
//
(* ****** ****** *)
//
// HX-2016-06:
// invariant constructors!
//
abstype SCMlist(a:vt@ype) // mutable datastructure!
abstype SCMvector(a:vt@ype) // mutable datastructure!
//
(* ****** ****** *)
//
fun assert_errmsg_bool0
  (x: bool, msg: string): void = "mac#%"
fun assert_errmsg_bool1
  {b:bool} (x: bool b, msg: string): [b] void = "mac#%"
//
overload assert_errmsg with assert_errmsg_bool0 of 100
overload assert_errmsg with assert_errmsg_bool1 of 110
//
(* ****** ****** *)
//
macdef assertloc (x) = assert_errmsg (,(x), $mylocation)
//
(* ****** ****** *)

(* end of [basics_scm.sats] *)

(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_PACKNAME "ATSCC2PL"
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/basics.sats"
//
(* ****** ****** *)

abstype PLfilr

(* ****** ****** *)

abstype PLarray(a:vt@ype)

(* ****** ****** *)
//
fun
lazy2cloref
  {a:t0p}(lazy(a)): ((*void*)) -<cloref1> (a) = "mac#%"
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

(* end of [basics_pl.sats] *)

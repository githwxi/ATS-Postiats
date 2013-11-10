//
// A simple example of C-union
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: November, 2013
//
(* ****** ****** *)
//
%{^
typedef
union { int i; double f; } intfloat ;
//
#define intfloat_get_int(x) (((intfloat*)x)->i)
#define intfloat_get_float(x) (((intfloat*)x)->f)
#define intfloat_set_int(x, v) (((intfloat*)x)->i = v)
#define intfloat_set_float(x, v) (((intfloat*)x)->f = v)
//
%}
abst@ype
intfloat(tag:int) = $extype"intfloat"
//
typedef intfloat = [tag:int] intfloat (tag)
//
(* ****** ****** *)
//
extern
fun intfloat_get_int (x: &intfloat(0)): int = "mac#"
extern
fun intfloat_get_float (x: &intfloat(1)): double = "mac#"
//
(* ****** ****** *)
//
extern
fun intfloat_set_int
  (x: &intfloat? >> intfloat(0), i: int): void = "mac#"
extern
fun intfloat_set_float
  (x: &intfloat? >> intfloat(1), f: double): void = "mac#"
//
(* ****** ****** *)

implement
main0 () =
{
var x: intfloat?
//
val () = intfloat_set_int (x, 9)
val () = println! ("x.int = ", intfloat_get_int(x))
//
val () = intfloat_set_float (x, 9.9)
val () = println! ("x.float = ", intfloat_get_float(x))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [union.dats] *)

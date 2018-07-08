(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)

#staload "./../../basics_js.sats"

(* ****** ****** *)

fun
eval(code: string): JSobj = "mac#%"

(* ****** ****** *)

fun
Number{a:t0p}(obj: a): double = "mac#%"
fun
String{a:t0p}(obj: a): string = "mac#%"

(* ****** ****** *)
//
fun
isFinite_int (int): bool = "mac#%"
fun
isFinite_double (double): bool = "mac#%"
//
symintr isFinite
overload isFinite with isFinite_int
overload isFinite with isFinite_double
//
(* ****** ****** *)
//
fun isNaN_int (int): bool = "mac#%"
fun isNaN_double (double): bool = "mac#%"
//
symintr isNaN
overload isNaN with isNaN_int
overload isNaN with isNaN_double
//
(* ****** ****** *)
//
fun
parseInt_1
  (rep: string): int = "mac#%"
fun
parseInt_2
  (rep: string, base: int): int = "mac#%"
//
symintr parseInt
overload parseInt with parseInt_1
overload parseInt with parseInt_2
//
(* ****** ****** *)
//
fun
parseFloat(rep: string): double = "mac#%"
//
(* ****** ****** *)

fun encodeURI(uri: string): string = "mac#%"
fun decodeURI(uri: string): string = "mac#%"

(* ****** ****** *)

fun encodeURIComponent(uri: string): string = "mac#%"
fun decodeURIComponent(uri: string): string = "mac#%"

(* ****** ****** *)

(* end of [JSmisc.sats] *)

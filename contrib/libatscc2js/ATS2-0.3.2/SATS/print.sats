(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
(*
HX:
prefix for external names
*)
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)

#staload "./../basics_js.sats"

(* ****** ****** *)
//
(*
typedef
fprint_type
(
  a:t@ype
) = (JSfilr, a) -<fun1> void
*)
//
(* ****** ****** *)

fun print_int : int -> void = "mac#%"
fun print_uint : uint -> void = "mac#%"

(* ****** ****** *)

fun print_bool : bool -> void = "mac#%"

(* ****** ****** *)

fun print_double : double -> void = "mac#%"

(* ****** ****** *)
//
fun
print_string : string -> void = "mac#%"
fun
fprint_string (JSfilr, string): void = "mac#%"
//
(* ****** ****** *)

fun print_obj{a:t0p}(obj: a): void = "mac#%"

(* ****** ****** *)

fun print_newline : ((*void*)) -> void = "mac#%"

(* ****** ****** *)

overload print with print_int of 100
overload print with print_uint of 100
overload print with print_bool of 100
overload print with print_double of 100
overload print with print_string of 100

(* ****** ****** *)
//
fun
{a:t0p}
print_val (x: a): void = "mac#%"
//
fun
{a:t0p}
fprint_val (JSfilr, x: a): void = "mac#%"
//  
(* ****** ****** *)
//
// HX-2014-09-19:
// these are implemented in
// CATS/PRINT/print_store_cats.js
//
fun the_print_store_join (): string = "mac#%"
fun the_print_store_clear : () -> void = "mac#%"
//
(* ****** ****** *)

(* end of [print.sats] *)

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
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)

#staload "./../basics_r34.sats"

(* ****** ****** *)
//
(*
typedef
fprint_type
(
  a:t@ype
) = (R34filr, a) -<fun1> void
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
fprint_string (R34filr, string): void = "mac#%"
//
(* ****** ****** *)

fun
print_obj{a:t0p}(obj: a): void = "mac#%"

(* ****** ****** *)

fun
print_newline : ((*void*)) -> void = "mac#%"

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
fprint_val (R34filr, x: a): void = "mac#%"
//  
(* ****** ****** *)

(* end of [print.sats] *)

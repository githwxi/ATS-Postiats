(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)

#staload "./../basics_php.sats"

(* ****** ****** *)
//
fun print_int : (int) -> void = "mac#%"
fun prerr_int : (int) -> void = "mac#%"
//
fun
fprint_int: (PHPfilr, int) -> void = "mac#%"
//
overload print with print_int of 100
overload prerr with prerr_int of 100
overload fprint with fprint_int of 100
//
(* ****** ****** *)
//
fun print_bool : (bool) -> void = "mac#%"
fun prerr_bool : (bool) -> void = "mac#%"
//
fun
fprint_bool: (PHPfilr, bool) -> void = "mac#%"
//
overload print with print_bool of 100
overload prerr with prerr_bool of 100
overload fprint with fprint_bool of 100
//
(* ****** ****** *)
//
fun print_double : (double) -> void = "mac#%"
fun prerr_double : (double) -> void = "mac#%"
//
fun
fprint_double : (PHPfilr, double) -> void = "mac#%"
//
overload print with print_double of 100
overload prerr with prerr_double of 100
overload fprint with fprint_double of 100
//
(* ****** ****** *)
//
fun
print_string (str: string): void = "mac#%"
fun
prerr_string (str: string): void = "mac#%"
//
fun
fprint_string: (PHPfilr, string) -> void = "mac#%"
//
(* ****** ****** *)
//
overload print with print_string of 100
overload prerr with prerr_string of 100
overload fprint with fprint_string of 100
//
(* ****** ****** *)
//
fun
print_obj{a:t0p}(obj: a): void = "mac#%"
fun
print_r_obj{a:t0p}(obj: a): void = "mac#%"
//
(* ****** ****** *)

fun{a:t0p}
print_val (x: a): void = "mac#%"
fun{a:t0p}
fprint_val (PHPfilr, x: a): void = "mac#%"
  
(* ****** ****** *)

fun print_newline ((*void*)): void = "mac#%"
fun prerr_newline ((*void*)): void = "mac#%"
fun fprint_newline (out: PHPfilr): void = "mac#%"

(* ****** ****** *)

(* end of [print.sats] *)

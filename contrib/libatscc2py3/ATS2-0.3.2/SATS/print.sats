(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
//
(* ****** ****** *)

#staload "./../basics_py.sats"

(* ****** ****** *)
//
fun print_int : (int) -> void = "mac#%"
fun prerr_int : (int) -> void = "mac#%"
//
fun
fprint_int : (PYfilr, int) -> void = "mac#%"
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
fprint_bool : (PYfilr, bool) -> void = "mac#%"
//
overload print with print_bool of 100
overload prerr with prerr_bool of 100
overload fprint with fprint_bool of 100
//
(* ****** ****** *)
//
fun print_char : (char) -> void = "mac#%"
fun prerr_char : (char) -> void = "mac#%"
//
fun
fprint_char : (PYfilr, char) -> void = "mac#%"
//
overload print with print_char of 100
overload prerr with prerr_char of 100
overload fprint with fprint_char of 100
//
(* ****** ****** *)
//
fun print_double : (double) -> void = "mac#%"
fun prerr_double : (double) -> void = "mac#%"
//
fun
fprint_double : (PYfilr, double) -> void = "mac#%"
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
fprint_string : (PYfilr, string) -> void = "mac#%"
//
overload print with print_string of 100
overload prerr with prerr_string of 100
overload fprint with fprint_string of 100
//
(* ****** ****** *)
//
fun
print_obj{a:t@ype}(obj: a): void = "mac#%"
fun
println_obj{a:t@ype}(obj: a): void = "mac#%"
//
(* ****** ****** *)

fun{a:t0p}
print_val (x: a): void = "mac#%"
fun{a:t0p}
fprint_val (out: PYfilr, x: a): void = "mac#%"

(* ****** ****** *)

fun print_newline ((*void*)): void = "mac#%"
fun prerr_newline ((*void*)): void = "mac#%"
fun fprint_newline (out: PYfilr): void = "mac#%"

(* ****** ****** *)

(* end of [print.sats] *)

(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX: prefix for external names
//
#define ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)

staload "./../basics_pl.sats"

(* ****** ****** *)
//
fun
print_int : (int) -> void = "mac#%"
fun
prerr_int : (int) -> void = "mac#%"
fun
fprint_int : (PLfilr, int) -> void = "mac#%"
//
overload print with print_int of 100
overload prerr with prerr_int of 100
overload fprint with fprint_int of 100
//
(* ****** ****** *)
//
fun
print_bool : (bool) -> void = "mac#%"
fun
prerr_bool : (bool) -> void = "mac#%"
//
fun
fprint_bool : (PLfilr, bool) -> void = "mac#%"
//
overload print with print_bool of 100
overload prerr with prerr_bool of 100
overload fprint with fprint_bool of 100
//
(* ****** ****** *)
//
fun
print_double : (double) -> void = "mac#%"
fun
prerr_double : (double) -> void = "mac#%"
fun
fprint_double : (PLfilr, double) -> void = "mac#%"
//
overload print with print_double of 100
overload prerr with prerr_double of 100
overload fprint with fprint_double of 100
//
(* ****** ****** *)
//
fun
print_string : (string) -> void = "mac#%"
fun
prerr_string : (string) -> void = "mac#%"
fun
fprint_string (PLfilr, string): void = "mac#%"
//
overload print with print_string of 100
overload prerr with prerr_string of 100
overload fprint with fprint_string of 100
//
(* ****** ****** *)

fun
print_obj{a:t0p}(obj: a): void = "mac#%"

(* ****** ****** *)

fun{a:t0p}
print_val (x: a): void = "mac#%"
fun{a:t0p}
fprint_val (out: PLfilr, x: a): void = "mac#%"
  
(* ****** ****** *)

fun print_newline ((*void*)): void = "mac#%"
fun prerr_newline ((*void*)): void = "mac#%"
fun fprint_newline (out: PLfilr): void = "mac#%"

(* ****** ****** *)

(* end of [print.sats] *)

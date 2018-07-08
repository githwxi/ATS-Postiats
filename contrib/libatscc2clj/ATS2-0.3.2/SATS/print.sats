(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
//
(* ****** ****** *)

staload "./../basics_clj.sats"

(* ****** ****** *)
//
fun print_int : int -> void = "mac#%"
fun print_bool : bool -> void = "mac#%"
fun print_char : char -> void = "mac#%"
fun print_double : double -> void = "mac#%"
fun print_string : string -> void = "mac#%"
//
fun print_CLJval : (CLJval) -> void = "mac#%"
//
(* ****** ****** *)

(*
fun print_obj{a:t0p}(obj: a): void = "mac#%"
*)

(* ****** ****** *)

overload print with print_int of 100
overload print with print_bool of 100
overload print with print_double of 100
overload print with print_string of 100

(* ****** ****** *)

overload print with print_CLJval of 100

(* ****** ****** *)
//  
fun
{a:t0p}
print_val (x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
print_newline : ((*void*)) -> void = "mac#%"
//
(* ****** ****** *)
//
fun fprint_int : (CLJfilr, int) -> void = "mac#%"
fun fprint_bool : (CLJfilr, bool) -> void = "mac#%"
fun fprint_char : (CLJfilr, char) -> void = "mac#%"
fun fprint_double : (CLJfilr, double) -> void = "mac#%"
fun fprint_string : (CLJfilr, string) -> void = "mac#%"
//
fun fprint_CLJval : (CLJfilr, CLJval) -> void = "mac#%"
//
(* ****** ****** *)
//
overload fprint with fprint_int of 100
overload fprint with fprint_bool of 100
overload fprint with fprint_double of 100
overload fprint with fprint_string of 100
//
(* ****** ****** *)
//
fun
fprint_newline(out: CLJfilr): void = "mac#%"
//
(* ****** ****** *)
//  
fun
{a:t0p}
fprint_val(out: CLJfilr, x0: a): void = "mac#%"
//
(* ****** ****** *)

(* end of [print.sats] *)

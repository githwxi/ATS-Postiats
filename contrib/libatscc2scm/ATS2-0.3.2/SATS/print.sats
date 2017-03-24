(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
//
(* ****** ****** *)

staload "./../basics_scm.sats"

(* ****** ****** *)
//
fun print_int : int -> void = "mac#%"
fun print_bool : bool -> void = "mac#%"
fun print_char : char -> void = "mac#%"
fun print_double : double -> void = "mac#%"
fun print_string : string -> void = "mac#%"
//
fun print_SCMval : (SCMval) -> void = "mac#%"
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

overload print with print_SCMval of 100

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
fun fprint_int : (SCMfilr, int) -> void = "mac#%"
fun fprint_bool : (SCMfilr, bool) -> void = "mac#%"
fun fprint_char : (SCMfilr, char) -> void = "mac#%"
fun fprint_double : (SCMfilr, double) -> void = "mac#%"
fun fprint_string : (SCMfilr, string) -> void = "mac#%"
//
fun fprint_SCMval : (SCMfilr, SCMval) -> void = "mac#%"
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
{a:t0p}
fprint_val (SCMfilr, x: a): void = "mac#%"
//
(* ****** ****** *)
//
fun
fprint_newline(out: SCMfilr): void = "mac#%"
//
(* ****** ****** *)

(* end of [print.sats] *)

(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

(*
** Node.js/fprint
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2nodejs_"
//
(* ****** ****** *)

abstype NJSstream // readable/writable

(* ****** ****** *)
//
typedef
fprint_type
(
  a:t@ype
) = (NJSstream(*out*), a) -<fun1> void
//
(* ****** ****** *)
//
(*
fun print_int : (int) -> void = "mac#%"
fun prerr_int : (int) -> void = "mac#%"
*)
//
fun
fprint_int: (NJSstream, int) -> void = "mac#%"
//
overload fprint with fprint_int of 100
//
(* ****** ****** *)
//
(*
fun print_bool : (bool) -> void = "mac#%"
fun prerr_bool : (bool) -> void = "mac#%"
*)
//
fun fprint_bool: (NJSstream, bool) -> void = "mac#%"
//
overload fprint with fprint_bool of 100
//
(* ****** ****** *)
//
(*
fun print_string (str: string): void = "mac#%"
fun prerr_string (str: string): void = "mac#%"
*)
fun fprint_string (NJSstream, string): void = "mac#%"
//
overload fprint with fprint_string of 100
//
(* ****** ****** *)
//
(*
fun print_obj{a:t0p}(obj: a): void = "mac#%"
fun prerr_obj{a:t0p}(obj: a): void = "mac#%"
*)
fun fprint_obj{a:t0p}(NJSstream, a): void = "mac#%"
//
(*
fun println_obj{a:t0p}(obj: a): void = "mac#%"
fun prerrln_obj{a:t0p}(obj: a): void = "mac#%"
*)
fun fprintln_obj{a:t0p}(NJSstream, a): void = "mac#%"
//
(* ****** ****** *)
//
(*
fun print_newline ((*void*)): void = "mac#%"
fun prerr_newline ((*void*)): void = "mac#%"
*)
fun fprint_newline (NJSstream): void = "mac#%"
//
(* ****** ****** *)

(* end of [fprint.sats] *)

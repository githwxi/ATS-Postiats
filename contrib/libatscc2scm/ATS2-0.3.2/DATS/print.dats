(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
#define
ATS_STATIC_PREFIX "_ats2scmpre_print_"
//
(* ****** ****** *)
//
staload "./../basics_scm.sats"
//
staload "./../SATS/print.sats"
//
(* ****** ****** *)
//
implement
print_val<int> = print_int
implement
print_val<bool> = print_bool
implement
print_val<double> = print_double
implement
print_val<string> = print_string
//
(* ****** ****** *)
//
implement
fprint_val<int> = fprint_int
implement
fprint_val<bool> = fprint_bool
implement
fprint_val<double> = fprint_double
implement
fprint_val<string> = fprint_string
//
(* ****** ****** *)

(* end of [print.dats] *)

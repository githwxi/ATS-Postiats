(*
** For writing ATS code
** that translates into Python
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-11:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_"
#define
ATS_STATIC_PREFIX "_ats2pypre_print_"
//
(* ****** ****** *)
//
#staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/print.sats"
#staload "./../SATS/filebas.sats"
//
(* ****** ****** *)

implement
print_val<int> (x) = fprint_val<int> (stdout, x)

(* ****** ****** *)

implement fprint_val<int> = fprint_int
implement fprint_val<bool> = fprint_bool
implement fprint_val<double> = fprint_double
implement fprint_val<string> = fprint_string

(* ****** ****** *)

(* end of [print.dats] *)

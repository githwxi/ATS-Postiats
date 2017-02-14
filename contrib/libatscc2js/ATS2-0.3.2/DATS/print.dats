(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_print_"
//
(* ****** ****** *)
//
#include
"./../staloadall.hats"
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

implement
(a)(*tmp*)
print_val<list0(a)> = print_list0<a>

(* ****** ****** *)

(* end of [print.dats] *)

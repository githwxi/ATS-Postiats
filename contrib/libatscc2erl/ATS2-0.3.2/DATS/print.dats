(*
** For writing ATS code
** that translates into Erlang
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2erlpre_"
#define
ATS_STATIC_PREFIX "_ats2erlpre_print_"
//
(* ****** ****** *)
//
staload "./../basics_erl.sats"
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

(* end of [print.dats] *)

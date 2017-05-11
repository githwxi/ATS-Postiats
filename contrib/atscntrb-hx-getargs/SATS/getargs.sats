(* ****** ****** *)
(*
** For parsing
** command-line arguments and more
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

#staload
"libats/ML/SATS/basis.sats"

(* ****** ****** *)
//
datatype
optargs =
OPTARGS of
( string(*opt*)
, list0(string)(*args*))
//
(* ****** ****** *)
//
datatype
outchan =
| OUTCHANptr of (FILEref) // need for closing
| OUTCHANref of (FILEref) // no need for closing
//
(* ****** ****** *)
//
fun{}
getargs_get_arg0(): string
//
(* ****** ****** *)

fun{}
outchan_close(outchan): void
fun{}
outchan_fileref(outchan): FILEref

(* ****** ****** *)
//
fun{}
getargs_usage(): void
//
(* ****** ****** *)
//
fun{}
getargs_is_flag(string): bool
//
fun//{}
getargs_get_ndash(string): intGte(0)
//
(* ****** ****** *)
//
fun{}
getargs_is_help(string): bool
//
(* ****** ****** *)
//
fun{}
the_state_get(): gvhashtbl
//
(* ****** ****** *)
//
fun{}
the_outchan_getref(): ref(outchan)
//
(* ****** ****** *)
//
fun{}
the_state_get_key(k0: string): gvalue
fun{}
the_state_set_key(k0: string, gv: gvalue): void
//
(* ****** ****** *)
//
fun{}
optargs_eval(fxs: optargs): void
fun{}
optargs_eval2(fxs: optargs): void
//
(* ****** ****** *)

(* end of [getargs.sats] *)

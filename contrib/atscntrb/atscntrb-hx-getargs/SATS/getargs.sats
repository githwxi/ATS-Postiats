(* ****** ****** *)
(*
** Simple templates
** for parsing command-line
** arguments and more
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
| OPTARGS0 of
  ( string(*arg*) )
| OPTARGS1 of
  ( string(*opt*)
  , list0(string)(*args*))
//
(* ****** ****** *)
//
// HX:
// The default is interpreted
// as argumentless: OPTARTYeq(0)
//
datatype
optarty =
| OPTARTY0 of ()
| OPTARTY1 of ()
| OPTARTYeq of (int)
| OPTARTYgte of (int)
//
(* ****** ****** *)
//
fun{}
print_optargs: print_type(optargs)
fun{}
prerr_optargs: print_type(optargs)
fun{}
fprint_optargs: fprint_type(optargs)
//
overload print with print_optargs
overload prerr with prerr_optargs
overload fprint with fprint_optargs
//
(* ****** ****** *)
//
fun{}
print_optarty: print_type(optarty)
fun{}
prerr_optarty: print_type(optarty)
fun{}
fprint_optarty: fprint_type(optarty)
//
overload print with print_optarty
overload prerr with prerr_optarty
overload fprint with fprint_optarty
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
getargs_arg0(): string
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
getargs_is_opt(string): bool
fun{}
getargs_is_arg(string): bool
//
fun//{}
getargs_get_ndash(string): intGte(0)
//
(* ****** ****** *)
//
fun{}
getargs_is_help(string): bool
//
fun{}
getargs_do_help(optargs): void
//
(* ****** ****** *)
//
fun{}
getargs_is_input(string): bool
//
fun{}
getargs_do_input(optargs): void
fun{}
getargs_do_input$none(): void
fun{}
getargs_do_input$some(inp: FILEref): void
//
(* ****** ****** *)
//
fun{}
getargs_is_output(string): bool
fun{}
getargs_is_output_a(string): bool
fun{}
getargs_is_output_w(string): bool
//
fun{}
getargs_do_output(fxs: optargs): void
//
(* ****** ****** *)
//
fun{}
the_optarty_initset(): void
//
(* ****** ****** *)
//
fun
the_optarty_get
  ((*void*)): gvhashtbl
//
fun{}
the_optarty_get_key
  (k0: string): optarty
fun{}
the_optarty_set_key
  (k0: string, art: optarty): void
//
(* ****** ****** *)

#define
OUTCHAN "outchan"
#define
OUTPUT_MODE "output_mode"

(* ****** ****** *)
//
fun{}
the_outchan_get
  ((*void*)): outchan
fun{}
the_outchan_getref
  ((*void*)): ref(outchan)
//
(* ****** ****** *)
//
fun{}
the_state_get(): gvhashtbl
fun//{}
the_state_optref_get(): gvhashtbl
//
(* ****** ****** *)
//
fun{}
the_state_get_key
  (k0: string): gvalue
fun{}
the_state_set_key
  (k0: string, gv: gvalue): void
//
(* ****** ****** *)
//
fun{}
the_state_get_output_mode(): file_mode
//
(* ****** ****** *)
//
fun{}
optargs_eval_arg(fxs: optargs): void
//
fun{}
optargs_eval_opt(fxs: optargs): void
fun{}
optargs_eval2_opt(fxs: optargs): void
//
(* ****** ****** *)
//
fun{}
optargs_eval_one(fxs: optargs): void
//
(* ****** ****** *)
//
fun{}
optargs_eval_all
  (fxss: list0(optargs)): void
//
fun{}
optargs_eval_all$after((*void*)): void
//
(* ****** ****** *)
//
fun{}
optargs_parse_one
(
  opt: string, xs: &list0(string) >> _
) : list0(string)
//
(* ****** ****** *)
//
fun{}
optargs_parse_all
  (arglst: list0(string)): list0(optargs)
//
(* ****** ****** *)

(* end of [getargs.sats] *)

(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

abstype cloenv_type = ptr
typedef cloenv = cloenv_type

(* ****** ****** *)

fun
fprint_cloenv (FILEref, cloenv): void
overload fprint with fprint_cloenv of 10

(* ****** ****** *)

datatype value =
//
  | VALint of int
  | VALbool of bool
  | VALchar of char
  | VALfloat of double
  | VALstring of string
//
  | VALvoid of ((*void*))
//
  | VALcst of d2cst
  | VALvar of d2var
  | VALsym of d2sym
//
  | VALlam of (d2exp, cloenv)
  | VALfix of (d2exp, cloenv)
//
  | VALfun of (valuelst -> value) // meta-function
//
  | VALerror of (string)
// end of [value]

where valuelst = List (value)

(* ****** ****** *)
//
fun print_value (value): void
overload print with print_value
//
fun
fprint_value (FILEref, value): void
overload fprint with fprint_value
//
(* ****** ****** *)
//
fun fprint2_value (FILEref, value): void
//
(* ****** ****** *)
//
fun cloenv_nil (): cloenv
//
fun cloenv_extend (cloenv, d2var, value): cloenv
//
fun cloenv_extend_arg (cloenv, p2at, value): cloenv
fun cloenv_extend_arglst (cloenv, p2atlst, valuelst): cloenv
//
fun cloenv_find
  (env: cloenv, d2v: d2var): Option_vt (value)
//
(* ****** ****** *)

fun the_d2cstmap_add (d2cst, value): void
fun the_d2cstmap_find (d2cst): Option_vt (value)

(* ****** ****** *)

fun the_d2symmap_add (d2sym, value): void
fun the_d2symmap_find (d2sym): Option_vt (value)

(* ****** ****** *)

fun eval_d2cst (cloenv, d2cst): value
fun eval_d2var (cloenv, d2var): value

(* ****** ****** *)

fun eval_d2sym (cloenv, d2sym): value

(* ****** ****** *)

fun eval_d2exp (cloenv, d2exp): value

(* ****** ****** *)

fun eval_d2ecl (env: cloenv, d2ecl): cloenv
fun eval_d2eclist (env: cloenv, d2eclist): cloenv

(* ****** ****** *)

fun eval0_d2eclist (d2eclist): cloenv

(* ****** ****** *)

(* end of [eval.sats] *)

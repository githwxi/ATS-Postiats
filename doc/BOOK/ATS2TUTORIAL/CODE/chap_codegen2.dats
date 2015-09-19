(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
datatype expr =
  | Int of int
  | Var of string
  | Add of (expr, expr)
  | Sub of (expr, expr)
  | Mul of (expr, expr)
  | Div of (expr, expr)
  | Ifgtz of (expr, expr, expr) // if expr > 0 then ... else ...
  | Ifgtez of (expr, expr, expr) // if expr >= 0 then ... else ...
//
(* ****** ****** *)
//
extern
fun{}
fprint_expr(FILEref, expr): void
//
(* ****** ****** *)

#codegen2("fprint", expr, fprint_expr)

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_codegen2.dats] *)

(*
** Some basic tests for the ATS Z3 Library
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "contrib/SMT/Z3/SATS/z3.sats"
(*
staload _ = "contrib/SMT/Z3/DATS/z3.dats"
*)
(* ****** ****** *)

val () =
{
//
val cfg = Z3_mk_config ()
val ctx = Z3_mk_context_rc (cfg)
val () = Z3_del_config (cfg)
//
val qf_lia = Z3_mk_tactic (ctx, "qf_lia")
val solver = Z3_mk_solver_from_tactic (ctx, qf_lia)
val () = Z3_tactic_dec_ref (ctx, qf_lia)
//
val sint = Z3_mk_int_sort(ctx)
val _1 = Z3_mk_int (ctx, 1, sint)
val _2 = Z3_mk_int (ctx, 2, sint)
val x = Z3_mk_fresh_const (ctx, "x", sint)
val y = Z3_mk_fresh_const (ctx, "y", sint)
//
val _ = Z3_sort_dec_ref (ctx, sint)
//
val _2x = Z3_mk_mul2 (ctx, _2, x)
val _2y = Z3_mk_mul2 (ctx, _2, y)
//
val _2x_2y = Z3_mk_add2 (ctx, _2x, _2y)
//
val _2x_2y_eq_1 = Z3_mk_eq (ctx, _2x_2y, _1)
//
val () = Z3_solver_assert (ctx, solver, _2x_2y_eq_1)
//
val _ = Z3_dec_ref (ctx, _1)
val _ = Z3_dec_ref (ctx, _2)
val _ = Z3_dec_ref (ctx, x)
val _ = Z3_dec_ref (ctx, y)
val _ = Z3_dec_ref (ctx, _2x)
val _ = Z3_dec_ref (ctx, _2y)
//
val _ = Z3_dec_ref (ctx, _2x_2y)
val _ = Z3_dec_ref (ctx, _2x_2y_eq_1)
//
val () = Z3_solver_dec_ref (ctx, solver)
//
val () = Z3_del_context (ctx)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test01.dats] *)

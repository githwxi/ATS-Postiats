(*
##
## ATS-extsolve-z3:
## Solving ATS-constraints with Z3
##
*)

(* ****** ****** *)
//
#ifdef
PATSOLVE_Z3_SOLVING
#then
#else
#include "./myheader.hats"
#endif // ifdef(PATSOLVE_Z3_SOLVING)
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
#staload "./patsolve_z3_solving_ctx.dats"
//
(* ****** ****** *)

assume sort_vtype = Z3_sort

(* ****** ****** *)

implement
sort_decref
  (ty) = () where
{
  val (fpf | ctx) =
    the_Z3_context_vget()
  // end of [val]
  val () = Z3_sort_dec_ref(ctx, ty)
  prval ((*void*)) = fpf(ctx)
}

(* ****** ****** *)

implement
sort_incref
  (ty) = ty2 where
{
//
val (fpf | ctx) =
  the_Z3_context_vget()
// end of [val]
val ty2 =
  Z3_sort_inc_ref(ctx, ty)
//
prval ((*void*)) = fpf(ctx)
//
} (* end of [sort_incref] *)

(* ****** ****** *)
//
implement 
sort_int () = res where
{
//
(*
val () =
  println! ("sort_int")
*)
//
val (fpf | ctx) = 
  the_Z3_context_vget()
// end of [val]
val res =
  Z3_mk_int_sort (ctx)
//
prval ((*void*)) = fpf (ctx)
//
} (* end of [sort_int] *)
//
(* ****** ****** *)
//
implement 
sort_bool () = res where
{
//
(*
val () =
  println! ("sort_bool")
*)
//
val (fpf | ctx) = 
  the_Z3_context_vget()
// end of [val]
val res =
  Z3_mk_bool_sort (ctx)
prval ((*void*)) = fpf (ctx)
//
} (* end of [sort_bool] *)
//
(* ****** ****** *)
//
implement 
sort_real () = res where
{
//
(*
val () =
  println! ("sort_real")
*)
//
val (fpf | ctx) = 
  the_Z3_context_vget()
// end of [val]
val res =
  Z3_mk_real_sort (ctx)
//
prval ((*void*)) = fpf (ctx)
//
} (* end of [sort_real] *)
//
(* ****** ****** *)

implement
sort_mk_cls () = sort_mk_abstract("cls")
implement
sort_mk_eff () = sort_mk_abstract("eff")

(* ****** ****** *)
//
implement
sort_mk_type () = sort_mk_abstract("type")
implement
sort_mk_vtype () = sort_mk_abstract("type")
//
implement
sort_mk_t0ype () = sort_mk_abstract("type")
implement
sort_mk_vt0ype () = sort_mk_abstract("type")
//
implement
sort_mk_prop () = sort_bool()
implement
sort_mk_view () = sort_bool()
//
implement
sort_mk_tkind () = sort_mk_abstract("tkind")
//
(* ****** ****** *)
//
(*
implement
sort_mk_abstract(name) = sort_int()
*)
//
implement
sort_mk_abstract
  (name) = res where
{
//
val (fpf | ctx) = 
  the_Z3_context_vget()
// end of [val]
val sym =
  Z3_mk_string_symbol (ctx, name)
val res =
  Z3_mk_uninterpreted_sort (ctx, sym)
prval ((*void*)) = fpf (ctx)
//
} (* end of [sort_mk_abstract] *)
//
(* ****** ****** *)

implement
sort_error
  (s2t0) = res where
{
//
val () =
prerrln!
  ("sort_error: s2t0 = ", s2t0)
//
val () = assertloc(false)
val res = sort_error(s2t0)
//
} (* end of [sort_error] *)

(* ****** ****** *)

implement
sort_make_s2rt(s2t0) = let
//
(*
val () =
println! ("sort_make: s2t0 = ", s2t0)
*)
//
in
//
case+ s2t0 of
//
| S2RTint() => sort_int()
| S2RTaddr() => sort_int()
| S2RTbool() => sort_bool()
//
| S2RTreal() => sort_real()
(*
| S2RTfloat() => sort_float()
| S2RTstring() => sort_string()
*)
//
| S2RTcls() => sort_mk_cls()
| S2RTeff() => sort_mk_eff()
//
| S2RTtype() => sort_mk_type()
| S2RTvtype() => sort_mk_vtype()
| S2RTt0ype() => sort_mk_t0ype()
| S2RTvt0ype() => sort_mk_vt0ype()
//
| S2RTprop() => sort_mk_prop()
| S2RTview() => sort_mk_view()
//
| S2RTtkind() => sort_mk_tkind()
//
| S2RTnamed(sym) =>
    sort_mk_abstract(sym.name())
  // end of [S2RTnamed]
//
| _(*rest-of-S2RT*) => sort_error(s2t0)
//
end (* end of [sort_make_s2rt] *)

(* ****** ****** *)

(* end of [patsolve_z3_solving_sort.dats] *)

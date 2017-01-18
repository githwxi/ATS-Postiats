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
(* ****** ****** *)
//
implement
print_s2cinterp
  (x) = fprint_s2cinterp(stdout_ref, x)
implement
prerr_s2cinterp
  (x) = fprint_s2cinterp(stderr_ref, x)
//
implement
fprint_s2cinterp
  (out, x) = let
in
//
case+ x of
//
| S2CINTnone() => fprint! (out, "S2CINTnone()")
//
| S2CINTsome _ => fprint! (out, "S2CINTsome(...)")
//
| S2CINTbuiltin_0 _ => fprint! (out, "S2CINTbuiltin_0(...)")
| S2CINTbuiltin_1 _ => fprint! (out, "S2CINTbuiltin_1(...)")
| S2CINTbuiltin_2 _ => fprint! (out, "S2CINTbuiltin_2(...)")
//
| S2CINTbuiltin_list _ => fprint! (out, "S2CINTbuiltin_list(...)")
//
end // end of [fprint_s2cinterp]
//
(* ****** ****** *)

implement
fprint_val<s2cinterp> = fprint_s2cinterp

(* ****** ****** *)

local

typedef
key = string and itm = s2cinterp

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local
//
val
the_s2cinterp_map = myhashtbl_make_nil(1024)
//
fun
s2cinterp_insert
(
  name: string, itm: s2cinterp
) : void =
{
//
val-~None_vt() =
  myhashtbl_insert(the_s2cinterp_map, name, itm)
// end of [val]
} (* end of [s2cinterp_insert] *)
//
in (* in-of-local *)
//
implement
s2cst_get_s2cinterp
  (s2c) = let
//
val ptr = s2cst_get_payload(s2c)
//
in
//
if
ptr > 0
then $UN.cast{s2cinterp}(ptr)
else let
//
val key = symbol_get_name(s2c.name())
val opt = myhashtbl_search(the_s2cinterp_map, key)
val itm =
(
  case+ opt of
  | ~Some_vt(itm) => itm
  | ~None_vt((*void*)) => S2CINTnone()
) : s2cinterp // end of [val]
val () = s2cst_set_payload(s2c, $UN.cast{ptr}(itm))
//
in
  itm
end // end of [else]
//
end // end of [s2cst_get_s2cinterp]
//
implement
the_s2cinterp_initize() =
{
//
macdef insert = s2cinterp_insert
//
val () = insert("unit_p", S2CINTbuiltin_0(formula_true))
//
val () = insert("null_addr", S2CINTbuiltin_0(formula_null))
//
val () = insert("true_bool", S2CINTbuiltin_0(formula_true))
val () = insert("false_bool", S2CINTbuiltin_0(formula_false))
//
val () = insert("neg_int", S2CINTbuiltin_1(formula_ineg))
//
val () = insert("add_int_int", S2CINTbuiltin_2(formula_iadd))
val () = insert("sub_int_int", S2CINTbuiltin_2(formula_isub))
//
val () = insert("mul_int_int", S2CINTbuiltin_2(formula_imul))
val () = insert("div_int_int", S2CINTbuiltin_2(formula_idiv))
val () = insert("idiv_int_int", S2CINTbuiltin_2(formula_idiv))
val () = insert("ndiv_int_int", S2CINTbuiltin_2(formula_ndiv))
//
val () = insert("lt_int_int", S2CINTbuiltin_2(formula_ilt))
val () = insert("lte_int_int", S2CINTbuiltin_2(formula_ilte))
val () = insert("gt_int_int", S2CINTbuiltin_2(formula_igt))
val () = insert("gte_int_int", S2CINTbuiltin_2(formula_igte))
val () = insert("eq_int_int", S2CINTbuiltin_2(formula_ieq))
val () = insert("neq_int_int", S2CINTbuiltin_2(formula_ineq))
//
val () = insert("abs_int", S2CINTbuiltin_1(formula_iabs))
val () = insert("sgn_int", S2CINTbuiltin_1(formula_isgn))
//
val () = insert("max_int_int", S2CINTbuiltin_2(formula_imax))
val () = insert("min_int_int", S2CINTbuiltin_2(formula_imin))
//
val () = insert("neg_bool", S2CINTbuiltin_1(formula_bneg))
//
val () = insert("add_bool_bool", S2CINTbuiltin_2(formula_badd))
val () = insert("mul_bool_bool", S2CINTbuiltin_2(formula_bmul))
//
val () = insert("lt_bool_bool", S2CINTbuiltin_2(formula_blt))
val () = insert("lte_bool_bool", S2CINTbuiltin_2(formula_blte))
val () = insert("gt_bool_bool", S2CINTbuiltin_2(formula_bgt))
val () = insert("gte_bool_bool", S2CINTbuiltin_2(formula_bgte))
val () = insert("eq_bool_bool", S2CINTbuiltin_2(formula_beq))
val () = insert("neq_bool_bool", S2CINTbuiltin_2(formula_bneq))
//
val () = insert("add_addr_int", S2CINTbuiltin_2(formula_iadd))
val () = insert("sub_addr_int", S2CINTbuiltin_2(formula_isub))
val () = insert("sub_addr_addr", S2CINTbuiltin_2(formula_isub))
//
val () = insert("lt_addr_addr", S2CINTbuiltin_2(formula_ilt))
val () = insert("lte_addr_addr", S2CINTbuiltin_2(formula_ilte))
val () = insert("gt_addr_addr", S2CINTbuiltin_2(formula_igt))
val () = insert("gte_addr_addr", S2CINTbuiltin_2(formula_igte))
val () = insert("eq_addr_addr", S2CINTbuiltin_2(formula_ieq))
val () = insert("neq_addr_addr", S2CINTbuiltin_2(formula_ineq))
//
(*
//
// HX-2016-06-08: for operations on reals
//
*)
//
val () = insert("int2real", S2CINTbuiltin_1(formula_int2real))
//
val () = insert("neg_real", S2CINTbuiltin_1(formula_neg_real))
val () = insert("abs_real", S2CINTbuiltin_1(formula_abs_real))
//
val () =
  insert("add_real_real", S2CINTbuiltin_2(formula_add_real_real))
val () =
  insert("sub_real_real", S2CINTbuiltin_2(formula_sub_real_real))
val () =
  insert("mul_real_real", S2CINTbuiltin_2(formula_mul_real_real))
val () =
  insert("div_real_real", S2CINTbuiltin_2(formula_div_real_real))
//
val () = insert("lt_real_real", S2CINTbuiltin_2(formula_lt_real_real))
val () = insert("lte_real_real", S2CINTbuiltin_2(formula_lte_real_real))
val () = insert("gt_real_real", S2CINTbuiltin_2(formula_gt_real_real))
val () = insert("gte_real_real", S2CINTbuiltin_2(formula_gte_real_real))
val () = insert("eq_real_real", S2CINTbuiltin_2(formula_eq_real_real))
val () = insert("neq_real_real", S2CINTbuiltin_2(formula_neq_real_real))
//
(*
val () = insert("add_int_real", S2CINTbuiltin_2(formula_add_int_real))
val () = insert("add_real_int", S2CINTbuiltin_2(formula_add_real_int))
val () = insert("sub_int_real", S2CINTbuiltin_2(formula_sub_int_real))
val () = insert("sub_real_int", S2CINTbuiltin_2(formula_sub_real_int))
val () = insert("mul_int_real", S2CINTbuiltin_2(formula_mul_int_real))
val () = insert("div_real_int", S2CINTbuiltin_2(formula_div_real_int))
*)
//
(*
val () = insert("lt_real_int", S2CINTbuiltin_2(formula_lt_real_int))
val () = insert("lte_real_int", S2CINTbuiltin_2(formula_lte_real_int))
val () = insert("gt_real_int", S2CINTbuiltin_2(formula_gt_real_int))
val () = insert("gte_real_int", S2CINTbuiltin_2(formula_gte_real_int))
val () = insert("eq_real_int", S2CINTbuiltin_2(formula_eq_real_int))
val () = insert("neq_real_int", S2CINTbuiltin_2(formula_neq_real_int))
*)
//
} (* end of [the_s2cinterp_initize] *)

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_z3_solving_interp.dats] *)

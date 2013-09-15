//
// Evaluating arithmetic
// expressions in postfix notation
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "libats/SATS/stkarray.sats"
staload _(*anon*) = "libats/DATS/stkarray.dats"

(* ****** ****** *)

extern fun postfix_eval (string): int

(* ****** ****** *)
//
// HX: each integer is assumed to be single-digit
// HX: every illegal expression yields a run-time exception
// 
(* ****** ****** *)

implement
postfix_eval
  (str) = let
//
#define NUL '\000'
//
fun loop
(
  stk: !stkarray (int) >> _, p: ptr
) : void = let
  val c = $UN.ptr0_get<char> (p)
in
//
if c != NUL then
(
case+ c of
| _ when isdigit(c) => let
    val-~None_vt((*void*)) = stkarray_insert_opt (stk, c-'0')
  in
    loop (stk, ptr_succ<char> (p))
  end
| '+' => let
    val-~Some_vt(i2) = stkarray_takeout_opt (stk)
    val-~Some_vt(i1) = stkarray_takeout_opt (stk)
    val-~None_vt((*void*)) = stkarray_insert_opt (stk, i1+i2)
  in
    loop (stk, ptr_succ<char> (p))
  end
| '-' => let
    val-~Some_vt(i2) = stkarray_takeout_opt (stk)
    val-~Some_vt(i1) = stkarray_takeout_opt (stk)
    val-~None_vt((*void*)) = stkarray_insert_opt (stk, i1-i2)
  in
    loop (stk, ptr_succ<char> (p))
  end
| '*' => let
    val-~Some_vt(i2) = stkarray_takeout_opt (stk)
    val-~Some_vt(i1) = stkarray_takeout_opt (stk)
    val-~None_vt((*void*)) = stkarray_insert_opt (stk, i1*i2)
  in
    loop (stk, ptr_succ<char> (p))
  end
| '/' => let
    val-~Some_vt(i2) = stkarray_takeout_opt (stk)
    val-~Some_vt(i1) = stkarray_takeout_opt (stk)
    val-~None_vt((*void*)) = stkarray_insert_opt (stk, i1/i2)
  in
    loop (stk, ptr_succ<char> (p))
  end
//
| _(*unrecogized*) => loop (stk, ptr_succ<char> (p))
//
) else () // end of [if]
//
end // end of [loop]
//
val m = string_length (str)
val m = g1ofg0_uint (m)
val stk = stkarray_make_cap<int> (m)
//
val () = loop (stk, string2ptr(str))
val-~Some_vt (res) = stkarray_takeout_opt (stk)
val () = assertloc (stkarray_is_nil (stk))
val () = stkarray_free_nil (stk)
//
in
  res
end // end of [postfix_eval]

(* ****** ****** *)

implement
main0 () = () where
{
//
#define EXP "18+3*2-61-/6*"
//
val res = postfix_eval (EXP)
//
val () = println! ("eval(", EXP, ") = ", res)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [postfix_eval.dats] *)

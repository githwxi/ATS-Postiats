(* ****** ****** *)

(*
** A linear stack
** implementation based on STL:vector
*)

(* ****** ****** *)
(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremal: gmhwxiATgmailDOTcom
// Start Time: December, 2016
//
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATS2CPP.STL"
#define
ATS_DYNLOADFLAG 0 // no dynloading at run-time
#define
ATS_EXTERN_PREFIX "ats2cpp_STL_" // prefix for external names
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

%{#
//
#ifndef \
ATS2CPP_STL_DATS_VECTOR_STACK
#define \
ATS2CPP_STL_DATS_VECTOR_STACK
//
#include "STL/CATS/vector.cats"
//
#endif // end of ifndef(ATS2CPP_STL_DATS_VECTOR_STACK)
//
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
stack_vtype
(a:vt@ype+, n:int) =
$extype"ats2cpp_STL_vectorptr"(a)
//
stadef stack = stack_vtype
//
vtypedef
stack(a:vt@ype) = [n:int] stack_vtype(a, n)
//
(* ****** ****** *)
//
extern
prfun
lemma_stack_param
  {a:vt0p}{n:int}
  (stk: !stack(INV(a), n)): [n >= 0] void
//
(* ****** ****** *)
//
extern
fun
{a:vt@ype}
stack_make_nil(): stack(a, 0)
extern
fun
{a:vt@ype}
stack_free_nil(stack(INV(a), 0)): void
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
stack_length
  {n:int}
  (stk: !stack(a, n)): size_t(n) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
stack_is_nil
  {n:int}
  (stk: !stack(a, n)): bool(n==0) = "mac#%"
extern
fun
{a:vt0p}
stack_isnot_nil
  {n:int}
  (stk: !stack(a, n)): bool(n > 0) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
stack_insert
  {n:int}
(
stk:
!stack(a, n) >> stack(a, n+1), x: a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
stack_takeout
  {n:int | n > 0}
(
  stk: !stack(a, n) >> stack(a, n-1)
) : (a) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
overload iseqz with stack_is_nil
overload isneqz with stack_isnot_nil
//
(* ****** ****** *)
//
overload length with stack_length
//
(* ****** ****** *)
//
overload .size with stack_length
overload .length with stack_length
//
overload .insert with stack_insert
overload .takeout with stack_takeout
//
(* ****** ****** *)
//
// HX-2016-12:
// externally template-based implmentation
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_make_nil
(
// argumentless
) =
$extfcall
( stack(a, 0)
, "ats2cpp_STL_vectorptr_new", $tyrep(a)
) (* stack_make_nil *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_free_nil
(
  p0
) = let
//
val p0 = $UN.castvwtp0{ptr}(p0)
//
in
//
$extfcall
( void
, "ats2cpp_STL_vectorptr_free", $tyrep(a), p0
) (* $extfcall *)
//
end // end of [stack_free_nil]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_length
  {n}(p0) = let
//
val p0 = $UN.castvwtp1{ptr}(p0)
//
in
//
$extfcall
(
  size_t(n)
, "ats2cpp_STL_vectorptr_size", $tyrep(a), p0
) (* $extfcall *)
//
end // end of [stack_length]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_is_nil
  {n}(p0) = let
//
val p0 = $UN.castvwtp1{ptr}(p0)
//
in
//
$extfcall
( bool(n==0)
, "ats2cpp_STL_vectorptr_empty", $tyrep(a), p0
) (* $extfcall *)
//
end // end of [stack_is_nil]
//
//
implement
{a}(*tmp*)
stack_isnot_nil(p0) =
not(stack_is_nil<a>(p0)) where
{
  prval ((*n >= 0*)) = lemma_stack_param(p0)
} (* end of [stack_isnot_nil] *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_insert
  (p0, x0) = let
//
prval
() = $UN.castvwtp2void(p0)
//
val x0 = $UN.castvwtp0{a?}(x0)
val p0 = $UN.castvwtp1{ptr}(p0)
//
in
//
$extfcall
( void,
  "ats2cpp_STL_vectorptr_push_back", $tyrep(a), p0, x0
) (* $extfcall *)
//
end // end of [stack_insert]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
stack_takeout
  (p0) = x0 where
{
//
prval
() = $UN.castvwtp2void(p0)
//
val p0 = $UN.castvwtp1{ptr}(p0)
val x0 =
  $extfcall(a, "ats2cpp_STL_vectorptr_back", $tyrep(a), p0)
val () =
  $extfcall(void, "ats2cpp_STL_vectorptr_pop_back", $tyrep(a), p0)
//
} (* end of [stack_insert] *)
//
(* ****** ****** *)

(* end of [vector_stack.dats] *)

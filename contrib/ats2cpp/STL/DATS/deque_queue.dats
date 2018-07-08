(* ****** ****** *)

(*
** A linear queue
** implementation based on STL:deque
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
ATS2CPP_STL_DATS_DEQUE_QUEUE
#define \
ATS2CPP_STL_DATS_DEQUE_QUEUE
//
#include "STL/CATS/deque.cats"
//
#endif // end of ifndef(ATS2CPP_STL_DATS_DEQUE_QUEUE)
//
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
queue_vtype
(a:vt@ype+, n:int) =
$extype"ats2cpp_STL_dequeptr"(a)
//
stadef queue = queue_vtype
//
vtypedef
queue(a:vt@ype) = [n:int] queue_vtype(a, n)
//
(* ****** ****** *)
//
extern
prfun
lemma_queue_param
  {a:vt0p}{n:int}
  (stk: !queue(INV(a), n)): [n >= 0] void
//
(* ****** ****** *)
//
extern
fun
{a:vt@ype}
queue_make_nil(): queue(a, 0)
extern
fun
{a:vt@ype}
queue_free_nil(queue(INV(a), 0)): void
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_length
  {n:int}(stk: !queue(a, n)): size_t(n) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_insert
  {n:int}
(
stk:
!queue(a, n) >> queue(a, n+1), x: a
) : void = "mac#%" // end-of-function
//
extern
fun
{a:vt0p}
queue_takeout
  {n:int | n > 0}
(
  stk: !queue(a, n) >> queue(a, n-1)
) : (a) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
overload length with queue_length
//
(* ****** ****** *)
//
overload .size with queue_length
overload .length with queue_length
//
overload .insert with queue_insert
overload .takeout with queue_takeout
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
queue_make_nil
(
// argumentless
) =
$extfcall
(
  queue(a, 0), "ats2cpp_STL_dequeptr_new", $tyrep(a)
) (* queue_make_nil *)
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_free_nil
(
  p0
) = let
//
val p0 = $UN.castvwtp0{ptr}(p0)
//
in
//
$extfcall
  (void, "ats2cpp_STL_dequeptr_free", $tyrep(a), p0)
//
end // end of [queue_free_nil]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_length
  {n}(p0) = let
//
val p0 = $UN.castvwtp1{ptr}(p0)
//
in
//
$extfcall
  (size_t(n), "ats2cpp_STL_dequeptr_size", $tyrep(a), p0)
//
end // end of [queue_length]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_insert
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
  "ats2cpp_STL_dequeptr_push_back", $tyrep(a), p0, x0
) (* $extfcall *)
//
end // end of [queue_insert]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_takeout
  (p0) = x0 where
{
//
prval
() = $UN.castvwtp2void(p0)
//
val p0 = $UN.castvwtp1{ptr}(p0)
val x0 =
  $extfcall(a, "ats2cpp_STL_dequeptr_front", $tyrep(a), p0)
val () =
  $extfcall(void, "ats2cpp_STL_dequeptr_pop_front", $tyrep(a), p0)
//
} (* end of [queue_insert] *)
//
(* ****** ****** *)

(* end of [deque_queue.dats] *)

(* ****** ****** *)

(*
** A linear queue
** implementation based on STL:queue
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
ATS2CPP_STL_DATS_QUEUE_QUEUE
#define \
ATS2CPP_STL_DATS_QUEUE_QUEUE
//
#include "STL/CATS/queue.cats"
//
#endif // end of ifndef(ATS2CPP_STL_DATS_QUEUE_QUEUE)
//
%} // end of [%{#]

(* ****** ****** *)
//
absvtype
queue_vtype
(a:vt@ype+, n:int) =
$extype"ats2cpp_STL_queueptr"(a)
//
stadef queue = queue_vtype
//
vtypedef
queue(a:vt0p) = [n:int] queue_vtype(a, n)
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
{a:vt0p}
queue_make_nil(): queue(a, 0)
//
extern
fun
{a:vt0p}
queue_free_nil(queue(INV(a), 0)): void
extern
fun
{a:t@ype}
queue_free_all{n:int}(queue(INV(a), n)): void
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_length
  {n:int}
  (stk: !queue(INV(a), n)): size_t(n) = "mac#%"
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_is_nil
  {n:int}
  (stk: !queue(INV(a), n)): bool(n==0) = "mac#%"
extern
fun
{a:vt0p}
queue_isnot_nil
  {n:int}
  (stk: !queue(INV(a), n)): bool(n > 0) = "mac#%"
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
!queue(INV(a), n) >> queue(a, n+1), x: a
) : void = "mac#%" // end-of-function
//
(* ****** ****** *)
//
extern
fun
{a:vt0p}
queue_takeout
  {n:int | n > 0}
(
  stk: !queue(INV(a), n) >> queue(a, n-1)
) : (a) = "mac#%" // end-of-function
//
extern
fun
{a:vt0p}
queue_takeout_opt
  {n:int}
(
  stk: !queue(INV(a), n) >> queue(a, n-b2i(b))
) : #[b:bool] option_vt(a, b) = "mac#%"
//
(* ****** ****** *)
//
overload iseqz with queue_is_nil
overload isneqz with queue_isnot_nil
//
overload length with queue_length
//
(* ****** ****** *)
//
overload .size with queue_length
overload .length with queue_length
//
(* ****** ****** *)
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
  queue(a, 0), "ats2cpp_STL_queueptr_new", $tyrep(a)
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
  (void, "ats2cpp_STL_queueptr_free", $tyrep(a), p0)
//
end // end of [queue_free_nil]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_free_all
(
  p0
) = let
//
val p0 = $UN.castvwtp0{ptr}(p0)
//
in
//
$extfcall
  (void, "ats2cpp_STL_queueptr_free", $tyrep(a), p0)
//
end // end of [queue_free_all]
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
(
  size_t(n)
, "ats2cpp_STL_queueptr_size", $tyrep(a), p0
) (* $extfcall *)
//
end // end of [queue_length]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
queue_is_nil
  {n}(p0) = let
//
val p0 = $UN.castvwtp1{ptr}(p0)
//
in
//
$extfcall
(
  bool(n==0)
, "ats2cpp_STL_queueptr_empty", $tyrep(a), p0
) (* $extfcall *)
//
end // end of [queue_is_nil]
//
//
implement
{a}(*tmp*)
queue_isnot_nil(p0) =
not(queue_is_nil<a>(p0)) where
{
  prval ((*n >= 0*)) = lemma_queue_param(p0)
} (* end of [queue_isnot_nil] *)
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
  "ats2cpp_STL_queueptr_push", $tyrep(a), p0, x0
) (* $extfcall *)
//
end // end of [queue_insert]
//
(* ****** ****** *)
//
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
//
val x0 =
$extfcall
( (a)
, "ats2cpp_STL_queueptr_front", $tyrep(a), p0
) (* $extfcall *)
val () =
$extfcall
(
  void, "ats2cpp_STL_queueptr_pop", $tyrep(a), p0
) (* $extfcall *)
//
} (* end of [queue_insert] *)
//
implement
{a}(*tmp*)
queue_takeout_opt
  (p0) = let
//
prval () = lemma_queue_param(p0)
//
in
//
if iseqz(p0)
  then None_vt() else Some_vt(queue_takeout<a>(p0))
//
end // end of [queue_takeout_opt]
//
(* ****** ****** *)

(* end of [queue_queue.dats] *)

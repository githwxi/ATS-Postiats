(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person obtaining a
** copy of this software and associated documentation files (the "Software"),
** to deal in the Software without restriction, including without limitation
** the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following stated conditions:
** 
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
** 
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
** THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
** IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
absvt@ype T
#define CAPACITY1 (= CAPACITY + 1)
*)

(* ****** ****** *)

extern fun get_size ():<> size_t
extern fun get_capacity ():<> size_t

(* ****** ****** *)

extern fun is_nil ():<> bool
extern fun isnot_nil ():<> bool
extern fun is_full ():<> bool
extern fun isnot_full ():<> bool

(* ****** ****** *)
//
exception
GDEQARRAYinsert of ()
//
extern
fun
insert_atbeg
(
  x0: T, res: &T? >> opt (T, b)
) : #[b:bool] bool(b) // endfun
//
extern
fun insert_atbeg_exn (x0: T): void
extern
fun insert_atbeg_opt (x0: T): Option_vt (T)
//
extern
fun
insert_atend
(
  x0: T, res: &T? >> opt (T, b)
) : #[b:bool] bool(b) // endfun
//
extern
fun insert_atend_exn (x0: T): void
extern
fun insert_atend_opt (x0: T): Option_vt (T)
//
(* ****** ****** *)
//
exception
GDEQARRAYtakeout of ()
//
extern
fun
takeout_atbeg
(
  x0: &T? >> opt (T, b)
) : #[b:bool] bool (b) // endfun
//
extern
fun takeout_atbeg_exn ((*void*)): T
extern
fun takeout_atbeg_opt ((*void*)): Option_vt (T)
//
extern
fun
takeout_atend
(
  x0: &T? >> opt (T, b)
) : #[b:bool] bool (b) // endfun
//
extern
fun takeout_atend_exn ((*void*)): T
extern
fun takeout_atend_opt ((*void*)): Option_vt (T)
//
(* ****** ****** *)

local
//
staload
UN = "prelude/SATS/unsafe.sats"
//
staload "libats/SATS/deqarray.sats"
staload _ = "libats/DATS/deqarray.dats"
//
#define
CAPACITY (CAPACITY1-1)
//
local
//
var
_array_ =
@[T][CAPACITY1]()
//
in(*in-of-local*)
val
theArrayptr =
$UN.castvwtp0{arrayptr(T?,CAPACITY1)}((view@_array_ | addr@_array_))
end // end of [local]
//
local
val
cap = CAPACITY
var
_struct_
: deqarray_tsize (*uninitized*)
//
in (*in-of-local*)
val
(pfngc|theDQA0) =
deqarray_make_ngc__tsz{T}(view@_struct_ | addr@_struct_, theArrayptr, i2sz(cap), sizeof<T>)
end // end of [local]
//
vtypedef
DQA = [n:nat] deqarray(T, CAPACITY, n)
//
val theDQA0_ptr = $UN.castvwtp0{ptr}((pfngc | theDQA0))
//
in (* in-of-local *)

implement
get_size () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_get_size (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [get_size] *)

implement
get_capacity () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_get_capacity (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [get_capacity] *)

(* ****** ****** *)

implement
is_nil () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_is_nil (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [is_nil] *)

implement
isnot_nil () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_isnot_nil (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [isnot_nil] *)

(* ****** ****** *)

implement
is_full () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_is_full (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [is_full] *)

implement
isnot_full () = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_isnot_full (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [isnot_full] *)

(* ****** ****** *)

implement
insert_atbeg
  (x0, res) = let
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val isnot = deqarray_isnot_full (dqa)
//
in
//
if isnot
  then let
    val () = deqarray_insert_atbeg (dqa, x0)
    prval ((*void*)) = opt_none (res)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    false
  end // end of [then]
  else let
    val () = res := x0
    prval ((*void*)) = opt_some (res)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    true
  end // end of [else]
// end of [if]
//
end // end of [insert_atbeg]

(* ****** ****** *)

implement
insert_atbeg_exn(x0) = () where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
//
val ((*void*)) = (
//
if
deqarray_isnot_full (dqa)
then deqarray_insert_atbeg (dqa, x0)
else $raise GDEQARRAYinsert((*void*))
//
) : void // end of [val]
//
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [insert_atbeg_exn] *)

implement
insert_atbeg_opt(x0) = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_insert_atbeg_opt (dqa, x0)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [insert_atbeg_opt] *)

(* ****** ****** *)

implement
insert_atend
  (x0, res) = let
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val isnot = deqarray_isnot_full (dqa)
//
in
//
if isnot
  then let
    val () = deqarray_insert_atend (dqa, x0)
    prval ((*void*)) = opt_none (res)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    false
  end // end of [then]
  else let
    val () = res := x0
    prval ((*void*)) = opt_some (res)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    true
  end // end of [else]
// end of [if]
//
end // end of [insert_atend]

(* ****** ****** *)

implement
insert_atend_exn(x0) = () where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
//
val ((*void*)) = (
//
if
deqarray_isnot_full (dqa)
then deqarray_insert_atend (dqa, x0)
else $raise GDEQARRAYinsert((*void*))
//
) : void // end of [val]
//
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [insert_atend_exn] *)

implement
insert_atend_opt(x0) = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_insert_atend_opt (dqa, x0)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [insert_atend_opt] *)

(* ****** ****** *)

implement
takeout_atbeg(x0) = let
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val isnot = deqarray_isnot_nil (dqa)
//
in
//
if isnot
  then let
    val () =
    x0 := deqarray_takeout_atbeg (dqa)
    prval () = opt_some{T}(x0)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    true
  end // end of [then]
  else let
    prval () = opt_none{T}(x0)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    false
  end // end of [else]
// end of [if]
//
end // end of [takeout_atbeg]

(* ****** ****** *)

implement
takeout_atbeg_exn() = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
//
val res = (
//
if
deqarray_isnot_nil(dqa)
then deqarray_takeout_atbeg (dqa)
else $raise GDEQARRAYtakeout((*void*))
//
) : T // end of [val]
//
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [takeout_atbeg_exn] *)

implement
takeout_atbeg_opt() = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val res = deqarray_takeout_atbeg_opt (dqa)
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [takeout_atbeg_opt] *)

(* ****** ****** *)

implement
takeout_atend(x0) = let
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
val isnot = deqarray_isnot_nil (dqa)
//
in
//
if isnot
  then let
    val () =
    x0 := deqarray_takeout_atend (dqa)
    prval ((*void*)) = opt_some{T}(x0)
    prval ((*void*)) = $UN.cast2void (dqa)
  in
    true
  end // end of [then]
  else let
    prval ((*void*)) = opt_none{T}(x0)
    prval ((*void*)) = $UN.cast2void(dqa)
  in
    false
  end // end of [else]
// end of [if]
//
end // end of [takeout_atend]

(* ****** ****** *)

implement
takeout_atend_exn() = res where
{
//
val dqa =
$UN.castvwtp0{DQA}(theDQA0_ptr)
//
val res = (
//
if
deqarray_isnot_nil(dqa)
then deqarray_takeout_atend(dqa)
else $raise GDEQARRAYtakeout((*void*))
//
) : T // end of [val]
//
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [takeout_atend_exn] *)

implement
takeout_atend_opt() = res where
{
//
val dqa =
  $UN.castvwtp0{DQA}(theDQA0_ptr)
//
val res =
  deqarray_takeout_atend_opt (dqa)
//
prval ((*void*)) = $UN.cast2void (dqa)
//
} (* end of [takeout_atend_opt] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [gdeqarray.hats] *)

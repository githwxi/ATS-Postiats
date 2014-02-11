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
*)

(* ****** ****** *)

extern fun isnil (): bool
extern fun iscons (): bool

(* ****** ****** *)

extern fun pop_exn (): T
extern fun pop_opt (): Option_vt(T)
extern fun push (x: T): void

extern fun pop_all (): List0_vt (T)

(* ****** ****** *)

local

vtypedef TS = List0_vt (T)
var _stack: TS = list_vt_nil(*void*)
val r_stack =
  ref_make_viewptr{TS}(view@_stack | addr@_stack)
// end of [val]

(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
isnil () = let
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
in
  list_vt_is_nil (!p)
end // end of [isnil]

implement
iscons () = let
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
in
  list_vt_is_cons (!p)
end // end of [iscons]

(* ****** ****** *)

implement
pop_exn () = x where
{
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
  val-~list_vt_cons (x, xs) = !p; val ((*void*)) = !p := xs
} (* end of [pop_exn] *)

(* ****** ****** *)

implement
pop_opt () = let
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
in
//
case+ !p of
| ~list_vt_cons (x, xs) =>
    let val () = !p := (xs: TS) in Some_vt{T}(x) end
|  list_vt_nil ((*void*)) => None_vt ()
//
end // end of [pop_opt]

(* ****** ****** *)

implement
pop_all () = res where
{
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
  val res = !p; val () = !p := list_vt_nil ((*void*))
} (* end of [pop_all] *)

(* ****** ****** *)

implement
push (x) = let
  val (vbox(pf) | p) = ref_get_viewptr (r_stack)
in
  !p := list_vt_cons{T}(x, !p)
end // end of [push]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [gstacklst.hats] *)

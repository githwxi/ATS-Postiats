(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2017 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// HX-2017-02-09:
//
// A fworkshop where
// fws$store = chanlst
// fws$fwork = lincloptr
//
(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.fworkshop_chanlst"
//
#define
ATS_DYNLOADFLAG 0 // no dynloading
//
(* ****** ****** *)

#include "./fworkshop.dats"

(* ****** ****** *)
//
extern
fun{}
fworkshop_insert_lincloptr
(
  fws: fworkshop, fwork: () -<lincloptr1> int
) : void // end-of-function
//
(* ****** ****** *)

local
//
#include
"./../mydepies.hats"
#staload $CHANLST_t // opening it
//
assume
fws$store_type = chanlst(fws$fwork)
//
vtypedef fwork = fws$fwork
//
in (* in-of-local *)
//
(*
extern
fun{}
fws$store_create_exn(): fws$store
*)
//
implement
{}(*tmp*)
fws$store_create_exn
  ((*void*)) =
  chanlst_create_exn<fwork>()
//
(*extern
fun{}
fws$store_insert
  (fws$store, fws$fwork): void
*)
implement
{}(*tmp*)
fws$store_insert
  (store, fwork) =
{
val-
~None_vt() =
chanlst_insert_opt<fwork>(store, fwork)
}
//
(*
extern
fun{}
fws$store_takeout
  (store: fws$store): fws$fwork
*)
implement
{}(*tmp*)
fws$store_takeout
  (store) = chanlst_takeout<fwork>(store)
//
end // end of [local]

(* ****** ****** *)

local

assume
fws$fwork_vtype = () -<lincloptr1> int

in (* in-of-local *)
//
(*
extern
fun{}
fws$fwork_process(fws$fwork): int
*)
implement
{}(*tmp*)
fws$fwork_process
(
  fwork
) = status where
{
//
val
status = fwork()
//
val () =
cloptr_free
(
$UN.castvwtp0{cloptr(void)}(fwork)
) (* cloptr_free *)
//
} // end of [fws$fwork_process]
//
implement
{}(*tmp*)
fworkshop_insert_lincloptr
  (fws, fwork) =
  fworkshop_insert_work<>(fws, fwork)
//
end // end of [local]

(* ****** ****** *)

(* end of [fworkshop_chanlst.dats] *)

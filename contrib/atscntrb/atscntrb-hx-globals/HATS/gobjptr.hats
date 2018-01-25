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
absvtype objptr(l:addr) = ptr(l)
*)

(* ****** ****** *)

vtypedef objptr0 = [l:addr] objptr(l)
vtypedef objptr1 = [l:addr | l > null] objptr(l)

(* ****** ****** *)
//
extern fun initset {l:agz} (x: objptr (l)): void
//
extern fun takeout ((*void*)): [l:addr] objptr(l)
extern fun vtakeout ((*void*)): [l:addr] vttakeout0 (objptr(l))
//
extern fun exchange {l:addr} (x: objptr(l)): [l:addr] objptr(l)
//
(* ****** ****** *)

local
//
var obj: objptr0 =
  $UNSAFE.castvwtp0{objptr(null)}(0)
//
val p_obj = addr@(obj)
prval pf_obj = view@(obj)
//
val r_obj = ref_make_viewptr{objptr0}(pf_obj | p_obj)

in (* in of [local] *)

(* ****** ****** *)

implement
initset (x_init) =
{
  val (vbox pf | p) = ref_get_viewptr (r_obj)
  val x_null = !p; val ((*void*)) = !p := x_init
  val () = assertloc ($UNSAFE.castvwtp0{ptr}(x_null) = the_null_ptr)
} (* end of [initset] *)

implement
takeout () = x_current where
{
  val (vbox pf | p) = ref_get_viewptr (r_obj)
  val x_null = $UNSAFE.castvwtp0{objptr(null)}(0)
  val x_current = !p; val ((*void*)) = !p := x_null
} (* end of [where] *) // end of [takeout]

(* ****** ****** *)

implement
vtakeout () = let
  val (vbox pf | p) = ref_get_viewptr (r_obj) in $UNSAFE.castvwtp1(!p)
end // end of [let] // end [vtakeout]

(* ****** ****** *)

implement
exchange (x_new) = x_current where
{
  val (vbox pf | p) = ref_get_viewptr (r_obj)
  val x_current = !p; val ((*void*)) = !p := x_new
} // end of [where] (* end of [initset] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [gobjptr.hats] *)

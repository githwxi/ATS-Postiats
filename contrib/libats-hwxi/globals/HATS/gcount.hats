(***********************************************************************)
(*                                                                     *)
(*                         ATS/contrib/atshwxi                         *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
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
staload _(*anon*) =
"prelude/DATS/integer.dats"
//
(* ****** ****** *)

extern fun inc (): void
extern fun dec (): void
extern fun get (): int
extern fun set (x: int): void
extern fun reset (): void

(* ****** ****** *)

extern fun getinc (): int
extern fun decget (): int

(* ****** ****** *)

local

var _val: int = 0
val p_val = addr@(_val)
prval pf_val = view@(_val)

val r_val =
  ref_make_viewptr{int}(pf_val | p_val)
// end of [val]

in (* in of [local] *)

implement inc () =
  let val n = !r_val in !r_val := n + 1 end
// end of [inc]

implement dec () =
  let val n = !r_val in !r_val := n - 1 end
// end of [dec]

implement get () = !r_val

implement set (x) = !r_val := x

implement reset () = !r_val := 0

implement getinc () =
  let val n = !r_val in !r_val := n + 1; (n) end
// end of [getinc]

implement decget () =
  let val n1 = !r_val - 1 in !r_val := n1; (n1) end
// end of [decget]

end // end of [local]

(* ****** ****** *)

(* end of [gcount.hats] *)

(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
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
//
(*
** cstream:
** stream of characters
*)
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../SATS/cstream.sats"
//
(* ****** ****** *)

reassume cstream_vtype(*tkind*)

(* ****** ****** *)

implement
cstream_free
  (cs0) = () where
{
//
  val+@CS(cstruct) = cs0
  val () = cstruct.free(addr@(cstruct.data))
  val ((*void*)) = free@cs0
//
} // end of [cstream_free]

(* ****** ****** *)

implement
{}(*tmp*)
cstream_get_char
  (cs0) = ret where
{
//
  val+@CS(cstruct) = cs0
  val ret = cstruct.getc(addr@(cstruct.data))
  prval ((*void*)) = fold@cs0
//
} // end of [cstream_get_char]

(* ****** ****** *)

implement
{tk}(*tmp*)
cstream_getv_char
  {n} (cs0, A, n) = let
//
fun loop
(
  cs0: !cstream, p: ptr, n: int
) : int =
(
if (n > 0) then let
//
val i = cstream_get_char(cs0)
//
in
//
if i >= 0
  then let
    val c = int2char0(i)
    val () = $UN.ptr0_set<char>(p, c)
  in
    loop (cs0, ptr_succ<char>(p), pred(n))
  end // end of [then]
  else (n) // end of [else]
// end of [if]
end else (0) // end of [if]
//
) (* end of [loop] *)
//
val n2 = loop (cs0, addr@A, n)
//
in
  $UN.cast{natLte(n)}(n-n2)
end // end of [cstream_getv_char]

(* ****** ****** *)

implement
{}(*tmp*)
cstream_get_charlst
  (cs0, n) = let
//
fun loop (
  cs0: !cstream, n: int
, res: &ptr? >> List0_vt(char)
) : void = let
in
//
if n != 0
  then let
    val i =
      cstream_get_char(cs0)
    // end of [val]
  in
    if i > 0
      then let
        val c = int2char0(i)
        val () =
          res := list_vt_cons{char}{0}(c, _)
        val+list_vt_cons (_, res1) = res
        val () = loop (cs0, pred(n), res1)
        prval () = fold@res
      in
        // nothing
      end // end of [then]
      else let
        val () = res := list_vt_nil ()
      in
        // nothing
      end // end of [else]
    // end of [if]
  end // end of [then]
  else let
    val () = res := list_vt_nil ()
  in
    // nothing
  end // end of [else]
// end of [if]
//
end (* end of [loop] *)
//
var res: ptr
val () = loop (cs0, n, res)
//
in
  res
end // end of [cstream_get_charlst]

(* ****** ****** *)
//
// HX-2014-05-08:
// Some common tokenizing functions
//
(* ****** ****** *)

implement
{}(*tmp*)
cstream_tokenize_uint
  (cs0, c0) = let
//
#define i2c int2char0
//
fun loop
(
  cs0: !cstream, res: &int >> _
) : int(*c*) = let
  val i = cstream_get_char (cs0)
in
//
if i >= 0 then
(
  if isdigit (i)
    then let
      val d = i2c(i) - '0'
      val () = res := 10*res+d
    in
      loop (cs0, res)
    end // end-of-then
    else (i) // end-of-else
) else (i)
//
end // end of [loop]
//
var res: int = i2c(c0) -'0'
val () = c0 := loop (cs0, res)
//
in
  g0int2uint(res)
end // end of [cstream_tokenize_uint]

(* ****** ****** *)

implement
{}(*tmp*)
cstream_tokenize_ident
  (cs0, c0, sbf) = let
//
fun isalnum_ (i: int): bool =
  if isalnum (i)
    then true else (i = char2int0('_'))
  // end of [if]
//
fun loop
(
  cs0: !cstream
, sbf: !stringbuf
) : int = let
//
val i = cstream_get_char (cs0)
//
in
//
if
i >= 0
then
(
//
if
isalnum_ (i)
then let
  val c = $UN.cast{charNZ}(i)
  val _ =
  $SBF.stringbuf_insert(sbf, c) in loop(cs0, sbf)
end // end-of-then
else (i) // end-of-else
//
) (* end of [then] *)
else (i) // end of [else]
//
end // end of [tokener_get_ide]
//
val _ =
  $SBF.stringbuf_insert(sbf, $UN.cast{charNZ}(c0))
//
val () = (c0 := loop (cs0, sbf))
//
in
  $SBF.stringbuf_truncout_all (sbf)
end // end of [cstream_tokenize_ident]

(* ****** ****** *)

implement
{}(*tmp*)
cstream_tokenize_string
  (cs0, c0, sbf) = let
//
fnx loop
(
  cs0: !cstream
, sbf: !stringbuf
, nerr: &int >> _
) : int = let
//
val i =
cstream_get_char (cs0)
val c = int2char0 (i)
//
in
//
if i >= 0 then
(
case+ c of
| '"' => cstream_get_char (cs0)
| '\\' => loop_escaped (cs0, sbf, nerr)
| '\0' => (0)
| _(*any*) => let
    val c = $UN.cast{charNZ}(i)
    val _ = $SBF.stringbuf_insert (sbf, c)
  in
    loop (cs0, sbf, nerr)
  end // end of [any]
) else (0) // end of [if]
//
end // end of [loop]
//
and loop_escaped
(
  cs0: !cstream
, sbf: !stringbuf
, nerr: &int >> _
) : int = let
//
val i =
cstream_get_char (cs0)
val c = int2char0 (i)
//
in
//
if i >= 0 then
(
case+ c of
| '"' => let
    val c = $UN.cast{charNZ}(c)
    val _ = $SBF.stringbuf_insert (sbf, c)
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| '\\' => let
    val c = $UN.cast{charNZ}(c)
    val _ = $SBF.stringbuf_insert (sbf, c)
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| 'n' => let
    val _ = $SBF.stringbuf_insert (sbf, '\n')
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| 't' => let
    val _ = $SBF.stringbuf_insert (sbf, '\t')
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| 'b' => let
    val _ = $SBF.stringbuf_insert (sbf, '\b')
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| 'f' => let
    val _ = $SBF.stringbuf_insert (sbf, '\f')
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
| 'r' => let
    val _ = $SBF.stringbuf_insert (sbf, '\r')
  in
    loop (cs0, sbf, nerr) 
  end // end of ...
//
| '\0' => (0)
//
| _(*any*) => let
    val c = $UN.cast{charNZ}(c)
    val _ = $SBF.stringbuf_insert (sbf, c)
    val () = nerr := (nerr + 1)
  in
    loop (cs0, sbf, nerr) 
  end // end of [any]
) else (0) // end of [if]
//
end // end of [loop_escaped]
//
var nerr: int = 0
val ((*void*)) = c0 := loop (cs0, sbf, nerr)
//
in
  $SBF.stringbuf_truncout_all (sbf)
end // end of [cstream_tokenize_string]

(* ****** ****** *)

(* end of [cstream.dats] *)

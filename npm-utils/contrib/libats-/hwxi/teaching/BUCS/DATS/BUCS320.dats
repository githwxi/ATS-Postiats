(***********************************************************************)
(*                                                                     *)
(*                       ATS/contrib/libats-hwxi                       *)
(*                                                                     *)
(***********************************************************************)

(*
** Copyright (C) 2014-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2014-02-06
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
staload
"libats/ML/SATS/array0.sats"
//
(* ****** ****** *)
//
staload
STDIO =
"libats/libc/SATS/stdio.sats"
//
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
//
staload
TIME = "libats/libc/SATS/time.sats"
//
(* ****** ****** *)
//
staload
STAT =
"libats/libc/SATS/sys/stat.sats"
staload
TYPES =
"libats/libc/SATS/sys/types.sats"
//
(* ****** ****** *)

fun{}
test_file_ixoth
  (path: string): int = let
//
macdef
S_IXOTH =
$UN.cast2uint($STAT.S_IXOTH)
//
implement
test_file_mode$pred<>
  (mode) = (mode land S_IXOTH) != 0u
//
in
//
  test_file_mode (path)
//
end // end of [test_file_ixoth]

(* ****** ****** *)

extern
fun{}
randint{n:pos}(int(n)): natLt(n)
implement
{}(*tmp*)
randint{n}(n) = let
  val x = $STDLIB.random()
in
  $UN.cast{natLt(n)}(x mod $UN.cast2lint(n))
end // end of [randint]

(* ****** ****** *)

extern
fun{}
srandom_with_time((*void*)): void
implement
{}(*tmp*)
srandom_with_time () =
  $STDLIB.srandom($UN.cast{uint}($TIME.time_get()))
// end of [srandom_with_time]

(* ****** ****** *)

extern
fun{}
srand48_with_time((*void*)): void
implement
{}(*tmp*)
srand48_with_time () =
  $STDLIB.srand48($UN.cast{lint}($TIME.time_get()))
// end of [srand48_with_time]

(* ****** ****** *)
//
extern
fun{}
string_split_delim_string
(
  source: string, delim: string
) : List0_vt(Strptr1) // end-of-fun
//
implement
{}(*tmp*)
string_split_delim_string
  (source, delim) = let
//
#define NUL '\000'
//
vtypedef res = List0_vt(Strptr1)
//
fun loop
(
  p: ptr, res: res
) : res = let
//
val str =
  $UN.cast{String}(p)
//
val len = strspn(str, delim)
val plen = ptr_add<char>(p, len)
//
val str2 =
  $UN.cast{String}(plen)
val len2 = strcspn(str2, delim)
//
in
//
if
len2 = 0
then res
else let
  val x =
  string_make_substring
  (
    str2, i2sz(0), len2
  ) (* end of [val] *)
prval () = lemma_strnptr_param(x)
  val res =
  list_vt_cons(strnptr2strptr(x), res)
in
  loop(ptr_add<char> (plen, len2), res)
end // end of [else]
//
end // end of [loop]
//
val res =
  loop(string2ptr(source), list_vt_nil(*void*))
//
in
  list_vt_reverse<Strptr1> (res)
end // end of [string_split_delim_string]

(* ****** ****** *)
//
extern
fun{}
array0_make_argv
  {n:int}
(
  argv: !argv(n), argc: int(n)
) :<!wrt> array0(string)
//
implement
{}(*tmp*)
array0_make_argv
  {n}(argv, argc) = let
//
prval () =
  lemma_argv_param (argv)
//
val n = g1int2uint_int_size(argc)
//
val A =
$effmask_all
(
arrayref_copy<string>
(
$UN.castvwtp1{arrayref(string,n)}(argv), n
)
) (* end of [val] *)
//
in
//
array0_make_arrayref(arrayptr_refize(A), n)
//
end // end of [array0_make_argv]
//
(* ****** ****** *)
//
extern
fun{}
cstream_make_stdin(): stream(int)
//
implement
{}(*tmp*)
cstream_make_stdin
  ((*void*)) =
(
(fix f(): stream(int) =>
  $delay(stream_cons($STDIO.getchar0(), f()))
)((*void*))
) (* end of [cstream_make_stdin] *)
//
(* ****** ****** *)
//
extern
fun{}
cstream_make_fileref
  (inp: FILEref): stream(int)
//
implement
{}(*tmp*)
cstream_make_fileref
  (inp) = aux(inp) where
{
//
fun
aux
(
 inp: FILEref
) : stream(int) = $delay
(
//
let
//
val c = $STDIO.fgetc0(inp)
//
in
//
if
(
c >= 0
)
then
(
  stream_cons(c, aux(inp))
) (* end of [then] *)
else
(
  stream_cons{int}(~1, aux2())
) (* end of [else] *)
//
end // end of [let]
//
) (* end of [$delay] *)
//
and
aux2(): stream(int) =
(
  $delay(stream_cons(~1, aux2()))
)
//
} (* end of [cstream_make_fileref] *)

(* ****** ****** *)

(* end of [BUCS320.dats] *)

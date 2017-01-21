(* ****** ****** *)
//
// API in ATS for PCRE
//
(* ****** ****** *)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"

(* ****** ****** *)

implement
{}(*tmp*)
pcre_match_string
  (code, subject) = let
//
val subject = g1ofg0(subject)
//
in
//
pcre_match_substring
  (code, subject, i2sz(0), length(subject))
//
end // end of [pcre_match_string]

(* ****** ****** *)

implement
{}(*tmp*)
pcre_match_substring
  {n}{st,ln}
(
  code, subject, st, ln
) = let
//
prval () = lemma_g1uint_param(st)
prval () = lemma_g1uint_param(ln)
//
val extra =
  $UN.castvwtp0{pcreptr_extra(null)}(0)
val subject2 =
  $UN.cast{arrayref(char, st+ln)}(subject)
val length = sz2i(st+ln) and startoffset = sz2i(st) and options = 0u
val ovector = $UN.cast{arrayref(int,0)}(0)
val ret =
  pcre_exec (code, extra, subject2, length, startoffset, options, ovector, 0)
prval ((*void*)) = pcre_free_study_null (extra)
//
in
  ret
end // end of [pcre_match_substring]

(* ****** ****** *)

implement
pcre_match2_substring
  {n}{st,ln}
(
  code, subject, st, ln
, matched_beg, matched_end
) = ret where
{
//
prval () = lemma_g1uint_param (st)
prval () = lemma_g1uint_param (ln)
//
val extra =
  $UN.castvwtp0{pcreptr_extra(null)}(0)
val subject2 =
  $UN.cast{arrayref(char, st+ln)}(subject)
val length = sz2i(st+ln)
val startoffset = sz2i(st)
val options = 0u
var int3 = @[int][48]() // HX: is [16] adequate?
val ovector = $UN.cast{arrayref(int,48)}(addr@int3)
val ret = pcre_exec
(
  code, extra, subject2, length, startoffset, options, ovector, 48
) (* end of [val] *)
prval ((*void*)) = pcre_free_study_null (extra)
//
val [n0:int] _beg =
(
  if ret >= 0 then $UN.cast{Int}(int3.[0]) else ~1
) : Int // end of [val]
val [n1:int] _end =
(
  if ret >= 0 then $UN.cast{Int}(int3.[1]) else ~1
) : Int // end of [val]
//
val () = matched_beg := _beg and () = matched_end := _end
prval (
) = __assert () where
{
  extern praxi __assert (): [n0 <= n1; n1 <= st+ln] void
} (* end of [prval] *)
//
} (* end of [pcre_match2_substring] *)

(* ****** ****** *)

local

#define BSZ 16
#define BSZ3 48

vtypedef
res_vt = List0_vt(Strptr0)

extern
fun
memcpy
(
  ptr, ptr, size_t
) : ptr = "mac#atscntrb_pcre_memcpy"
// end of [memcpy]

fun
auxlst
(
  subject: string
, p0: ptr, ret: int
) : res_vt = let
//
fun aux
(
  b: int, e: int
) : Strptr0 = let
//
val n = $UN.cast{Size}(e-b)
val n1 = g1uint_succ_size (n)
val (pf, pfgc | p) = malloc_gc (n1)
//
val p = memcpy(p, ptr_add<char>(string2ptr(subject), b), n)
//
val p_n = ptr_add<char> (p, n)
val ((*void*)) = $UN.ptr0_set<char> (p_n, '\000')
//
in
  $UN.castvwtp0((pf, pfgc | p))
end // end of [aux]
//
val ret1 =
(
if ret = 0
  then BSZ-1 else ret-1
) : int // end of [ret1]
val p2 = ptr_add<int> (p0, 2)
//
fun loop
(
  p: ptr, i: int, res: &ptr? >> res_vt
) : void =
  if i < ret1 then let
    val b = $UN.ptr0_get<int> (p)
    val p = ptr_succ<int> (p)
    val e = $UN.ptr0_get<int> (p)
    val p = ptr_succ<int> (p)
    val be = (
    if b >= 0
      then aux (b, e) else strptr_null ()
    // end of [if]
    ) : Strptr0 // end of [val]
    val () = res := list_vt_cons{Strptr0}{0}(be, _)
    val+list_vt_cons (_, res1) = res
    val ((*void*)) = loop (p, i+1, res1)
  in
    fold@ (res)
  end else (
    res := list_vt_nil(*void*)
  ) (* end of [if] *)
//
var res: ptr
val () = loop (p2, 0, res)
//
in
  res
end // end of [auxlst]

in (* in of [local] *)

implement
pcre_match3_substring
  {n}{st,ln}
(
  code, subject, st, ln
, matched_beg, matched_end, err
) = let
//
prval () = lemma_g1uint_param(st)
prval () = lemma_g1uint_param(ln)
//
val
extra =
$UN.castvwtp0{pcreptr_extra(null)}(0)
val
subject2 =
$UN.cast{arrayref(char, st+ln)}(subject)
//
val length = sz2i(st+ln)
val startoffset = sz2i(st)
val options = 0u
var int3 = @[int][BSZ3]() // HX: is [16] adequate?
val ovector = $UN.cast{arrayref(int,BSZ3)}(addr@int3)
val ret = pcre_exec
(
  code, extra, subject2, length, startoffset, options, ovector, BSZ3
) (* end of [val] *)
prval ((*void*)) = pcre_free_study_null (extra)
//
val () = err := ret
//
val [n0:int] _beg =
(
  if ret >= 0 then $UN.cast{Int}(int3.[0]) else ~1
) : Int // end of [val]
val [n1:int] _end =
(
  if ret >= 0 then $UN.cast{Int}(int3.[1]) else ~1
) : Int // end of [val]
//
val () = matched_beg := _beg and () = matched_end := _end
//
prval () =
__assert() where
{
  extern praxi __assert(): [n0 <= n1; n1 <= st+ln] void
} (* end of [prval] *)
//
in
  if ret >= 0 then auxlst(subject, addr@int3, ret) else list_vt_nil(*void*)
end // end of [pcre_match3_substring]

end // end of [local]

(* ****** ****** *)

(* end of [pcre.dats] *)

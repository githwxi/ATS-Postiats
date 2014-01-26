(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
STDLIB = "libc/SATS/stdlib.sats"
staload
_(*STDLIB*) = "libc/DATS/stdlib.dats"
//
(* ****** ****** *)

staload "./falcon_tokener.dats"

(* ****** ****** *)

extern
fun gene_read
  (inp: &string >> ptr): Strptr1
implement
gene_read (inp) = let
//
fun skipWS
  (p: ptr): ptr = let
  val c =
  $UN.ptr0_get<char> (p)
in
  if isspace (c) then skipWS (ptr_succ<char> (p)) else p
end // end of [skipWS]
//
fun skipID
  (p: ptr): ptr = let
  val c =
  $UN.ptr0_get<char> (p)
  val i = char2u2int0 (c)
in
  if i > 0 then
    if test_ide1 (i) then skipID (ptr_succ<char> (p)) else p
  else (p) // end of [if]
end // end of [skipID]
//
val p0 =
  string2ptr(inp)
//
val p1 = skipWS(p0)
val p2 = skipID(p1)
val () = inp := p2
//
val [ln:int] ln = $UN.cast{Size}(p2-p1)
//
val res =
string_make_substring
  ($UN.cast{stringGte(ln)}(p1), i2sz(0), ln)
prval () = lemma_strnptr_param (res)
//
in
  strnptr2strptr(res)
end // end of [gene_read]

(* ****** ****** *)

extern
fun mean_read (inp: &string >> ptr): double
implement
mean_read
  (inp) = let
  val str = inp
  prval () = topize (inp) in $STDLIB.strtod1 (str, inp)
end // end of [mean_read]

(* ****** ****** *)

extern
fun variance_read (inp: &string >> ptr): double
implement
variance_read
  (inp) = let
  val str = inp
  prval () = topize (inp) in $STDLIB.strtod1 (str, inp)
end // end of [variance_read]

(* ****** ****** *)

(* end of [falcon_gmeanvar.dats] *)

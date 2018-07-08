(* ****** ****** *)
(*
** For Simple Dynamic Strings:
** https://github.com/antirez/sds/
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

#define
ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
"./../SATS/sdstring.sats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

%{$
//
#include \
"atscntrb-hx-sdstring/H/sds.c"
//
%} // end of [%{$]

(* ****** ****** *)
//
implement
{}(*tmp*)
sdstring_get_at_int
  (sds, i) =
(
  sdstring_get_at_size(sds, i2sz(i))
)
//
implement
{}(*tmp*)
sdstring_get_at_size
  (sds, i) = let
//
val p0 = sdstring2ptr(sds)
//
in
//
if
p0 > 0
then let
  val n = sdslen(sds)
in
  if i < n then uchar2int0($UN.ptr0_get_at<uchar>(p0, i)) else ~1
end // end of [then]
else (~1) // end of [else]
//
end // end of [sdstring_get_at_size]
//
(* ****** ****** *)
//
implement
{}(*tmp*)
sdstring_set_at_int
  (sds, i, c) =
(
  sdstring_set_at_size(sds, i2sz(i), c)
)
//
implement
{}(*tmp*)
sdstring_set_at_size
  (sds, i, c) = let
//
val p0 = sdstring2ptr(sds)
//
in
//
if
p0 > 0
then let
  val n = sdslen(sds)
in
  if i < n
    then (
      let val () = $UN.ptr0_set_at<char>(p0, i, c) in 0 end
    ) (* end of [then] *)
    else (~1) // end of [else]
  // end of [if]
end // end of [then]
else (~1) // end of [else]
//
end // end of [sdstring_set_at_size]
//
(* ****** ****** *)

implement
{}(*tmp*)
sdstring_foreach
  (sds) = let
//
var env: void = () in sdstring_foreach_env<void> (sds, env)
//
end // end of [sdstring_foreach]

(* ****** ****** *)

implement
{env}(*tmp*)
sdstring_foreach_env
  (sds, env) = let
//
implement
array_foreach$cont<char><env>
  (x, env) = sdstring_foreach$cont(x, env)
implement
array_foreach$fwork<char><env>
  (x, env) = sdstring_foreach$fwork(x, env)
//
val p0 = sdstring2ptr(sds)
//
in
//
if
p0 > 0
then let
//
val n = sdslen(sds)
val [n:int] n = g1ofg0(n)
val
(pf, fpf | p) =
  $UN.ptr_vtake{array(char, n)}(p0)
//
val res = array_foreach_env<char><env> (!p, n, env)
//
prval () = fpf(pf)
//  
in
  res
end // end of [then]
else i2sz(0) // end of [else]
//
end // end of [sdstring_foreach_env]

(* ****** ****** *)
//
implement
{env}(*tmp*)
sdstring_foreach$cont(x, env) = true
//
(* ****** ****** *)

(* end of [sdstring.dats] *)

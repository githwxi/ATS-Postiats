(*
** For writing ATS code
** that translates into JavaScript
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

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: October, 2015
*)

(* ****** ****** *)

#define
ATS_STALOADFLAG 0 // no staloading at run-time
#define
ATS_EXTERN_PREFIX "ats2js_worker_" // prefix for external names

(* ****** ****** *)
//
staload
"./../../basics_js.sats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../../SATS/Worker/channel.sats"
//
(* ****** ****** *)
//
implement
chmsg_parse<int>(msg) = let
  val msg = $UN.cast{string}(msg)
in
  $extfcall(int, "parseInt", msg)
end // end of [chmsg_parse<int>]
//
implement
chmsg_parse<double>(msg) = let
  val msg = $UN.cast{string}(msg)
in
  $extfcall(double, "parseFloat", msg)
end // end of [chmsg_parse<double>]
//
(* ****** ****** *)

implement
chmsg_parse<bool>(msg) = $UN.cast{bool}(msg)

(* ****** ****** *)
//
implement
chmsg_parse<string>(msg) = $UN.cast{string}(msg)
//
(* ****** ****** *)

implement
(a:t@ype)
chmsg_parse<list0(a)>(msg) = let
//
fun
aux{n:nat}
(
  xs: list(chmsg(a), n)
) : list0(a) =
(
case+ xs of
//
| list_nil
    () => list0_nil()
  // list_nil
//
| list_cons
    (x, xs) => let
    val x =
      chmsg_parse<a>(x)
    // end of [val]
  in
    list0_cons(x, aux(xs))
  end // end of [list_cons]
//
)
//
in
  aux($UN.cast{List0(chmsg(a))}(msg))
end // end of [chmsg_parse<list0(a)>]

(* ****** ****** *)

implement
(a:t@ype
,b:t0ype)
chmsg_parse<$tup(a,b)>(msg) = let
//
val
msg =
$UN.cast{$tup(chmsg(a),chmsg(b))}(msg)
//
in
  $tup(chmsg_parse<a>(msg.0), chmsg_parse<b>(msg.1))
end // end of [chmsg_parse<$tup(a,b)>]

(* ****** ****** *)

implement
(a:t@ype
,b:t0ype
,c:t0ype)
chmsg_parse<$tup(a,b,c)>(msg) = let
//
val
msg =
$UN.cast{$tup(chmsg(a),chmsg(b),chmsg(c))}(msg)
//
in
  $tup(chmsg_parse<a>(msg.0), chmsg_parse<b>(msg.1), chmsg_parse<c>(msg.2))
end // end of [chmsg_parse<$tup(a,b,c)>]

(* ****** ****** *)

(* end of [channel.dats] *)

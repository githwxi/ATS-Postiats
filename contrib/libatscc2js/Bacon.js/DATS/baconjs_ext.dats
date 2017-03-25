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
** Start Time: October, 2015
** Authoremail: gmhwxiATgmailDOTcom
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0 // no run-time dynloading
//
#define
ATS_EXTERN_PREFIX
"ats2js_baconjs_ext_" // prefix for extern names
#define
ATS_STATIC_PREFIX
"_ats2js_baconjs_ext_" // prefix for static names
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
staload "./../SATS/baconjs.sats"
staload "./../SATS/baconjs_ext.sats"
//
(* ****** ****** *)
//
(*
fun
EStream_scan_stream_opt
  {a,b,c:t0p}
(
  xs: EStream(b)
, ini: a, ys: stream(c), fopr: cfun(a, b, c, Option_vt(a))
) : Property(a) = "mac#%" // end-of-function
*)
//
implement
EStream_scan_stream_opt
  {a,b,c}
  (xs, ini, ys, fopr) = let
//
val rys = ref{stream(c)}(ys)
//
val
fopr2 = lam
(
  ini: a, x: b
) : a =<cloref1> let
  val ys = rys[]
in
//
case+ !ys of
| stream_nil() => ini
| stream_cons(y, ys) => let
    val opt = fopr(ini, x, y)
  in
    case+ opt of
    | ~None_vt() => ini
    | ~Some_vt(ini) => (rys[] := ys; ini)
  end // end of [stream_cons]
//
end // end of [fopr2]
//
in
  EStream_scan(xs, ini, fopr2)
end // end of [EStream_scan_stream_opt]
//
(* ****** ****** *)
//
(*
fun
EValue_get_elt
  {a:t0p}
  (x: EValue(a)): (a) = "mac#%"
*)
implement
EValue_get_elt
  {a}(eval) =
  ref_get_elt($UN.cast{ref(a)}(eval))
//
(* ****** ****** *)
//
(*
fun
EValue_make_property
  {a:t0p}(Property(a)): EValue(a) = "mac#%"
*)
//
implement
EValue_make_property
  {a}(xs) = let
//
val x0 =
  $UN.cast{a}(0)
//
val
xref = ref{a}(x0)
//
val ((*void*)) =
Property_onValue
  (xs, lam(x) =<cloref1> xref[] := x)
//
in
  $UN.cast{EValue(a)}(xref)
end // end of [EValue_make_property]
  
(* ****** ****** *)
//
(*
fun
EValue_make_estream_scan
  {a,b:t0p}
(
  x0: a, ys: EStream(b), fopr: cfun(a, b, a)
) : EValue(a) = "mac#%" // end-of-fun
*)
//
implement
EValue_make_estream_scan
  {a,b}
(
  x0, ys, fopr
) = let
//
val
xref = ref{a}(x0)
//
val () =
EStream_onValue{b}(
  ys, lam(y) =<cloref1> xref[] := fopr(xref[], y)
) (* end of [val] *)
//
in
  $UN.cast{EValue(a)}(xref)
end // end of [EValue_make_estream_scan]

(* ****** ****** *)

local
//
datatype
tagged(a:t@ype+) =
  | Opening of (int, a) | Closing of (int)
//
in (* in-of-local *)

implement
EStream_singpair_trans
  {a}(xs, delta) = let
//
val x0 = $UN.cast{a}(0)
//
val
xs_tagged =
EStream_scan{tagged(a)}{a}
(
  xs
, Opening(0, x0)
, lam(res, x) =>
  let val-Opening(n, _) = res in Opening(n+1, x) end
) (* end of [EStream_scan] *)
val
xs_tagged = Property_changes(xs_tagged)
//
val
ys_tagged =
EStream_flatMap
{tagged(a)}{tagged(a)}
( xs_tagged
, lam x =>
  let val-Opening(n, _) = x in Bacon_later(delta(*ms*), Closing(n)) end
)
//
datatype
state(a:t0p) =
  | Issued of Option(singpair(a)) | Waiting of (int, a)
//
in
//
(
(
Property_changes
(
EStream_scan
{state(a)}{tagged(a)}
(
  merge
  (
    xs_tagged, ys_tagged
  )
, Issued(None()) // initial
, lam(state, tagged) =>
  (
    case+ state of
      | Issued(_) =>
        (
          case+
          tagged of
          | Closing(n) => Issued(None())
          | Opening(n, x) => Waiting(n, x)
        )
      | Waiting(n0, x0) =>
        (
          case+
          tagged of
          | Closing(n) =>
            if n < n0
              then state else Issued(Some(Sing(x0)))
            // end of [if]
          | Opening(_, x1) => Issued(Some(Pair(x0, x1)))
        )
    // end of [case+]
  )
)
)
).filter()
(
  lam(state) =>
    case+ state of Issued(opt) => opt.is_some() | _ => false
  // end of [lam]
)
).map(TYPE{singpair(a)})
(
  lam(state) =>
    case- state of Issued(opt) => (case- opt of Some(x) => x)
  // end of [lam]
)
//
end // end of [EStream_singpair_trans]

end // end of [local]

(* ****** ****** *)

(* end of [baconjs_ext.dats] *)

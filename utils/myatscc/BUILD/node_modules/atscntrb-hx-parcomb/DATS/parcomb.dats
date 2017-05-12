(*
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)
//
(*
** A parsing combinator library
*)
//
#define
ATS_PACKNAME "ATSCNTRB.HX.parcomb"
//
(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: January, 2015
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "./../SATS/parcomb.sats"

(* ****** ****** *)

typedef
pstate(t:t0p) = @{
//
  tstream= stream(t)
, ncur= int // current position
, nmax= int // maximal position ever reached
//
} (* end of [pstate] *)

(* ****** ****** *)
//
extern
fun{t:t0p}
pstate_get_token
  (st: &pstate(t) >> _): (t)
//
overload .tget with pstate_get_token
//
(* ****** ****** *)

implement
{t}(*tmp*)
pstate_get_token
  (st) = let
//
val ts = st.tstream
//
in
//
case+ !(ts) of
| stream_cons
    (t, ts) => t where
  {
    val n1 = st.ncur + 1
    val () = st.ncur := n1
    val () = if n1 > st.nmax then st.nmax := n1
    val () = st.tstream := ts
  } (* end of [stream_cons] *)
| stream_nil () => let
  in
    $raise TOKEN_NONE(*void*)
  end // end of [stream_nil]
//
end // end of [pstate_get_token]

(* ****** ****** *)
//
extern
fun
pstate_update
  {t:t0p}
(
  &pstate(t) >> _
, ts: stream(t), ncur: int
) : void // end-of-function
//
implement
pstate_update
  {t}(st, ts, ncur) = let
  val ts = $UN.cast{stream(t)}(ts)
in
  st.tstream := ts; st.ncur := ncur
end (* end of [pstate_update] *)
//
(* ****** ****** *)
//
assume
parser_type
  (t:t@ype, a:t@ype) =
  (&pstate(t) >> _) -<cloref1> (a)
//
(* ****** ****** *)

exception
PARFAIL of
(
  ptr(*tstream*), int(*ncur*), int(*nmax*)
) (* end of [PARFAIL] *)

(* ****** ****** *)
//
fun
{t:t0p}
{a:t0p}
parfail_raise
  (st: &pstate(t)): a =
  $raise PARFAIL($UN.cast{ptr}(st.tstream), st.ncur, st.nmax)
//
(* ****** ****** *)
//
implement
{a}
any_parser
  () = lam (st) => st.tget()
//
(* ****** ****** *)
//
implement
{t}{a}
ret_parser(x) = lam (st) => (x)
//
(* ****** ****** *)
//
implement
{t}{a}
sat_parser_fun
  (p0, ftest) = (
//
lam (st) => let
//
val x0 = p0 (st)
val test = ftest(x0)
//
in
//
if test
  then (x0) else parfail_raise<t><a>(st)
//
end // end of [end]
//
) (* end of [sat_parser_fun] *)
//
implement
{t}{a}
sat_parser_cloref
  (p0, ftest) = (
//
lam (st) => let
//
val x0 = p0 (st)
val test = ftest(x0)
//
in
//
if test
  then (x0) else parfail_raise<t><a>(st)
//
end // end of [end]
//
) (* end of [sat_parser_cloref] *)
//
(* ****** ****** *)

implement
{t}{a}
alt_parser_parser
  (p1, p2) = (
//
lam (st) => let
//
val stp = addr@st
//
val ts0 = st.tstream
val ncur0 = st.ncur
//
typedef pstate = pstate(t)
//
in
//
try let
val
(pf, fpf | stp) =
$UN.ptr_vtake{pstate}(stp)
val res = p1 (st)
prval ((*void*)) = fpf (pf)
//
in
  res
end with
| ~PARFAIL
    (ts, ncur, nmax) => let
    val
    (pf, fpf | stp) =
    $UN.ptr_vtake{pstate}(stp)
    val () = pstate_update (!stp, ts0, ncur0)
    val res = p2 (st)
    prval ((*void*)) = fpf (pf)
  in
    res
  end // end of [PARFAIL]
//
end // end of [lam]
//
) (* end of [alt_parser_parser] *)

(* ****** ****** *)

implement
{t}{a1,a2}
seq_parser_parser
  (p1, p2) = (
//
lam (st) => let
  val x1 = p1 (st)
  val x2 = p2 (st) in @(x1, x2)
end // end of [let]
//
) (* end of [seq_parser_parser] *)

(* ****** ****** *)

implement
{t}{a1,a2}
seq2_parser
  (p1, p2) = (
//
lam (st) => let
  val x1 = p1 (st)
  val x2 = p2 (st) in @(x1, x2)
end // end of [let]
//
) (* end of [seq2_parser] *)
implement
{t}(*tmp*)
{a1,a2,a3}
seq3_parser
  (p1, p2, p3) = (
//
lam (st) => let
  val x1 = p1 (st)
  val x2 = p2 (st)
  val x3 = p3 (st) in @(x1, x2, x3)
end // end of [let]
//
) (* end of [seq3_parser] *)

(* ****** ****** *)
//
implement
{t}{a,b}
seq1wth_parser_fun
  (p, fopr) =
  lam (st) =>
  let val x = p(st) in fopr(x) end
implement
{t}{a,b}
seq1wth_parser_cloref
  (p, fopr) =
  lam (st) =>
  let val x = p(st) in fopr(x) end
//
(* ****** ****** *)
//
implement
{t}{a1,a2,b}
seq2wth_parser_fun
  (p1, p2, fopr) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st) in fopr(x1, x2)
end // end of [seq2wth_parser_fun]
implement
{t}{a1,a2,b}
seq2wth_parser_cloref
  (p1, p2, fopr) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st) in fopr(x1, x2)
end // end of [seq2wth_parser_cloref]
//
(* ****** ****** *)
//
implement
{t}{a1,a2,a3,b}
seq3wth_parser_fun
(
  p1, p2, p3, fopr
) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st)
  val x3 = p3(st) in fopr(x1, x2, x3)
end // end of [seq3wth_parser_fun]
implement
{t}{a1,a2,a3,b}
seq3wth_parser_cloref
(
  p1, p2, p3, fopr
) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st)
  val x3 = p3(st) in fopr(x1, x2, x3)
end // end of [seq3wth_parser_cloref]
//
(* ****** ****** *)
//
implement
{t}{a1,a2,a3,a4,b}
seq4wth_parser_fun
(
  p1, p2, p3, p4, fopr
) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st)
  val x3 = p3(st)
  val x4 = p4(st) in fopr(x1, x2, x3, x4)
end // end of [seq4wth_parser_fun]
implement
{t}{a1,a2,a3,a4,b}
seq4wth_parser_cloref
(
  p1, p2, p3, p4, fopr
) =
lam (st) => let
  val x1 = p1(st)
  val x2 = p2(st)
  val x3 = p3(st)
  val x4 = p4(st) in fopr(x1, x2, x3, x4)
end // end of [seq4wth_parser_cloref]
//
(* ****** ****** *)
//
implement
{t}{a}
skip_parser(px) = let
  typedef b = unit
in
//
seq1wth_parser_fun<t><a,b>
  (px, lam x => unit(*void*))
//
end // end of [skip_parser]
//
implement
{t}{a}
skipall0_parser(px) = let
//
in
//
skipall1_parser<t><a>(px) ||
ret_parser<t><unit>(unit(*void*))
//
end // end of [list0_parser]
//
implement
{t}{a}
skipall1_parser(px) =
(
//
lam (st) => let
  val x = px(st)
  val py = skipall0_parser<t><a>(px) in py(st)
end // end of [let]
//
) (* end of [skipall1_parser] *)
//
(* ****** ****** *)

implement
{t}{a}
list0_parser(p0) = let
//
in
//
list1_parser<t><a>(p0) ||
ret_parser<t><List0(a)>(list_nil)
//
end // end of [list0_parser]

(* ****** ****** *)

implement
{t}{a}
list1_parser
  (p0) =
(
//
lam (st) => let
  val x = p0(st)
  val p1 = list0_parser<t><a>(p0)
  val xs = p1(st)
in
  list_cons(x, xs)
end // end of [let]
//
) (* end of [list1_parser] *)

(* ****** ****** *)
//
implement
{t}{a}
option_parser(p0) = let
//
typedef b = Option(a)
//
in
//
seq1wth_parser_fun<t><a,b>
  (p0, lam x => Some(x)) ||
ret_parser<t><b>(None((*void*)))
//
end // end of [option_parser]
//
(* ****** ****** *)
//
implement
{t}{a}
parser_unlazy
  (lpx) = lam (st) => (!lpx)(st)
//
(* ****** ****** *)

implement
{t}{a}
parser_apply_stream
(
parser, ts
) = parser(st) where
{
//
var st: pstate(t)
//
val () =
  st.tstream := ts
//
val () = st.ncur := 0
and () = st.nmax := 0
//
} (* end of [parser_apply_stream] *)

(* ****** ****** *)

implement
{t}{a}
parser_apply2_stream
(
parser, ts
) = (x0, ts) where
{
//
var st: pstate(t)
//
val () =
  st.tstream := ts
//
val () = st.ncur := 0
and () = st.nmax := 0
//
val x0 = parser(st)
val ts = st.tstream
//
} (* end of [parser_apply2_stream] *)

(* ****** ****** *)

(* end of [parcomb.dats] *)

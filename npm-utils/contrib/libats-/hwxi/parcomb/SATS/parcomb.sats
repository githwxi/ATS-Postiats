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
// Start time: February, 2014
//
(* ****** ****** *)
//
// HX:
// [parser(t,a)]
// returns a value of type [a]
// by consuming some tokens of type [t]
//
abstype
parser_type(t:t@ype, a:t@ype) = ptr
//
typedef
parser(t:t@ype, a:t@ype) = parser_type(t, a)
//
(* ****** ****** *)

symintr && ||

(* ****** ****** *)
//
(*
HX: out-of-tokens
*)
exception TOKEN_NONE of ()
//
(* ****** ****** *)

fun
{a:t0p}
any_parser(): parser(a, a)

(* ****** ****** *)

fun
{t:t0p}
{a:t0p}
ret_parser(x: a): parser(t, a)

(* ****** ****** *)

fun
{t:t0p}
{a:t0p}
sat_parser_fun
(
  parser(t, a)
, ftest: (a) -<fun1> bool
) : parser(t, a)
fun
{t:t0p}
{a:t0p}
sat_parser_cloref
(
  parser(t, a)
, ftest: (a) -<cloref1> bool
) : parser(t, a)

(* ****** ****** *)
//
fun
{t:t0p}
{a:t0p}
alt_parser_parser
(
  parser(t, a), parser(t, a)
) : parser(t, a) // end-of-fun
//
overload || with alt_parser_parser
//
(* ****** ****** *)
//
fun
{t:t0p}
{a1,a2:t0p}
seq_parser_parser
(
  parser(t, a1), parser(t, a2)
) : parser(t, (a1,a2)) // end-of-fun
//
overload && with seq_parser_parser
//
(* ****** ****** *)
//
fun
{t:t0p}
{a1
,a2:t0p}
seq2_parser
(
  parser(t, a1), parser(t, a2)
) : parser(t, (a1,a2)) // end-of-fun
fun
{t:t0p}
{a1
,a2
,a3:t0p}
seq3_parser
(
  parser(t, a1), parser(t, a2), parser(t, a3)
) : parser(t, (a1,a2,a3)) // end-of-fun
//
(* ****** ****** *)
//
fun
{t:t0p}
{a,b:t0p}
seq1wth_parser_fun
(
  p: parser(t, a)
, fopr: (a) -<fun1> b
) : parser(t, b) // end-of-function
fun
{t:t0p}
{a,b:t0p}
seq1wth_parser_cloref
(
  p: parser(t, a)
, fopr: (a) -<cloref1> b
) : parser(t, b) // end-of-function
//
fun
{t:t0p}
{a1,a2,b:t0p}
seq2wth_parser_fun
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, fopr: (a1, a2) -<fun1> b
) : parser(t, b) // end-of-function
fun
{t:t0p}
{a1,a2,b:t0p}
seq2wth_parser_cloref
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, fopr: (a1, a2) -<cloref1> b
) : parser(t, b) // end-of-function
//
fun
{t:t0p}
{a1,a2,a3,b:t0p}
seq3wth_parser_fun
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, p3: parser(t, a3)
, fopr: (a1, a2, a3) -<fun1> b
) : parser(t, b) // end-of-function
fun
{t:t0p}
{a1,a2,a3,b:t0p}
seq3wth_parser_cloref
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, p3: parser(t, a3)
, fopr: (a1, a2, a3) -<cloref1> b
) : parser(t, b) // end-of-function
//
fun
{t:t0p}
{a1,a2,a3,a4,b:t0p}
seq4wth_parser_fun
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, p3: parser(t, a3)
, p4: parser(t, a4)
, fopr: (a1, a2, a3, a4) -<fun1> b
) : parser(t, b) // end-of-function
fun
{t:t0p}
{a1,a2,a3,a4,b:t0p}
seq4wth_parser_cloref
(
  p1: parser(t, a1)
, p2: parser(t, a2)
, p3: parser(t, a3)
, p4: parser(t, a4)
, fopr: (a1, a2, a3, a4) -<cloref1> b
) : parser(t, b) // end-of-function
//
(* ****** ****** *)
//
fun
{t:t0p}
{a:t0p}
skip_parser
  (p0: parser(t, a)): parser(t, unit)
//
fun
{t:t0p}
{a:t0p}
skipall0_parser
  (p0: parser(t, a)): parser(t, unit)
//
fun
{t:t0p}
{a:t0p}
skipall1_parser
  (p0: parser(t, a)): parser(t, unit)
//
(* ****** ****** *)
//
fun
{t:t0p}
{a:t0p}
list0_parser
  (p0: parser(t, a)): parser(t, List0(a))
//
fun
{t:t0p}
{a:t0p}
list1_parser
  (p0: parser(t, a)): parser(t, List1(a))
//
fun
{t:t0p}
{a:t0p}
option_parser
  (p0: parser(t, a)): parser(t, Option(a))
//
(* ****** ****** *)
//
fun
{t:t@ype}
{a:t@ype}
parser_unlazy
  (lpx: lazy(parser(t, a))): parser(t, a)
//
(* ****** ****** *)
//
fun
{t:t0p}
{a:t0p}
parser_apply_stream(parser(t, a), stream(t)): (a)
//
fun
{t:t0p}
{a:t0p}
parser_apply2_stream
  (parser: parser(t, a), ts: stream(t)): (a, stream(t))
//
(* ****** ****** *)

(* end of [parcomb.sats] *)

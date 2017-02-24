(*
** HX-2016-11-27:
** Parsing combinators for libatscc
*)

(* ****** ****** *)
//
(*
staload
"./../SATS/parcomb.sats"
*)
//
(* ****** ****** *)
//
(*
staload
UN =
"prelude/SATS/unsafe.sats"
*)
//
(* ****** ****** *)
//
implement
parser_fail() =
  lam(inp) => PAROUT(None(), inp)
//
(* ****** ****** *)
//
implement
parser_succeed(x0) =
  lam(inp) => PAROUT(Some(x0), inp)
//
(* ****** ****** *)
//
implement
parser_anyone
  {a}() = lam(xs0) =>
(
  case+ !xs0 of
  | stream_nil() =>
    PAROUT(None{a}(), xs0)
  | stream_cons(x1, xs1) =>
    PAROUT(Some{a}(x1), xs1)
) (* end of [parse_anyone] *)
//
(* ****** ****** *)
//
implement
parser_satisfy
  {a}(pred) = lam(xs0) =>
(
  case+ !xs0 of
  | stream_nil() =>
    PAROUT(None{a}(), xs0)
  | stream_cons(x1, xs1) =>
    if pred(x1)
      then PAROUT(Some(x1), xs1)
      else PAROUT(None{a}(), xs0)
    // end of [if[
) (* end of [parse_satisfy] *)
//
(* ****** ****** *)

implement
parser_map
{a}{t}{u}
(
  p0, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p0(inp0)
//
in
  case+ opt of
  | None() =>
    PAROUT(None{u}(), inp0)
  | Some(x) =>
    PAROUT(Some(fopr(x)), inp1)
end // end of [parser_map]

(* ****** ****** *)

implement
parser_map2
{a}{t1,t2}{u3}
(
p1, p2, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{u3}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{u3}(), inp0)
    | Some(x2) =>
      PAROUT(Some(fopr(x1, x2)), inp2)
  end // end of [Some]
//
end // end of [parser_map2]

(* ****** ****** *)

implement
parser_map3
{a}{t1,t2,t3}{u4}
(
p1, p2, p3, fopr
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{u4}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{u4}(), inp0)
    | Some(x2) => let
        val+
        PAROUT(opt, inp3) = p3(inp2)
      in
        case+ opt of
        | None() =>
          PAROUT(None{u4}(), inp0)
        | Some(x3) =>
          PAROUT(Some(fopr(x1, x2, x3)), inp3)
      end
  end // end of [Some]
//
end // end of [parser_map3]

(* ****** ****** *)

implement
parser_join2
{a}{t1,t2}
  (p1, p2) = lam(inp0) => let
//
typedef t12 = $tup(t1, t2)
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t12}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t12}(), inp0)
    | Some(x2) =>
      PAROUT(Some($tup(x1, x2)), inp2)
  end // end of [Some]
//
end // end of [parser_join2]

(* ****** ****** *)

implement
parser_tup2_fst
{a}{t1,t2}
(
  p1, p2
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t1}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t1}(), inp0)
    | Some(x2) =>
      PAROUT(Some{t1}(x1), inp2)
  end // end of [Some]
//
end // end of [parser_tup2_fst]

(* ****** ****** *)

implement
parser_tup2_snd
{a}{t1,t2}
(
  p1, p2
) = lam(inp0) => let
//
val+
PAROUT(opt, inp1) = p1(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{t2}(), inp0)
  // end of [None_vt]
| Some(x1) => let
    val+
    PAROUT(opt, inp2) = p2(inp1)
  in
    case+ opt of
    | None() =>
      PAROUT(None{t2}(), inp0)
    | Some(x2) =>
      PAROUT(Some{t2}(x2), inp2)
  end // end of [Some]
//
end // end of [parser_tup2_snd]

(* ****** ****** *)

implement
parser_orelse
  {a}{t}
(
  p1, p2
) = lam(inp0) => let
//
val out = p1(inp0)
val+PAROUT(opt, inp1) = out
//
in
//
case+ opt of
| Some _ => out | None _ => p2(inp0)
//
end // end of [parser_orelse]

(* ****** ****** *)

implement
parser_repeat0
  {a}{t}
  (p0) = lam(inp0) => let
//
fun
auxlst
(
  inp: parinp(a), xs: List0_vt(t)
) : parout(a, list0(t)) = let
//
val+PAROUT(opt, inp) = p0(inp)
//
in
  case+ opt of
  | None() => let
      val xs = list_vt_reverse(xs)
    in
      PAROUT(Some(g0ofg1(xs)), inp)
    end // end of [None_vt]
  | Some(x) => auxlst(inp, list_vt_cons(x, xs))
end // end of [auxlst]
//
in
  auxlst(inp0, list_vt_nil((*void*)))
end // end of [parse_repeat0]

(* ****** ****** *)

implement
parser_repeat1
  {a}{t}
  (p0) = lam(inp0) => let
//
typedef ts = list0(t)
//
val+
PAROUT(opt, inp1) = p0(inp0)
//
in
//
case+ opt of
| None() =>
    PAROUT(None{ts}(), inp0)
  // end of [None_vt]
| Some(x) => let
    val+
    PAROUT
    (opt, inp2) =
    parser_repeat0(p0)(inp1)
    val-Some(xs) = opt
  in
    PAROUT(Some(list0_cons(x, xs)), inp2)
  end // end of [Some]
//
end // end of [parse_repeat1]

(* ****** ****** *)
//
implement
parser_lazy(lp) = lam(inp0) => (!lp)(inp0)
//
(* ****** ****** *)

(* end of [parcomb.dats] *)

(*
** HX-2016-11-27:
** Parsing combinators
** for libatscc-common
*)

(* ****** ****** *)
//
(*
#define
ATS_PACKNAME "BUCS320.parcomb"
*)
//
(* ****** ****** *)
//
typedef parinp(a:t@ype) = stream(a)
//
(* ****** ****** *)
//
datatype parout
  (a:t@ype, res:t@ype) =
  | PAROUT of (Option(res), parinp(a))
//
(* ****** ****** *)

typedef
parser(
  a:t@ype, res:t@ype
) = parinp(a) -<cloref1> parout(a, res)

(* ****** ****** *)
//
fun
parser_fail
  {a:t@ype}
  {t:t@ype}(): parser(a, t) = "mac#%"
fun
parser_succeed
  {a:t@ype}
  {t:t@ype}(x0: t): parser(a, t) = "mac#%"
//
(* ****** ****** *)
//
fun
parser_anyone
  {a:t@ype}((*void*)): parser(a, a) = "mac#%"
//
(* ****** ****** *)
//
fun
parser_satisfy
  {a:t@ype}
  (pred: cfun(a, bool)): parser(a, a) = "mac#%"
//
(* ****** ****** *)
//
fun
parser_join2
  {a:t@ype}
  {t1,t2:t@ype}
(
p1: parser(a, t1),
p2: parser(a, t2)
) : parser(a, $tup(t1, t2)) = "mac#%" // end-of-fun
//
fun
parser_join3
  {a:t@ype}
  {t1,t2,t3:t@ype}
(
p1: parser(a, t1),
p2: parser(a, t2),
p3: parser(a, t3)
) : parser(a, $tup(t1, t2, t3)) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
parser_tup2_fst
  {a:t@ype}
  {t1,t2:t@ype}
(
p1: parser(a, t1), p2: parser(a, t2)
) : parser(a, t1) = "mac#%" // end-of-function
fun
parser_tup2_snd
  {a:t@ype}
  {t1,t2:t@ype}
(
p1: parser(a, t1), p2: parser(a, t2)
) : parser(a, t2) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
parser_map
  {a:t@ype}
  {t:t@ype}{u:t@ype}
(
p0: parser(a, t), fopr: (t) -<cloref1> u
) : parser(a, u) = "mac#%" // end-of-fun
//
fun
parser_map2
  {a:t@ype}
  {t1,t2:t@ype}{u3:t@ype}
(
p1: parser(a, t1),
p2: parser(a, t2), fopr: (t1, t2) -<cloref1> u3
) : parser(a, u3) = "mac#%" // end-of-fun
fun
parser_map3
  {a:t@ype}
  {t1,t2,t3:t@ype}{u4:t@ype}
(
p1: parser(a, t1),
p2: parser(a, t2), 
p3: parser(a, t3), fopr: (t1, t2, t3) -<cloref1> u4
) : parser(a, u4) = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
parser_orelse
  {a:t@ype}{t:t@ype}
(
p1: parser(a, t), p2: parser(a, t)
) : parser(a, t) = "mac#%" // end-of-function
//
(* ****** ****** *)
//
fun
parser_repeat0
  {a:t@ype}
  {t:t@ype}
  (parser(a, t)): parser(a, list0(t)) = "mac#%"
//
(* ****** ****** *)
//
fun
parser_repeat1
  {a:t@ype}
  {t:t@ype}
  (parser(a, t)): parser(a, list0(t)) = "mac#%"
//
(* ****** ****** *)
//
fun
parser_lazy
  {a:t@ype}
  {t:t@ype}
  (lp: lazy(parser(a, t))): parser(a, t) = "mac#%"
//
(* ****** ****** *)

(* end of [parcomb.sats] *)

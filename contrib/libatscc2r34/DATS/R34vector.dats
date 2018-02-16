(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
#define
ATS_STATIC_PREFIX "_ats2r34pre_R34vector_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../basics_r34.sats"
//
staload "./../SATS/R34vector.sats"
//
(* ****** ****** *)
//
implement
R34vector_mean<int>
  (xs) = $extfcall(double, "mean", xs)
implement
R34vector_mean<double>
  (xs) = $extfcall(double, "mean", xs)
//
(* ****** ****** *)
//
implement
R34vector_variance<int>
  (xs) = $extfcall( double, "var", xs )
implement
R34vector_variance<double>
  (xs) = $extfcall( double, "var", xs )
//
(* ****** ****** *)
//
implement
R34vector_median<int>
  (xs) = $extfcall(double, "stats::median", xs)
implement
R34vector_median<double>
  (xs) = $extfcall(double, "stats::median", xs)
//
(* ****** ****** *)
//
implement
R34vector_map_cloref
{a}{b}
(xs, fopr) =
R34vector_map_fun{a}{b}(xs, cloref2fun1(fopr))
//
(* ****** ****** *)
//
implement
R34vector_foreach_cloref
{a}(*tmp*)
(xs, fopr) =
R34vector_foreach_fun{a}(xs, cloref2fun1(fopr))
implement
R34vector_iforeach_cloref
{a}(*tmp*)
(xs, fopr) =
R34vector_iforeach_fun{a}(xs, cloref2fun2(fopr))
//
(* ****** ****** *)
//
implement
R34vector_foldleft_cloref
{r}{a}
(xs, init, fopr) =
R34vector_foldleft_fun{r}{a}(xs, init, cloref2fun2(fopr))
//
(* ****** ****** *)
//
implement
R34vector_tabulate_cloref
{a}(*tmp*)
(n0, fopr) =
R34vector_tabulate_fun{a}(n0, cloref2fun1(fopr))
//
implement
R34vector_tabulate2_cloref
{a}(*tmp*)
(n0, x0, fopr) =
R34vector_tabulate2_fun{a}(n0, x0, cloref2fun2(fopr))
//
(* ****** ****** *)

(* end of [R34vector.dats] *)

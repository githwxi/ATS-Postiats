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
ATS_STATIC_PREFIX "_ats2r34pre_R34matrix_"
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
staload "./../SATS/R34matrix.sats"
//
(* ****** ****** *)
//
implement
R34matrix_tabulate_cloref
{a}(*tmp*)
(m0, n0, fopr) =
R34matrix_tabulate_fun{a}(m0, n0, cloref2fun2(fopr))
//
(* ****** ****** *)

(* end of [R34matrix.dats] *)

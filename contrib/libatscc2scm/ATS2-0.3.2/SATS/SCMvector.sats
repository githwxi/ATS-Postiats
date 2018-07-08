(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2016-06:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
staload "./../basics_scm.sats"
//
(* ****** ****** *)
//
fun
SCMvector_make_elt
  {a:t0p}{n:nat}
  (n: int(n), x0: a): SCMvector(a) = "mac#"
//
(* ****** ****** *)
//
fun
SCMlist_vector
  {a:vt0p}(SCMvector(a)): intGte(0) = "mac#"
//
(* ****** ****** *)
//
fun
SCMvector_get_at
  {a:t0p}(xs: SCMvector(a), i: int): a = "mac#"
fun
SCMvector_set_at
  {a:t0p}(xs: SCMvector(a), i: int, x0: a): void = "mac#"
//
fun
SCMvector_exch_at
  {a:vt0p}(xs: SCMvector(a), i: int, x0: a): (a) = "mac#"
//
(* ****** ****** *)

(* end of [SCMvector.sats] *)

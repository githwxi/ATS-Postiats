(*
** reference-counted abstract syntax tree
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/refcount.sats"
//
(* ****** ****** *)

datavtype
exp_node =
  | EXPnum of double
  | EXPadd of (exp, exp)
  | EXPsub of (exp, exp)
// end of [exp_node]

where exp = refcnt (exp_node)

(* ****** ****** *)

extern
fun copy_exp (!exp): exp
implement
copy_exp (e0) = refcnt_incref (e0)

(* ****** ****** *)

extern
fun free_exp (exp): void
extern
fun free_exp_node (exp_node): void

(* ****** ****** *)

implement
free_exp (e0) = let
  val opt = refcnt_decref_opt (e0)
in
  case+ opt of
  | ~None_vt () => ()
  | ~Some_vt (en) => free_exp_node (en)
end // end of [free_exp]

implement
free_exp_node (en) =
(
case+ en of
| ~EXPnum (x) => ()
| ~EXPadd (e1, e2) => (free_exp (e1); free_exp (e2))
| ~EXPsub (e1, e2) => (free_exp (e1); free_exp (e2))
)

(* ****** ****** *)

extern
fun eval_exp (!exp): double
extern
fun eval_exp_node (!exp_node): double

(* ****** ****** *)

implement
eval_exp
  (e0) = res where
{
  val (
    pf, fpf | p
  ) = refcnt_vtakeout (e0)
  val res = eval_exp_node (!p)
  prval () = fpf (pf)
} (* end of [eval_exp] *)

(* ****** ****** *)

implement
eval_exp_node (en) =
(
case+ en of
| EXPnum (x) => x
| EXPadd (e1, e2) => eval_exp (e1) + eval_exp (e2)
| EXPsub (e1, e2) => eval_exp (e1) - eval_exp (e2)
) (* end of [eval_exp_node] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [calc_refcount.dats] *)

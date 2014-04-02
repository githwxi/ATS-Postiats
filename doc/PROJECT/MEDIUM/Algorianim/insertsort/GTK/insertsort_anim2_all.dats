(*
** HX-2014-04-03:
** all-in-one version of insertsort_anim2
*)

staload insertsort =
{
#include "./../insertsort.dats"
}
staload
gtkcairotimer_toplevel =
{
#include "./gtkcairotimer_toplevel.dats"
}
staload
insertsort_anim2 =
{
#define INSERTSORT_ANIM2_ALL; #include "./insertsort_anim2.dats"
}

(* ****** ****** *)

(* end of [insertsort_anim2_all.dats] *)

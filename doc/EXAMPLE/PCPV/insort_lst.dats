(*
** Author: Hongwei Xi
** Ahthoremail: hwxiATcsDOTbuDOTedu
** Time: February 13, 2016
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
staload "libats/SATS/gflist.sats"
//
(* ****** ****** *)
//
typedef
cmp(a:t@ype) = cmpval_fun (a)
//
(* ****** ****** *)

extern
fun{a:t@ype}
insort_lst{xs:ilist}
(
  gflist (a, xs), cmp(a)
) : gflist (a, ilist_sort(xs))

(* ****** ****** *)
//
stacst
ilist_insord: (ilist, int) -> ilist
//
(* ****** ****** *)
//
extern
fun{a:t@ype}
insord
{xs:ilist}{x0:int}
(
  gflist(a, xs), stamped_t(a, x0), cmp: cmp(a)
) : gflist(a, ilist_insord(xs, x0))
//
(* ****** ****** *)

extern
praxi
lemma_insord_sort
{xs:ilist}{x0:int}
(
// argumentless
) : ILISTEQ(ilist_sort(ilist_cons(x0, xs)), ilist_insord(ilist_sort(xs), x0))

(* ****** ****** *)

implement
{a}(*tmp*)
insort_lst{xs:ilist}
  (xs, cmp) = let
//
// HX: 
//
in
//
case+ xs of
| gflist_nil
    {a}((*void*)) => let
    prval
    ILISTEQ() =
    $UN.proof_assert{ILISTEQ(ilist_nil(),ilist_sort(ilist_nil()))}() in xs
  end // end of [gflist_nil]
| gflist_cons
    {a}{x1}{xs1}(x1, xs1) => let
    prval
    ILISTEQ() = lemma_insord_sort{xs1}{x1}() in insord(insort_lst(xs1, cmp), x1, cmp)
  end // end of [gflist_cons]
//
end // end of [insort_lst]

(* ****** ****** *)

(* end of [insort_lst.dat] *)

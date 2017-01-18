(* ****** ****** *)
//
// HX-2015-06:
// list insertion sort
// for testing patsolve-z3
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "{$EXTSOLVE}/SATS/ilist.sats"
staload "{$EXTSOLVE}/SATS/gflist.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
prval () = $solver_assert(lemma_length_0)
(*
prval () = $solver_assert(lemma_length_1)
*)
prval () = $solver_assert(lemma_length_isnat)
//
(* ****** ****** *)
//
stacst isord : (ilist) -> bool
stacst sort2 : (ilist, ilist) -> bool
//
(* ****** ****** *)
//
extern
praxi
lemma_sort2_isord
  {xs,ys:ilist|sort2(xs,ys)}(): [isord(ys)] unit_p
//
(* ****** ****** *)

prval () = $solver_assert(lemma_sort2_isord)

(* ****** ****** *)
//
absprop
SORT2_prop(ilist, ilist)
//
stadef SORT2 = SORT2_prop
//
extern
praxi
lemma_sort2_intr
  {xs,ys:ilist | sort2(xs, ys)}(): SORT2(xs, ys)
extern
praxi
lemma_sort2_elim
  {xs,ys:ilist}(SORT2(xs, ys)): [sort2(xs, ys)] unit_p
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
gflist_insort{xs:ilist}
  (gflist(a, xs)): [ys:ilist | sort2(xs, ys)] gflist(a, ys)
//
(* ****** ****** *)

extern
fun{a:t@ype}
gflist_insort$cmp
  {x1,x2:int}
  (x1: stamped_t (a, x1), x2: stamped_t (a, x2)): int(sgn(x1-x2))
//
(* ****** ****** *)

implement
{a}(*tmp*)
gflist_insort
  (xs) = let
//
fun
insord
{xs:ilist|isord(xs)}{x0:elt}
(
  xs: gflist(a, xs)
, x0: stamped_t(a, x0)
) :
[ ys:ilist
| sort2(cons(x0, xs), ys)
] gflist(a, ys) = let
//
prval () =
$UN.prop_assert
  {sort2(cons(x0,nil), cons(x0,nil))}()
//
in
//
case+ xs of
| gflist_nil() =>
    gflist_cons(x0, gflist_nil())
| gflist_cons
    {a}{x1}{xs2}(x1, xs2) => let
    val sgn = gflist_insort$cmp(x0, x1)
    prval () = $UN.prop_assert{isord(xs2)}()
  in
    if sgn <= 0
      then let
        prval () =
        $UN.prop_assert{(x0 <= x1) <= sort2(cons(x0,xs),cons(x0,xs))}()
      in
        gflist_cons(x0, xs)
      end // end of [then]
      else let
        val [ys:ilist] ys = insord(xs2, x0)
        prval () =
        $UN.prop_assert{sort2(cons(x0,xs2),ys) <= ((x1 < x0 && isord(xs)) <= sort2(cons(x0,xs),cons(x1,ys)))}()
      in
        gflist_cons(x1, ys)
      end // end of [else]
    // end of [if]
  end // end of [gflist_cons]
//
end // end of [insord]
//
prval () = $UN.prop_assert{sort2(nil, nil)}()
//
fun
insort
{xs:ilist}
.<length(xs)>.
(
  xs: gflist(a, xs)
) : [ys:ilist | sort2(xs, ys)] gflist(a, ys) =
(
case+ xs of
| gflist_nil
    ((*void*)) => gflist_nil()
| gflist_cons
    {..}{x1}{xs2}(x1, xs2) => let
    prval
    unit_p() =
    lemma_length_1{x1}{xs2}()
    val [ys2:ilist] ys2 = insort{xs2}(xs2)
    val [ys_res:ilist] ys_res = insord(ys2, x1)
    prval () =
    $UN.prop_assert
      {sort2(cons(x1,ys2), ys_res) <= sort2(cons(x1,xs2), ys_res)}()
    // end of [prval]
  in
    ys_res
  end // end of [gflist_cons]
) (* end of [insort] *)
//
in
  insort(xs)
end // end of [gflist_insort]

(* ****** ****** *)

(* end of [gflist_insort.dats] *)

(*
** A verified implementation of quicksort on lists
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December 26, 2010
*)

(* ****** ****** *)

(*
** HX-2013-03-22: ported to ATS/Postiats
*)

(* ****** ****** *)

typedef cmp (a:t@ype) = cmpval_fun (a)

(* ****** ****** *)

(*
//
// HX: A standard implementation of list-quicksort
//
extern
fun{a:t@ype}
quicksort_lst{n:nat}
  (xs: list (a, n), cmp: cmp a) :<> list (a, n)
//
//
extern
fun{a:t@ype}
list_append{m,n:nat}
  (xs1: list (a, m), xs2: list (a, n)):<> list (a, m+n)
//
fun{a:t@ype}
sort{n:nat} .<n, 0, 0>.
(
  xs: list (a, n), cmp: cmp(a)
) :<> list (a, n) = let
in
//
case+ xs of
| list_cons
    (x, xs) => part (x, xs, cmp, list_nil (), list_nil ())
| list_nil () => list_nil ()
//
end // end of [sort]

and part{p:nat}{q,r:nat} .<p+q+r, 1, p>.
(
  x0: a, xs: list (a, p), cmp: cmp(a), ys: list (a, q), zs: list (a, r)
) :<> list (a, p+q+r+1) = let
in
//
case+ xs of
| list_cons
    (x, xs) =>
  (
    if cmp (x, x0) <= 0 then
      part (x0, xs, cmp, list_cons (x, ys), zs)
    else
      part (x0, xs, cmp, ys, list_cons (x, zs))
    // end of [if]
  )
| list_nil () => let
    val ys = sort (ys, cmp) and zs = sort (zs, cmp)
  in
    list_append (ys, list_cons (x0, zs))
  end // end of [list_nil]
//
end // end of [part]
*)
(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats"
stadef nil = ilist_nil and cons = ilist_cons

(* ****** ****** *)

staload "libats/SATS/gflist.sats"


(* ****** ****** *)

macdef nil () = gflist_nil ()
macdef cons (x, xs) = gflist_cons (,(x), ,(xs))
macdef append = gflist_append

(* ****** ****** *)

typedef
compare (a:t@ype) =
  {x1,x2:int} (stamped_t (a, x1), stamped_t (a, x2)) -> int (x1-x2)
typedef cmp (a:t@ype) = compare (a)

(* ****** ****** *)

absprop SORT (xs: ilist, ys: ilist) // [ys] is sorted version of [xs]

(* ****** ****** *)

extern
fun{a:t@ype}
quicksort_lst{xs:ilist}
(
  xs: gflist (a, xs), cmp: cmp a
) : [ys:ilist]
(
  SORT (xs, ys) | gflist (a, ys)
) // end of [quicksort_lst]

(* ****** ****** *)

absprop LB (x:int, xs:ilist)
absprop UB (x:int, xs:ilist)
absprop UNION4 (x:int, xs:ilist, ys:ilist, zs:ilist, res:ilist)

(* ****** ****** *)

stadef ORD = ISORD
stadef PERM = PERMUTE

(* ****** ****** *)

extern
prfun SORT2ORD {xs,ys:ilist} (pf: SORT(xs, ys)): ORD (ys)

extern
prfun SORT2PERM {xs,ys:ilist} (pf: SORT(xs, ys)): PERM (xs, ys)

extern
prfun ORDPERM2SORT
  {xs,ys:ilist} (pf1: ORD (ys), pf2: PERM (xs, ys)): SORT (xs, ys)
// end of [ORDPERM2SORT]

(* ****** ****** *)

extern
prfun
SORT_nil (): SORT (nil, nil)
extern
prfun
SORT_sing {x:int} (): SORT(cons(x, nil), cons(x, nil))

(* ****** ****** *)

extern prfun LB_nil {x:int} (): LB (x, nil)
extern prfun UB_nil {x:int} (): UB (x, nil)

(* ****** ****** *)
//
extern
prfun
LB_cons{x0:int}
  {x:int | x0 <= x}
  {xs:ilist}(pf: LB (x0, xs)): LB (x0, cons (x, xs))
extern
prfun
UB_cons{x0:int}
  {x:int | x0 >= x}
  {xs:ilist}(pf: UB (x0, xs)): UB (x0, cons (x, xs))
//
extern
prfun
LB_perm{x:int}{xs1,xs2:ilist} 
  (pf1: PERM (xs1, xs2), pf2: LB (x, xs1)): LB (x, xs2)
extern
prfun
UB_perm{x:int}{xs1,xs2:ilist} 
  (pf1: PERM (xs1, xs2), pf2: UB (x, xs1)): UB (x, xs2)
//
(* ****** ****** *)
//
extern
prfun
UNION4_perm{x:int}{xs:ilist}{res:ilist}
  (pf: UNION4 (x, xs, nil, nil, res)): PERM (cons (x, xs), res)
//
extern
prfun
UNION4_mov1
  {x0:int}{x:int}{xs:ilist}{ys,zs:ilist}{res:ilist}
  (pf: UNION4 (x0, xs, cons (x, ys), zs, res)): UNION4 (x0, cons (x, xs), ys, zs, res)
extern
prfun
UNION4_mov2
  {x0:int}{x:int}{xs:ilist}{ys,zs:ilist}{res:ilist}
  (pf: UNION4 (x0, xs, ys, cons (x, zs), res)): UNION4 (x0, cons (x, xs), ys, zs, res)
//
(* ****** ****** *)
//
extern
prfun
APPEND_ord
  {x:int}
  {ys,zs:ilist}
  {res:ilist} (
  pf1: UB (x, ys), pf2: LB (x, zs)
, pf3: ORD (ys), pf4: ORD (zs)
, pf5: APPEND (ys, cons (x, zs), res)
) : ORD (res)
//
extern
prfun
APPEND_union4
  {x:int}
  {ys,ys1:ilist}
  {zs,zs1:ilist}
  {res:ilist} (
  pf1: PERM (ys, ys1), pf2: PERM (zs, zs1), pf3: APPEND (ys1, cons (x, zs1), res)
) : UNION4 (x, nil, ys, zs, res)
//
(* ****** ****** *)

fun
{a:t0p}
sort
{xs:ilist}
(
  xs: gflist (a, xs), cmp: cmp a
) : [ys:ilist] (SORT (xs, ys) | gflist (a, ys)) =
  case+ xs of
  | gflist_cons (x, xs) => let
      val (pford, pfuni | res) = part (UB_nil (), LB_nil () | x, xs, cmp, nil (), nil ())
      prval pfperm = UNION4_perm (pfuni)
    in
      (ORDPERM2SORT (pford, pfperm) | res)
    end // end of [gflist_cons]
  | gflist_nil () => (SORT_nil () | nil ())
// end of [sort]

and
part
{x0:int}
{xs:ilist}
{ys,zs:ilist}
(
  pf1: UB (x0, ys), pf2: LB (x0, zs)
| x0: stamped_t (a, x0), xs: gflist (a, xs)
, cmp: cmp(a), ys: gflist (a, ys), zs: gflist (a, zs)
) : [res:ilist]
(
  ORD (res), UNION4 (x0, xs, ys, zs, res) | gflist (a, res)
) =
  case+ xs of
  | gflist_cons (x, xs) =>
      if cmp (x, x0) <= 0 then let
        prval pf1 = UB_cons (pf1)
        val (pford, pfuni | res) = part (pf1, pf2 | x0, xs, cmp, cons (x, ys), zs)
        prval pfuni = UNION4_mov1 (pfuni)
      in
        (pford, pfuni | res)
      end else let
        prval pf2 = LB_cons (pf2)
        val (pford, pfuni | res) = part (pf1, pf2 | x0, xs, cmp, ys, cons (x, zs))
        prval pfuni = UNION4_mov2 (pfuni)
      in
        (pford, pfuni | res)
      end // end of [if]        
    // end of [gflist_cons]
  | gflist_nil () => let
      val (pfsrt1 | ys) = sort (ys, cmp)
      val (pfsrt2 | zs) = sort (zs, cmp)
      val (pfapp | res) = append (ys, cons (x0, zs))
      prval pford1 = SORT2ORD (pfsrt1)
      prval pford2 = SORT2ORD (pfsrt2)
      prval pfperm1 = SORT2PERM (pfsrt1)
      prval pfperm2 = SORT2PERM (pfsrt2)
      prval pf1 = UB_perm (pfperm1, pf1)
      prval pf2 = LB_perm (pfperm2, pf2)
      prval pford = APPEND_ord (pf1, pf2, pford1, pford2, pfapp)
      prval pfuni = APPEND_union4 (pfperm1, pfperm2, pfapp)
    in
      (pford, pfuni | res)
    end // end of [gflist_nil]
// end of [part]

(* ****** ****** *)

implement{a} quicksort_lst = sort<a>

(* ****** ****** *)

(* end of [quicksort_lst.dat] *)

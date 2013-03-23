(*
** A verified implementation of binary search
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January 1, 2011
*)

(* ****** ****** *)

(*
** HX-2013-03-22: ported to ATS/Postiats
*)

(* ****** ****** *)

staload "libats/SATS/ilist_prf.sats"
stadef nil = ilist_nil and cons = ilist_cons

(* ****** ****** *)

staload "libats/SATS/gfarray.sats"

(* ****** ****** *)

typedef
compare (a:viewt@ype) =
  {x1,x2:int} (&stamped_vt (a, x1), &stamped_vt (a, x2)) -> int (x1-x2)
// end of [compare]

(* ****** ****** *)

(*
//
absprop LTB (x:int, xs:ilist)
absprop GTEB (xs:ilist, x:int)
//
propdef
BSEARCH (xs:ilist, x0:int, i:int) = [xsf,xsb:ilist] (
  LENGTH (xsf, i), APPEND (xsf, xsb, xs), GTEB (xsf, x0), LTB (x0, xsb)
) // end of [BSEARCH]
//
*)
absprop BSEARCH (xs:ilist, x0:int, i:int)

(* ****** ****** *)

extern
prfun lemma_bsearch_param
  {xs:ilist} {x0:int} {i:int} (pf: BSEARCH (xs, x0, i)): [i>=0] void
// end of [lemma_bsearch_param]

(* ****** ****** *)

extern
prfun bsearch_nil {x0:int} (): BSEARCH (nil, x0, 0)

extern
prfun
lemma_bsearch_left
  {x0:int}
  {xs:ilist}
  {xs1:ilist}
  {x:int | x0 < x}
  {xs2:ilist}
  {i:int}
(
  pf0: ISORD (xs), pf1: APPEND (xs1, cons (x, xs2), xs), pf2: BSEARCH (xs1, x0, i)
) : BSEARCH (xs, x0, i) // end of [lemma_bsearch_left]

extern
prfun
lemma_bsearch_right
  {x0:int}
  {xs:ilist}
  {xs1:ilist}
  {x:int | x0 >= x}
  {xs2:ilist}
  {n1:int} {i:int}
(
  pf0: ISORD (xs), pf1: APPEND (xs1, cons (x, xs2), xs), pf2: LENGTH (xs1, n1), pf3: BSEARCH (xs2, x0, i)
) : BSEARCH (xs, x0, n1+1+i) // end of [lemma_bsearch_right]

(* ****** ****** *)
//
extern
prfun lemma1_isord_append {xs:ilist} {xs1,xs2:ilist}
  (pford: ISORD xs, pfapp: APPEND (xs1, xs2, xs)): ISORD (xs1)
extern
prfun lemma2_isord_append {xs:ilist} {xs1,xs2:ilist}
  (pford: ISORD xs, pfapp: APPEND (xs1, xs2, xs)): ISORD (xs2)
//
(* ****** ****** *)

extern
fun{a:t@ype}
bsearch
  {l:addr}{xs:ilist}{x0:int}{n:nat} 
(
  pford: ISORD (xs)
, pflen: LENGTH (xs, n)
, pfarr: !gfarray_v (a, l, xs)
| p: ptr l, x0: &stamped_vt (a, x0), n: size_t n, cmp: compare (a)
) : [i:int]
(
  BSEARCH (xs, x0, i) | ptr (l+i*sizeof(a))
)

(* ****** ****** *)

extern
fun halfsize{n:nat}
  (n: size_t n):<> [n2:nat | 2*n2 <= n] size_t (n2)
// end of [halfsize]

(* ****** ****** *)

implement{a}
bsearch{l}{xs}{x0}{n}
(
  pford, pflen, pfarr | p, x0, n, cmp
) = let
in
//
if n > 0 then let
  val [n2:int] n2 = halfsize (n)
  prval
  (
    pflen_xs1, pflen_xs2
  , pfapp_xs1_xs2
  , pfarr_xs1, pfarr_xs2
  ) = gfarray_v_split {a}{..}{..}{..}{n2} (pflen, pfarr)
//
  prval LENGTHcons {x} {xs21} (pflen_xs21) = pflen_xs2
//
  prval gfarray_v_cons (pfat_x, pfarr_xs21) = pfarr_xs2
  val (pfat_x | p1) = viewptr_match (pfat_x | ptr_add<a> (p, n2))
  val sgn = cmp (x0, !p1)
//
  val res =
  (
    if sgn < 0 then let
      prval pford_xs1 =
        lemma1_isord_append (pford, pfapp_xs1_xs2)
      val (pfsrch_xs1 | p_res) = bsearch
        (pford_xs1, pflen_xs1, pfarr_xs1 | p, x0, n2, cmp)
      prval pfsrch_xs =
        lemma_bsearch_left (pford, pfapp_xs1_xs2, pfsrch_xs1)
    in
      (pfsrch_xs | p_res)
    end else let
      prval pford_xs2 = lemma2_isord_append (pford, pfapp_xs1_xs2)
      prval ISORDcons (pford_xs21, _) = pford_xs2
      val p21 = ptr_succ<a> (p1)
      val (pfsrch_xs21 | p21_res) = bsearch
        (pford_xs21, pflen_xs21, pfarr_xs21 | p21, x0, pred(n)-n2, cmp)
      prval pfsrch_xs =
        lemma_bsearch_right (pford, pfapp_xs1_xs2, pflen_xs1, pfsrch_xs21)
    in
      (pfsrch_xs | p21_res)
    end // end of [if]
  ) : [i:int] (BSEARCH (xs, x0, i) | ptr (l+i*sizeof(a)))
//
  prval pfarr_xs2 = gfarray_v_cons {a} (pfat_x, pfarr_xs21)
  prval (pfapp_alt, pfarr_alt) =
    gfarray_v_unsplit {a} (pflen_xs1, pfarr_xs1, pfarr_xs2)
  prval ILISTEQ () = append_isfun (pfapp_xs1_xs2, pfapp_alt)
  prval () = pfarr := pfarr_alt
//
in
  res
end else let
  prval LENGTHnil () = pflen
  prval pfsrch = bsearch_nil {x0} ()
in
  (pfsrch | p)
end // end of [if]
//
end // end of [bsearch]

(* ****** ****** *)

(* end of [bsearch_arr.dats] *)

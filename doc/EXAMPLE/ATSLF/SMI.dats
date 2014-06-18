(* ****** ****** *)
//
// HX-2012-03-04:
//
// justifying the principle of strong mathematical induction
// (that is, course-of-values induction) based on the standard
// mathematical induction principle
//
extern
prfun SMI {P:int->prop}
  (fpf: {n:nat} ({k:nat | k < n} P(k)) -<prf> P(n)): {n:nat} P(n)
// end of [SMI] // end of [prfun]

(* ****** ****** *)

primplmnt
SMI{P}(fpf){n} = let
//
propdef Q
  (n:int) = {k:nat | k <= n} P (k)
//
prfun lemma
  {n:nat} .<n>. (): Q (n) =
  lam {
    k:nat | k <= n
  } : P (k) =>
    sif n > 0 then let
      val IH = lemma {n-1} ()
    in
      sif k < n then IH {k} else fpf {n} (IH)
    end else
      fpf {0} (lam {} => case+ 0 of _ =/=> ())
    (* end of [sif] *)
// end of [lemma]
//
in
  lemma {n} () {n}
end // end of [SMI]

(* ****** ****** *)

(* end of [strongmathind.dats] *)

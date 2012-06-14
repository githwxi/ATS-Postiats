(*
**
** An implementation of Hilbert calculus
**
*)

// There is a corresponding implementation in Twelf. For those who are
// familiar with Twelf, a comparison between these two implementations
// should not only be interesting but also can clearly reveal some benefit
// from constructing proofs in a functional style as is supported in ATS
// in contrast to a logic style as is supported in Twelf.

// November 2004: the code is completed by Hongwei Xi

// January 2007: the code is ported to ATS/Geizella by Hongwei Xi

// March 3rd, 2008: the code is ported to ATS/Anairiats by Hongwei Xi

(* ***** ****** *)
//
// HX-2012-06-13: the code typechecks in ATS2 without any changes
//
(* ****** ****** *)

datasort form = FORMtrue | FORMfalse | FORMimp of (form, form)

stadef K (f1:form, f2:form): form = FORMimp (f1, FORMimp (f2, f1))

stadef S1 (f1:form, f2:form, f3:form): form = FORMimp (f1, FORMimp (f2, f3))
stadef S2 (f1:form, f2:form, f3:form): form = FORMimp (FORMimp (f1, f2), FORMimp (f1, f3))

stadef S (f1:form, f2:form, f3:form): form =
  FORMimp (S1 (f1, f2, f3), S2 (f1, f2, f3))

datasort forms = FORMSnone | FORMSmore of (forms, form)

dataprop IN (form, forms) =
  | {G:forms} {A: form} INone (A, FORMSmore (G, A))
  | {G:forms} {A,B: form} INshi (A, FORMSmore (G, B)) of IN (A, G)

dataprop hil (forms, form, int) =
  | {G: forms} {A: form} HILhyp (G, A, 0) of IN (A, G)
  | {G: forms} {A,B: form} HILk (G, K (A, B), 0)
  | {G: forms} {A,B,C: form} HILs (G, S (A, B, C), 0)
  | {G: forms} {A,B: form} {n1,n2:nat}
      HILmp (G, B, n1+n2+1) of (hil (G, FORMimp (A, B), n1), hil (G, A, n2))

propdef hil0 (G:forms, A:form) = [n:nat] hil (G, A, n)

prfn HILi {G: forms} {A: form} (): hil0 (G, FORMimp (A, A)) =
  HILmp (HILmp (HILs, HILk), HILk)

//

prfun abs {G:forms} {A,B:form} {n:nat} .<n>.
  (pf: hil (FORMSmore (G, A), B, n))
  : hil0 (G, FORMimp (A, B)) = begin case+ pf of
  | HILhyp i => begin case+ i of
    | INone () => HILmp (HILmp (HILs, HILk), HILk)
    | INshi i => HILmp (HILk, HILhyp i)
    end
  | HILk () => HILmp (HILk, HILk)
  | HILs () => HILmp (HILk, HILs)
  | HILmp (pf1, pf2) => HILmp (HILmp (HILs, abs pf1), abs pf2)
end // end of [abs]

//

dataprop nd (forms, form, int) =
  | {G:forms}{A:form} NDhyp (G, A, 0) of IN (A, G)
  | {G:forms}{A,B:form}{n:nat}
      NDimp (G, FORMimp (A, B), n+1) of nd (FORMSmore (G, A), B, n)
  | {G:forms}{A,B: form}{n1,n2:nat}
      NDmp (G, B, n1+n2+1) of (nd (G, FORMimp (A, B), n1), nd (G, A, n2))

propdef nd0 (G:forms, A:form) = [n:nat] nd (G, A, n)

//

prfun hil2nd {G:forms} {A:form} {n:nat} .<n>.
  (pf: hil (G, A, n)): nd0 (G, A) = begin
  case+ pf of
  | HILhyp i => NDhyp i
  | HILk () => NDimp (NDimp (NDhyp (INshi (INone))))
  | HILs () =>
     NDimp (NDimp (NDimp (
       NDmp (
         NDmp (NDhyp (INshi (INshi INone)), NDhyp (INone)),
         NDmp (NDhyp (INshi INone), NDhyp (INone))
       )
     )))
  | HILmp (pf1, pf2) =>  NDmp (hil2nd pf1, hil2nd pf2)
end // end of [hil2nd]

//

prfun nd2hil {G:forms} {A:form} {n:nat} .<n>.
  (pf: nd (G, A, n)): hil0 (G, A) = begin case+ pf of
  | NDhyp i => HILhyp i
  | NDimp pf => abs (nd2hil pf)
  | NDmp (pf1, pf2) => HILmp (nd2hil pf1, nd2hil pf2)
end // end of [nd2hil]

// some simple examples

prval K = nd2hil (NDimp (NDimp (NDhyp (INshi INone))))

prval B =
  nd2hil (
    NDimp (NDimp (NDimp (
      NDmp (NDmp (NDhyp (INshi (INshi (INone))), NDhyp (INone)),
           NDhyp (INshi (INone))))))
  )

prval C =
  nd2hil (NDimp (NDimp (NDmp
    (NDmp (NDhyp (INshi INone), NDhyp INone), NDhyp INone)))
  )

(* ****** ****** *)

(* end of [HilbertCalc.dats] *)

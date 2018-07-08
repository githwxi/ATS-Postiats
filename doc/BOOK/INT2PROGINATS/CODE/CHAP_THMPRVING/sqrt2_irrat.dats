(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)

abstype
MOD0(m: int, p: int) // m=p*q
  
(* ****** ****** *)
//
extern
prfun
lemma_MOD0_intr
  {m,p,q:nat | m==p*q}(): MOD0(m, p)
extern
prfun
lemma_MOD0_elim
  {m,p:int}
  (MOD0(m, p)): [q:nat] EQINT(m, p*q)
//
(* ****** ****** *)

abstype PRIME(p:int)

(* ****** ****** *)
//
extern
prfun
lemma_PRIME_param
  {p:int}(pf: PRIME(p)): [p >= 2] void
//
(* ****** ****** *)
//
extern
prfun
mylemma1{n,p:int}
  (MOD0(n*n, p), PRIME(p)): MOD0(n, p)
//
(* ****** ****** *)

extern
prfun
mylemma_main
{m,n,p:int | m*m==p*n*n}(PRIME(p)): [m2:nat | n*n==p*m2*m2] void

(* ****** ****** *)

extern
prfun
square_is_nat{m:int}(): [m*m>=0] void

(* ****** ****** *)

primplmnt
mylemma_main
{m,n,p}(pfprm) = let
  prval pfeq_mm_pnn =
    eqint_make{m*m,p*n*n}()
  prval () = square_is_nat{m}()
  prval () = square_is_nat{n}()
  prval () = lemma_PRIME_param(pfprm)
  prval
  pfmod1 =
    lemma_MOD0_intr{m*m,p,n*n}()
  prval
  pfmod2 = mylemma1{m,p}(pfmod1, pfprm)
  prval
  [m2:int]
  EQINT() =
    lemma_MOD0_elim(pfmod2)
  prval EQINT() = pfeq_mm_pnn
  prval () =
  __assert{p}{p*m2*m2,n*n}() where
  {
    extern prfun __assert{p:pos}{x,y:int | p*x==p*y}(): [x==y] void
  }
in
  #[m2 | ()]
end // end of [mylemma_main]

(* ****** ****** *)
//
extern
prfun
sqrt2_irrat
{m,n:nat |
 n >= 1; m*m==2*n*n}((*void*)): [false] void
//
(* ****** ****** *)

primplmnt
sqrt2_irrat
  {m,n}((*void*)) = let
//
prfun
auxmain 
{m,n:nat |
 n >= 1;
 m*m==2*n*n} .<m>.
(
// argless
) : [false] void = let
//
prval pfprm =
__assert() where
{
  extern praxi __assert(): PRIME(2)
}
prval
[m2:int] () = mylemma_main{m,n,2}(pfprm)
//
prval () =
__assert() where { extern praxi __assert(): [m > n] void }
prval () =
__assert() where { extern praxi __assert(): [m2 >= 1] void }
//
in
  auxmain{n,m2}()
end // end of [auxmain]
//
in
  auxmain{m,n}()
end // end of [sqrt2_irrat]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [sqrt2_irrat.dats] *)

(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#staload
"prelude/codegen.sats"
//
(* ****** ****** *)

abst0ype T0 = int
absvt0ype VT0 = int

(* ****** ****** *)

absvtype
myarr_t
(
  a:vt0p
, l:addr, n:int
) (* myarr_t *)

(* ****** ****** *)
//
extern
fun
{a:t@ype}
myarr_make
  {n:nat}(int(n)): [l:addr] myarr_t(a, l, n)
extern
fun
myarr_free{a:t@ype}{l:addr}{n:nat}(myarr_t(a, l, n)): void
//
(* ****** ****** *)
//
(*
vtypedef
myrec_t
(
  l: addr
) = $rec_vt{
//
a= get(T0)
,
a= set(T0)
,
b= getset(T0)
,
c= exch($tup(int, VT0))
,
d= getref(VT0)
//
} (* end of [vtypedef] *)
*)
//
(* ****** ****** *)
//
#ifdef
CODEGEN2
#then
vtypedef
myarr_t
(
  a:vt0p
, l:addr, n:int
) =
$rec_vt{
//
a= get(int(n))
,
b= getref(array(a, n))
//
,
_linear_ = unit_vt(*void*)
//
} // end of [myarr_t]
#codegen2
(
  absrec, myarr_t, myarr$
) (* #codegen2 *)
#else
//
#include "./absrec_codegen2.hats"
//
#endif // ifdef(CODEGEN2)
//
(* ****** ****** *)
//
(*
#codegen2(absrec, myrec_t, myrec$)
*)
//
(* ****** ****** *)

fun
test() = () where
{
//
val n = 10
val A = myarr_make<int>(n)
val n = A.a()
//
val (pf, fpf | p) = myarr$getref_b(A)
val () = p->[0] := 0
val () = p->[1] := 1
prval () = fpf(pf)
//
val () = myarr_free{int}(A)
//
} (* end of [test] *)

(* ****** ****** *)

(* end of [absrec.sats] *)

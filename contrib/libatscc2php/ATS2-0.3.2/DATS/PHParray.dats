(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_PHParray_"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
//
#staload "./../SATS/integer.sats"
//
#staload "./../SATS/PHParray.sats"
//
(* ****** ****** *)

implement
PHParray2list
  {a}(A) = let
//
val [n:int] asz = A.size()
//
fun
loop
{i:nat | i <= n}
(i: int(i),
 res: list(a, n-i)): list(a, n) =
(
if i > 0
  then
  loop(i-1, list_cons(A[i-1], res))
  else res
// end of [if]
) (* end of [loop] *)
//
in
  loop(asz, list_nil())
end // end of [PHParray2list]

(* ****** ****** *)

implement
PHParray2list_rev
  {a}(A) = let
//
val [n:int] asz = A.size()
//
fun
loop
{i:nat | i <= n}
(i: int(i),
 res: list(a, i)): list(a, n) =
(
if i < asz
  then loop(i+1, list_cons(A[i], res)) else res
// end of [if]
) (* end of [loop] *)
//
in
  loop(0, list_nil())
end // end of [PHParray2list_rev]

(* ****** ****** *)

implement
PHParray_streamize_elt
  {a}(A) =
  auxmain(asz) where
{
//
val [n:int] asz = A.size()
//
fun
auxmain
{i:nat | i <= n}
(
 i: int(i)
) : stream_vt(a) = $ldelay
(
if i > 0
  then
  stream_vt_cons
    (A[i-1], auxmain(i-1))
  // then
  else stream_vt_nil(*void*)
// end of [if]
) (* end of [auxmain] *)
//
} (* end of [PHParray_streamize_elt] *)

(* ****** ****** *)

(* end of [PHParray.dats] *)

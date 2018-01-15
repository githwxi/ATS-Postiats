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
#staload "./../SATS/list.sats"
#staload "./../SATS/PHParray.sats"
#staload "./../SATS/PHParref.sats"
//
(* ****** ****** *)
//
implement
PHParray_make_list
{a}(xs) =
(
$extfcall
( PHParray(a)
, "ats2phppre_PHParref2array", A
)
) where
{
  val A = PHParref_make_list{a}(xs)
}
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
{i:nat|i <= n}
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
{n:nat}
{i:nat|i <= n}
( n: int(n)
, i: int(i)
, res: list(a, i)): list(a, n) =
(
if
(i < n)
then
loop(n, i+1, list_cons(A[i], res))
else res
// end of [if]
) (* end of [loop] *)
//
in
  loop(asz, 0, list_nil())
end // end of [PHParray2list_rev]

(* ****** ****** *)

implement
PHParray2list_map
  {a}{b}(A, fopr) = let
//
val [n:int] asz = A.size()
//
fun
loop
{n:nat}
{i:nat|i <= n}
( n: int(n)
, i: int(i)
, res: list(b, i)): list(b, n) =
(
if
(i < n)
then
loop(n, i+1, list_cons(fopr(A[i]), res))
else res
// end of [if]
) (* end of [loop] *)
//
in
  list_reverse(loop(asz, 0, list_nil()))
end // end of [PHParray2list_map]

(* ****** ****** *)

implement
PHParray2list_map_rev
  {a}{b}(A, fopr) = let
//
val [n:int] asz = A.size()
//
fun
loop
{i:nat|i <= n}
(i: int(i),
 res: list(b, n-i)): list(b, n) =
(
if i > 0
  then
  loop(i-1, list_cons(fopr(A[i-1]), res))
  else res
// end of [if]
) (* end of [loop] *)
//
in
  list_reverse(loop(asz, list_nil()))
end // end of [PHParray2list_map_rev]

(* ****** ****** *)

implement
PHParray_forall
  (A, test) =
  loop(asz, 0) where
{
//
val [n:int] asz = A.size()
//
fun
loop
{n:nat}
{i:nat|i <= n}
( n: int(n)
, i: int(i)): bool =
(
if
(i < n)
then
(
if
test(A[i]) then loop(n, i+1) else false
) (* end of [then] *)
else true // end of [else]
// end of [if]
) (* end of [loop] *)
//
} // end of [PHParray_forall]

(* ****** ****** *)

implement
PHParray_foreach
  (A, fwork) =
  loop(asz, 0) where
{
//
val [n:int] asz = A.size()
//
fun
loop
{n:nat}
{i:nat|i <= n}
( n: int(n)
, i: int(i)): void =
(
if
(i < n)
then
(
let val () =
  fwork(A[i]) in loop(n, i+1)
end // end of [let]
) (* end of [then] *)
else ((*void*)) // end of [else]
// end of [if]
) (* end of [loop] *)
//
} // end of [PHParray_foreach]

(* ****** ****** *)

implement
PHParray_streamize_elt
  {a}(A) =
  auxmain(asz, 0) where
{
//
val [n:int] asz = A.size()
//
fun
auxmain
{n:int}
{i:nat|i <= n}
(
 n: int(n), i: int(i)
) : stream_vt(a) = $ldelay
(
if i < n
  then
  stream_vt_cons
    (A[i], auxmain(n, i+1))
  // then
  else stream_vt_nil((*void*))
// end of [if]
) (* end of [auxmain] *)
//
} (* end of [PHParray_streamize_elt] *)

(* ****** ****** *)

(* end of [PHParray.dats] *)

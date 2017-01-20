(*
** For testing ats2cpp
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

%{^
#undef ATSextfcall
#define ATSextfcall(fun, funarg) fun funarg
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
//
#include <vector>
//
#define \
fvectorptr(elt) std::vector<elt>*
//
#define \
fvectorptr_new(elt) new std::vector<int>()
#define \
fvectorptr_free(elt, p0) \
delete(static_cast<std::vector<elt>*>(p0))
//
#define \
fvectorptr_get_at(elt, p0, i) \
  (*(static_cast<std::vector<elt>*>(p0)))[i]
//
#define \
fvectorptr_push_back(elt, p0, x0) \
  (static_cast<std::vector<elt>*>(p0))->push_back(x0)
//
%} // end of [%{^]

(* ****** ****** *)
//
absvtype
vectorptr(a:t@ype+) = $extype"fvectorptr"(a)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
vectorptr_new(): vectorptr(a)
extern
fun
{a:t@ype}
vectorptr_free(vectorptr(a)): void
//
extern
fun
{a:t@ype}
vectorptr_get_at
  (p0: !vectorptr(INV(a)), int): a
//
overload [] with vectorptr_get_at
//
extern
fun
{a:t@ype}
vectorptr_push_back
  (p0: !vectorptr(INV(a)), a): void
//
(* ****** ****** *)
//
implement
{elt}
vectorptr_new
(
// argumentless
) =
$extfcall
(
  vectorptr(elt), "fvectorptr_new", $tyrep(elt)
) (* vectorptr_new *)
//
(* ****** ****** *)
//
implement
{elt}
vectorptr_free
(
  p0
) = let
//
val p0 = $UNSAFE.castvwtp0{ptr}(p0)
//
in
//
$extfcall
  (void, "fvectorptr_free", $tyrep(elt), p0)
//
end // end of [vectorptr_free]
//
(* ****** ****** *)
//
implement
{elt}
vectorptr_get_at
  (p0, i) = let
//
val p0 = $UNSAFE.castvwtp1{ptr}(p0)
//
in
//
$extfcall
  (elt, "fvectorptr_get_at", $tyrep(elt), p0, i)
//
end // end of [vectorptr_get_at]
//
(* ****** ****** *)
//
implement
{a}(*tmp*)
vectorptr_push_back
  (p0, x) = let
  val p0 = $UNSAFE.castvwtp1{ptr}(p0)
in
  $extfcall(void, "fvectorptr_push_back", $tyrep(a), p0, x)
end // end of [vectorptr_push_back]
//
(* ****** ****** *)
//
extern
fun
fact(n: int): int = "ext#"
//
(* ****** ****** *)

implement
fact(n) = res where
{
//
val p0 =
  vectorptr_new<int>()
// end of [val]
val () = loop(p0, 0) where
{
  fun
  loop
  (
    p0: !vectorptr(int), i: int
  ) : void =
    if i < n then
    (
      vectorptr_push_back(p0, i+1); loop(p0, i+1)
    )
  // end of [loop]
}
val res = loop(p0, 0, 1) where
{
  fun
  loop
  (
    p0: !vectorptr(int), i: int, res: int
  ) : int =
    if i < n then loop(p0, i+1, res * p0[i]) else res
  // end of [loop]
}
//
val ((*freed*)) = vectorptr_free(p0)
//
} (* end of [fact] *)

(* ****** ****** *)

(*
implement
main0() =
println! ("fact(10) = ", fact(10))
*)

(* ****** ****** *)

%{$

#include <iostream>

int main()
{
//
  std::cout <<
  "fact(10) = " << fact(10) << std::endl;
//
  return 0;
//
} /* end of [main] */

%} // end of [%{$]

(* ****** ****** *)

(* end of [test02.dats] *)

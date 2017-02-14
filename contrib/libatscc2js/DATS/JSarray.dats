(*
** For writing ATS code
** that translates into Javascript
*)

(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_JSarray_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../basics_js.sats"

(* ****** ****** *)

#staload "./../SATS/integer.sats"

(* ****** ****** *)

#staload "./../SATS/JSarray.sats"

(* ****** ****** *)

implement
JSarray_make_list
  {a}(xs) = let
//
fun
loop
(
  A: JSarray(a), xs: List(a)
) : void =
(
case+ xs of
| list_nil() => ()
| list_cons(x, xs) =>
  let val _ = A.push(x) in loop(A, xs) end
)
//
val A = JSarray_nil{a}()
//
in
  let val () = loop(A, xs) in A end
end // end of [JSarray_make_list]

(* ****** ****** *)

implement
JSarray_make_list_vt
  {a}(xs) = let
//
fun
loop
(
  A: JSarray(a), xs: List_vt(a)
) : void =
(
case+ xs of
| ~list_vt_nil() => ()
| ~list_vt_cons(x, xs) =>
  let val _ = A.push(x) in loop(A, xs) end
)
//
val A = JSarray_nil{a}()
//
in
  let val () = loop(A, xs) in A end
end // end of [JSarray_make_list_vt]

(* ****** ****** *)

implement
JSarray_tabulate_cloref
  {a}{n}
(
  asz, fopr
) = let
//
val A = JSarray_nil{a}()
//
fun
loop
{i:nat | i <= n}(i: int(i)): void =
(
if i < asz
  then let
    val _ = JSarray_push(A, fopr(i)) in loop(i+1)
  end // end of [then]
  else () // end of [else]
// end of [if]
) (* end of [loop] *)
//
in
  let val () = loop(0) in A end
end (* end of [JSarray_tabulate_cloref] *)

(* ****** ****** *)
//
implement
{a}(*tmp*)
JSarray_sort_1(A) = 
JSarray_sort_2
  (A, lam(x1, x2) => gcompare_val_val<a>(x1, x2))
//
(* ****** ****** *)

(* end of [JSarray.dats] *)

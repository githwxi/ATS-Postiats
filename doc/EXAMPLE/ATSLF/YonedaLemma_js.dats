(* ****** ****** *)
//
// HX-2014-01
// Yoneda Lemma:
// The hardest "trivial" theorem :)
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

staload
"{$LIBATSCC2JS}/SATS/print.sats"

(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"

(* ****** ****** *)

sortdef ftype = type -> type

(* ****** ****** *)
//
infixr (->) ->>
//
typedef
->> (a:type, b:type) = a -<cloref1> b
//
(* ****** ****** *)
//
typedef
Functor(F:ftype) =
  {a,b:type} (a ->> b) ->> F(a) ->> F(b)
//
(* ****** ****** *)
//
datatype
list0 (a:type) =
  | list0_nil of ()
  | list0_cons of (a, list0(a))
//
extern
val Functor_list0 : Functor (list0)
//
(* ****** ****** *)
//
fun
list0_map
  {a:type}{b:type}
  (xs: list0(a), f: a ->> b): list0(b) =
(
case+ xs of
| list0_nil() => list0_nil()
| list0_cons(x, xs) => list0_cons(f(x), list0_map(xs, f))
)
//
(* ****** ****** *)

implement
Functor_list0{a,b}
  (f) = lam xs => list0_map{a}{b}(xs, f)

(* ****** ****** *)
//
extern
fun Yoneda_phi : {F:ftype}Functor(F) ->
  {a:type}F(a) ->> ({r:type}(a ->> r) ->> F(r))
extern
fun Yoneda_psi : {F:ftype}Functor(F) ->
  {a:type}({r:type}(a ->> r) ->> F(r)) ->> F(a)
//
(* ****** ****** *)
//
implement
Yoneda_phi
  (ftor) = lam(fx) => lam (m) => ftor(m)(fx)
//
implement
Yoneda_psi (ftor) = lam(mf) => mf(lam x => x)
//
(* ****** ****** *)

datatype bool = True | False // boxed boolean

(* ****** ****** *)
//
fun bool2string
  (x:bool): string =
(
  case+ x of
  | True() => "True" | False() => "False"
)
//
(* ****** ****** *)
//
implement
print_val<bool> (x) = print_string (bool2string(x))
//
(* ****** ****** *)
//
#define :: list0_cons
#define nil list0_nil
#define cons list0_cons
//
val myboolist0 =
  True::False::True::False::False::nil{bool}()
//
(* ****** ****** *)
//
extern
val
Yoneda_bool_list0
  : {r:type} (bool ->> r) ->> list0(r)
//
implement
Yoneda_bool_list0 =
  Yoneda_phi(Functor_list0){bool}(myboolist0)
//
(* ****** ****** *)
//
extern
fun{a:type}
print_list0(xs: list0(a)): void
//
overload print with print_list0
//
(* ****** ****** *)

implement
{a}(*tmp*)
print_list0(xs) =
(
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) =>
  {
    val () = print_val<a> (x)
    val () = print_newline ()
    val () = print_list0<a> (xs)
  }
)

(* ****** ****** *)
//
val myboolist1 =
  Yoneda_psi(Functor_list0){bool}(Yoneda_bool_list0)
//
(* ****** ****** *)

val () = println! ("myboolist0 =\n", myboolist0)
val () = println! ("myboolist1 =\n", myboolist1)

(* ****** ****** *)

%{$
//
ats2jspre_the_print_store_clear();
my_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [YonedaLemma_js.dats] *)

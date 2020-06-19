(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

implement
main0() = ((*void*))

(* ****** ****** *)

typedef tvar = string

(* ****** ****** *)
typedef tvar = string

(* ****** ****** *)

datatype
term1 =
| TM1var of tvar
| TM1lam of (tvar, term1)
| TM1app of (term1, term1)

(* ****** ****** *)

extern
fun
print_term1
(t0: term1): void
overload print with print_term1

implement
print_term1(t0) =
(
case+ t0 of
| TM1var(x1) =>
  print!("TM1var(", x1, ")")
| TM1lam(x1, t1) =>
  print!("TM1lam(", x1, "; ", t1, ")")
| TM1app(t1, t2) =>
  print!("TM1app(", t1, "; ", t2, ")")
)

(* ****** ****** *)
//
datatype
term2 =
| TM2var of tvar
| TM2lam of
  ( term1, tenv2 )
| TM2laz of
  ( term1, tenv2 )
| TM2app of (term2, term2)
where
tenv2 = List0@(tvar, term2)
//
(* ****** ****** *)

extern
fun
tenv2_find
(xts: tenv2, x0: tvar): term2
implement
tenv2_find
(xts, x0) =
(
case+ xts of
| list_nil() => TM2var(x0)
| list_cons
  (xt0, xts) =>
  if
  (x0 = xt0.0)
  then xt0.1 else tenv2_find(xts, x0)
)

(* ****** ****** *)

fun
compile
(t0: term1): term2 =
(
let
val
xts = 
list_nil() in evaluate(t0, xts)
end
) (* end of [compile] *)

and
evaluate
( t0
: term1
, env0
: tenv2): term2 =
(
case+ t0 of
|
TM1var(x0) =>
let
val t0 =
tenv2_find(env0, x0)
in
case+ t0 of
| TM2laz
  (t1, env1) =>
  evaluate(t1, env1)
| _(*non-TM2laz*) => t0
end
|
TM1lam(x1, t1) =>
TM2lam(t0, env0)
|
TM1app(t1, t2) =>
let
val t1 = evaluate(t1, env0)
in
//
case+ t1 of
| TM2lam
  (t1, env1) =>
  let
  val-
  TM1lam(x1, u1) = t1
  val t2 = TM2laz(t2, env0)
  in
    evaluate(u1, env1) where
    {
      val env1 =
      list_cons((x1, t2), env1)
    }
  end
| _ (*non-TM2lam*) =>
  TM2app(t1, evaluate(t2, env0))
//
end
) (* end of [evaluate] *)

(* ****** ****** *)

fun
normalize
(t0: term1): term1 =
(
  normize(compile(t0))
) where
{
fun
normize(t0: term2): term1 =
(
case+ t0 of
| TM2var(x1) =>
  TM1var(x1)
| TM2laz(t1, env1) =>
  normize(evaluate(t1, env1))
| TM2lam(t1, env1) =>
  let
  val-
  TM1lam(x1, u1) = t1
  in
  TM1lam
  ( x1
  , normize(evaluate(u1, env1)))
  end
| TM2app(t1, t2) =>
  TM1app(normize(t1), normize(t2))
)
}

(* ****** ****** *)

val K =
let
val x = TM1var("x")
val y = TM1var("y") in
TM1lam("x", TM1lam("y", x))
end
val K1 =
let
val x = TM1var("x")
val y = TM1var("y") in
TM1lam("x", TM1lam("y", y))
end

(* ****** ****** *)

val S =
let
val x = TM1var("x")
val y = TM1var("y")
val z = TM1var("z") in
TM1lam
( "x"
,
TM1lam
( "y"
, TM1lam
  ( "z"
  , TM1app
    (TM1app(x, z), TM1app(y, z))
  )
)
)
end

(* ****** ****** *)
val
omega =
let
val x = TM1var("x")
in
TM1lam("x", TM1app(x, x))
end
val
Omega = TM1app(omega, omega)
(* ****** ****** *)
//
val K1O =
TM1app(K1, Omega)
val K1O_nf = normalize(K1O)
//
val ( ) = println!("K1O = ", K1O)
val ( ) = println!("K1O_nf = ", K1O_nf)
//
(* ****** ****** *)
//
val SKK =
TM1app(TM1app(S, K), K)
//
val SKK_nf = normalize(SKK)
//
val ( ) = println!("SKK = ", SKK)
val ( ) = println!("SKK_nf = ", SKK_nf)
//
(* ****** ****** *)

val N2 =
let
val f = TM1var("f")
val x = TM1var("x")
in
  TM1lam
  ( "f"
  , TM1lam("x", TM1app(f, TM1app(f, x))))
end
val N3 =
let
val f = TM1var("f")
val x = TM1var("x")
in
  TM1lam
  ( "f"
  , TM1lam
    ("x", TM1app(f, TM1app(f, TM1app(f, x)))))
end

(* ****** ****** *)
//
val f = TM1var("f")
val x = TM1var("x")
//
val App_N2_N3_nf =
normalize(TM1app(TM1app(TM1app(N2, N3), f), x))
val App_N3_N2_nf =
normalize(TM1app(TM1app(TM1app(N3, N2), f), x))
//
val ((*void*)) = println!("App_2_3 = ", App_N2_N3_nf)
val ((*void*)) = println!("App_3_2 = ", App_N3_N2_nf)
//
(* ****** ****** *)

(* end of [lambda_cal2.dats] *)

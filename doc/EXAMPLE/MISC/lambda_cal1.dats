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
//
datatype
term1 =
| TM1var of tvar
| TM1lam of (tvar, term1)
| TM1app of (term1, term1)
//
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
| TM2var of
  ( tvar )
| TM2app of
  (term2, term2)
| TM2lam of
  (tvar, term2 -<cloref1> term2)
//
(* ****** ****** *)

typedef
tctx =
List0@(tvar, term2)
typedef
fterm2 = (tctx) -<cloref1> term2

(* ****** ****** *)

fun
tfind
( xts
: tctx
, x0: tvar): term2 =
(
case- xts of
|
list_nil() => TM2var(x0)
|
list_cons(xt1, xts) =>
if (
x0 = xt1.0
) then xt1.1 else tfind(xts, x0)
)

(* ****** ****** *)

fun
parse
(t0: term1): fterm2 =
(
case+ t0 of
| TM1var(x0) =>
  (
    lam(xts) => tfind(xts, x0)
  )
| TM1lam(x1, t1) =>
  let
    val f1 = parse(t1)
  in
    lam(xts) =>
    TM2lam
    ( x1
    , lam(a1) =>
      f1(list_cons((x1, a1), xts)))
  end
| TM1app(t1, t2) =>
  let
    val f1 = parse(t1)
    val f2 = parse(t2)
  in
    lam(xts) => TM2app(f1(xts), f2(xts))
  end
)

(* ****** ****** *)

fun
evaluate
(t0: term2): term2 =
(
case+ t0 of
| TM2var _ => t0
| TM2lam _ => t0
| TM2app(t1, t2) =>
  let
  val t1 = evaluate(t1)
  in
    case+ t1 of
    | TM2lam(_, f1) =>
      evaluate(f1(t2))
    | _ (*non-TM2lam*) =>
      let
      val t2 = evaluate(t2) in TM2app(t1, t2)
      end
  end
)

(* ****** ****** *)

fun
normalize
(t0: term1): term1 =
(
let
val f1 = parse(t0)
in
normize
(evaluate(f1(list_nil())))
end
) where
{
fun
normize
(t0: term2): term1 =
(
case+ t0 of
| TM2var(x1) =>
  TM1var(x1)
| TM2lam(x1, f1) =>
  let
    val t1 =
    evaluate
    (f1(TM2var(x1)))
  in
    TM1lam(x1, normize(t1))
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
, TM1lam
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
  TM1lam("f", TM1lam("x", TM1app(f, TM1app(f, x))))
end
val N3 =
let
val f = TM1var("f")
val x = TM1var("x")
in
  TM1lam("f", TM1lam("x", TM1app(f, TM1app(f, TM1app(f, x)))))
end

(* ****** ****** *)
//
val f = TM1var("f")
val x = TM1var("x")
//
val App_2_3 =
normalize(TM1app(TM1app(TM1app(N2, N3), f), x))
val App_3_2 =
normalize(TM1app(TM1app(TM1app(N3, N2), f), x))
//
val ((*void*)) = println!("App_2_3 = ", App_2_3)
val ((*void*)) = println!("App_3_2 = ", App_3_2)
//
(* ****** ****** *)

(* end of [lambda_cal1.dats] *)

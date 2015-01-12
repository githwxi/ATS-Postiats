(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
datatype weekday =
  | Monday | Tuesday | Wednesday | Thursday | Friday
//
(* ****** ****** *)
//
fun
weekday2int
  (wd: weekday): int = $UN.cast{int}($UN.cast{intptr}(wd))
//
(* ****** ****** *)

val () = println! ("Monday -> ", weekday2int(Monday))
val () = println! ("Tuesday -> ", weekday2int(Tuesday))
val () = println! ("Wednesday -> ", weekday2int(Wednesday))
val () = println! ("Thursday -> ", weekday2int(Thursday))
val () = println! ("Friday -> ", weekday2int(Friday))

(* ****** ****** *)
//
fun
isFriday(x: weekday): bool =
  case+ x of Friday() => true | _ => false
//
(* ****** ****** *)

val () = assertloc (isFriday(Friday))
val () = assertloc (isFriday(Friday()))

(* ****** ****** *)

datatype abc =
  | A of () | B of (bool) | C of (int, double)

(* ****** ****** *)

fun
abc2tag
(x: abc): int = let
  val p = $UN.cast{intptr}(x)
in
//
case+ 0 of
| _ when p < 1024 => $UN.cast{int}(p)
| _ (*heap-allocated*) => $UN.ptr0_get<int>($UN.cast{ptr}(p))
//
end // end of [abc2tag]

(* ****** ****** *)

val () = println! ("tag(A) = ", abc2tag(A()))
val () = println! ("tag(B) = ", abc2tag(B(true)))
val () = println! ("tag(C) = ", abc2tag(C(0, 1.0)))

(* ****** ****** *)

datatype ab = A of () | B of (bool)

(* ****** ****** *)

val () = assertloc (iseqz($UN.cast{ptr}(A())))
val () = assertloc (true = $UN.ptr0_get<bool>($UN.cast{ptr}(B(true))))
val () = assertloc (false = $UN.ptr0_get<bool>($UN.cast{ptr}(B(false))))

(* ****** ****** *)

datatype exp =
| Int of int
| Neg of (exp)
| Add of (exp, exp)
| Sub of (exp, exp)

(* ****** ****** *)

datatype
intexp =
| Int of int
| Neg of (intexp)
| Add of (intexp, intexp)
| Sub of (intexp, intexp)
| IfThenElse of (boolexp, intexp, intexp)

and
boolexp =
| Bool of bool
| Not of (boolexp)
| Disj of (boolexp, boolexp)
| Conj of (boolexp, boolexp)
| Less of (intexp, intexp)
| LessEq of (intexp, intexp)

(* ****** ****** *)
//
symintr eval
//
extern
fun eval_intexp : intexp -> int
extern
fun eval_boolexp : boolexp -> bool
//
overload eval with eval_intexp
overload eval with eval_boolexp
//
(* ****** ****** *)
//
implement
eval_intexp
  (e0) = (
//
case+ e0 of
| Int (i) => i
| Neg (e) => ~eval(e)
| Add (e1, e2) => eval(e1) + eval(e2)
| Sub (e1, e2) => eval(e1) - eval(e2)
| IfThenElse
    (e_test, e_then, e_else) =>
    if eval(e_test) then eval(e_then) else eval(e_else)
//
) (* end of [eval_intexp] *)
//
implement
eval_boolexp
  (e0) = (
//
case+ e0 of
| Bool (b) => b
| Not (e) => ~eval(e)
| Less (e1, e2) => eval(e1) < eval(e2)
| LessEq (e1, e2) => eval(e1) <= eval(e2)
| Conj (e1, e2) => eval(e1) && eval(e2)
| Disj (e1, e2) => eval(e1) || eval(e2)
//
) (* end of [eval_boolexp] *)
//
(* ****** ****** *)

val E0 =
IfThenElse (
  Less(Int(1), Int(2)), Sub(Int(11), Int(1)), Add(Int(12), Int(13))
) (* end of [val] *)

(* ****** ****** *)

val () = assertlocmsg (eval(E0) = 10, "\n")

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [chap_datatypes.dats] *)

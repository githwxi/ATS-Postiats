(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/bool.dats"
staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

datatype IEXP =
  | IEXPcst of int // constants
  | IEXPneg of (IEXP) // negation
  | IEXPadd of (IEXP, IEXP) // addition
  | IEXPsub of (IEXP, IEXP) // subtraction
  | IEXPmul of (IEXP, IEXP) // multiplication
  | IEXPdiv of (IEXP, IEXP) // division
  | IEXPif of (BEXP(*test*), IEXP(*then*), IEXP(*else*))
// end of [IEXP]

and BEXP =
  | BEXPcst of bool // boolean constants
  | BEXPneg of BEXP // negation
  | BEXPconj of (BEXP, BEXP) // conjunction
  | BEXPdisj of (BEXP, BEXP) // disjunction
  | BEXPeq of (IEXP, IEXP) // equal-to
  | BEXPneq of (IEXP, IEXP) // not-equal-to
  | BEXPlt of (IEXP, IEXP) // less-than
  | BEXPlte of (IEXP, IEXP) // less-than-equal-to
  | BEXPgt of (IEXP, IEXP) // greater-than
  | BEXPgte of (IEXP, IEXP) // greater-than-equal-to
// end of [BEXP]

fun eval_iexp (e0: IEXP): int =
(
case+ e0 of
| IEXPcst n => n
| IEXPneg (e) => ~eval_iexp (e)
| IEXPadd (e1, e2) => eval_iexp (e1) + eval_iexp (e2)
| IEXPsub (e1, e2) => eval_iexp (e1) - eval_iexp (e2)
| IEXPmul (e1, e2) => eval_iexp (e1) * eval_iexp (e2)
| IEXPdiv (e1, e2) => eval_iexp (e1) / eval_iexp (e1)
| IEXPif
  (
    e_test, e_then, e_else
  ) =>
  (
    eval_iexp (if eval_bexp (e_test) then e_then else e_else)
  ) // end of [IEXPif]
) (* end of [eval_iexp] *)

and eval_bexp (e0: BEXP): bool =
(
case+ e0 of
| BEXPcst b => b
| BEXPneg (e) => ~eval_bexp (e)
| BEXPconj (e1, e2) => if eval_bexp (e1) then eval_bexp (e2) else false
| BEXPdisj (e1, e2) => if eval_bexp (e1) then true else eval_bexp (e2)
| BEXPeq (e1, e2) => eval_iexp (e1) = eval_iexp (e2)
| BEXPneq (e1, e2) => eval_iexp (e1) <> eval_iexp (e2)
| BEXPlt (e1, e2) => eval_iexp (e1) < eval_iexp (e2)
| BEXPlte (e1, e2) => eval_iexp (e1) <= eval_iexp (e2)
| BEXPgt (e1, e2) => eval_iexp (e1) > eval_iexp (e2)
| BEXPgte (e1, e2) => eval_iexp (e1) >= eval_iexp (e2)
) (* end of [eval_bexp] *)

(* ****** ****** *)

macdef I (x) = IEXPcst ,(x)
macdef iadd (x, y) = IEXPadd (,(x), ,(y))
macdef isub (x, y) = IEXPsub (,(x), ,(y))
macdef imul (x, y) = IEXPmul (,(x), ,(y))
macdef idiv (x, y) = IEXPdiv (,(x), ,(y))

macdef B (x) = BEXPcst ,(x)
macdef beq (x, y) = BEXPeq (,(x), ,(y))
macdef bneq (x, y) = BEXPneq (,(x), ,(y))
macdef blt (x, y) = BEXPlt (,(x), ,(y))
macdef blte (x, y) = BEXPlte (,(x), ,(y))
macdef bgt (x, y) = BEXPgt (,(x), ,(y))
macdef bgte (x, y) = BEXPgte (,(x), ,(y))

(* ****** ****** *)

val
iexp1 = IEXPadd
(
  IEXPneg(I(1)), IEXPmul(IEXPsub(I(2), I(3)), I(4))
)

val
iexp2 = IEXPif
(
  I(1) \blte I(0), I(0), I(3) \iadd (I(5) \imul I(7))
) (* end of [val] *)

(* ****** ****** *)

implement
main0 () =
{
val () = assertloc (eval_iexp (iexp1) = ~1 + (2-3)*4)
val () = assertloc (eval_iexp (iexp2) = (if 1 <= 0 then 0 else 3+(5*7)))
} (* end of [val] *)

(* ****** ****** *)

(* end of [intexp.dats] *)

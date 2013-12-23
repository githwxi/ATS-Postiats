(*
** Some code used in the book PROGINATS
*)

(* ****** ****** *)

datatype intopt =
  | intopt_none of () | intopt_some of (int)
// end of [intopt]

(* ****** ****** *)

datatype wday =
  | Monday of ()
  | Tuesday of ()
  | Wednesday of ()
  | Thursday of ()
  | Friday of ()
  | Saturday of ()
  | Sunday of ()
// end of [wday]

fun isWeekday
  (x: wday): bool = case x of
  | Monday () => true // the bar (|) is optional for the first clause
  | Tuesday () => true
  | Wednesday () => true
  | Thursday () => true
  | Friday () => true
  | Saturday () => false
  | Sunday () => false
// end of [isWeekday]

fun isWeekday
  (x: wday): bool = case x of
  | Saturday () => false | Sunday () => false | _ => true
// end of [isWeekday]

(* ****** ****** *)

datatype charlst =
  | charlst_nil of () | charlst_cons of (char, charlst)

fun charlst_last
  (cs: charlst): char = case cs of
  | charlst_cons (c, charlst_nil ()) => c
  | charlst_cons (_, cs1) => charlst_last (cs1)
// end of [charlst_last]

fun charlst_last
  (cs: charlst): char = case cs of
  | charlst_cons (c, cs1) => (case+ cs1 of
      charlst_nil () => c | charlst_cons _ => charlst_last (cs1)
    ) // end of [char_cons]
// end of [charlst_last]

fun charlst_last
  (cs: charlst): char = let
  val charlst_cons (c, cs1) = cs in case+ cs1 of
  | charlst_nil () => c | charlst_cons _ => charlst_last (cs1)
end // end of [charlst_last]

(* ****** ****** *)

(*
datatype IEXP =
  | IEXPnum of int // numeral
  | IEXPneg of (IEXP) // negation
  | IEXPadd of (IEXP, IEXP) // addition
  | IEXPsub of (IEXP, IEXP) // subtraction
  | IEXPmul of (IEXP, IEXP) // multiplication
  | IEXPdiv of (IEXP, IEXP) // division
// end of [IEXP]

fun eval_iexp (e0: IEXP): int = case+ e0 of
  | IEXPnum n => n
  | IEXPneg (e) => ~eval_iexp (e)
  | IEXPadd (e1, e2) => eval_iexp (e1) + eval_iexp (e2)
  | IEXPsub (e1, e2) => eval_iexp (e1) - eval_iexp (e2)
  | IEXPmul (e1, e2) => eval_iexp (e1) * eval_iexp (e2)
  | IEXPdiv (e1, e2) => eval_iexp (e1) / eval_iexp (e1)
// end of [eval_iexp]
*)

(* ****** ****** *)

datatype IEXP =
  | IEXPcst of int // integer constants
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

(* ****** ****** *)

fun eval_iexp
  (e0: IEXP): int = case+ e0 of
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
// end of [eval_iexp]

and eval_bexp
  (e0: BEXP): bool = case+ e0 of
  | BEXPcst b => b
  | BEXPneg (e) => ~eval_bexp (e)
  | BEXPconj (e1, e2) =>
      if eval_bexp (e1) then eval_bexp (e2) else false
  | BEXPdisj (e1, e2) =>
      if eval_bexp (e1) then true else eval_bexp (e2)
  | BEXPeq (e1, e2) => eval_iexp (e1) = eval_iexp (e2)
  | BEXPneq (e1, e2) => eval_iexp (e1) != eval_iexp (e2)
  | BEXPlt (e1, e2) => eval_iexp (e1) < eval_iexp (e2)
  | BEXPlte (e1, e2) => eval_iexp (e1) <= eval_iexp (e2)
  | BEXPgt (e1, e2) => eval_iexp (e1) > eval_iexp (e2)
  | BEXPgte (e1, e2) => eval_iexp (e1) >= eval_iexp (e2)
// end of [eval_bexp]

(* ****** ****** *)

implement main () = ()

(* ****** ****** *)

(* end of [misc.dats] *)

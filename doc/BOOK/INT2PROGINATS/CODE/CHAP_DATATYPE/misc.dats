(*
** Some code used in the book INT2PROGINATS
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

(* ****** ****** *)

fun isWeekday
  (x: wday): bool = case x of
  | Monday() => true // the bar (|) is optional for the first clause
  | Tuesday() => true
  | Wednesday() => true
  | Thursday() => true
  | Friday() => true
  | Saturday() => false
  | Sunday() => false
// end of [isWeekday]

(* ****** ****** *)

fun isWeekday
  (x: wday): bool = case x of
  | Saturday() => false | Sunday() => false | _ => true
// end of [isWeekday]

(* ****** ****** *)

val () = assertloc (isWeekday(Monday))
val () = assertloc (isWeekday(Tuesday))
val () = assertloc (isWeekday(Wednesday))
val () = assertloc (isWeekday(Thursday))
val () = assertloc (isWeekday(Friday))
val () = assertloc (~isWeekday(Saturday))
val () = assertloc (~isWeekday(Sunday))

(* ****** ****** *)

datatype charlst =
  | charlst_nil of () | charlst_cons of (char, charlst)

(* ****** ****** *)

#define nil charlst_nil
#define :: charlst_cons

(* ****** ****** *)

val cs = 'a' :: 'b' :: 'c' :: nil ()

(* ****** ****** *)

fun charlst_last
  (cs: charlst): char =
(
  case cs of
  | charlst_cons (c, charlst_nil ()) => c
  | charlst_cons (_, cs1) => charlst_last (cs1)
) // end of [charlst_last]

val () = assertloc (charlst_last (cs) = 'c')

(* ****** ****** *)

fun charlst_last
  (cs: charlst): char =
(
  case cs of
  | charlst_cons (c, cs1) =>
    (
      case+ cs1 of
      | charlst_nil () => c
      | charlst_cons _ => charlst_last (cs1)
    ) // end of [char_cons]
) // end of [charlst_last]

val () = assertloc (charlst_last (cs) = 'c')

(* ****** ****** *)

fun charlst_last
  (cs: charlst): char = let
  val charlst_cons (c, cs1) = cs
in
  case+ cs1 of
  | charlst_nil () => c | charlst_cons _ => charlst_last (cs1)
end // end of [charlst_last]

val () = assertloc (charlst_last (cs) = 'c')

(* ****** ****** *)

implement main () = 0

(* ****** ****** *)

(* end of [misc.dats] *)

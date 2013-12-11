(*
** Constraint representation
** Constraint parsing from JSON format
*)

(* ****** ****** *)

datatype s2rt =
| S2RTint of ()
| S2RTaddr of ()
| S2RTbool of ()
| S2RTfun of ((*void*))
| S2RTtup of ((*void*))
| S2RTerr of ((*void*))

(* ****** ****** *)

abstype s2cst_type
typedef s2cst = s2cst_type

fun
compare_s2cst_s2cst (s2cst, s2cst): int
overload compare with compare_s2cst_s2cst

fun
fprint_s2cst (FILEref, s2cst): void
overload fprint with fprint_s2cst

(* ****** ****** *)

abstype s2var_type
typedef s2var = s2var_type

fun
compare_s2var_s2var (s2var, s2var): int
overload compare with compare_s2var_s2var

fun
fprint_s2var (FILEref, s2var): void
overload fprint with fprint_s2var

(* ****** ****** *)

datatype
s2exp_node =
| S2Ecst of (s2cst)
| S2Evar of (s2var)
// end of [s2exp_node]

where
s2exp = '{
  s2exp_srt= s2rt
, s2exp_node= s2exp_node
} (* end of [s2exp] *)

(* ****** ****** *)

fun
fprint_s2exp (FILEref, s2exp): void
overload fprint with fprint_s2exp

(* ****** ****** *)

(* end of [constraint.sats] *)

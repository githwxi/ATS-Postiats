(* ****** ****** *)
//
// For generating CATS/integer.cats
//
(* ****** ****** *)

(*
#define atspre_g0int2int_int_int(x) (x)
#define atspre_g0int2int_int_lint(x) ((atstype_lint)(x))
#define atspre_g0int2int_int_llint(x) ((atstype_llint)(x))
#define atspre_g0int2int_int_ssize(x) ((atstype_ssize)(x))
#define atspre_g1int2int_int_int atspre_g0int2int_int_int
#define atspre_g1int2int_int_lint atspre_g0int2int_int_lint
#define atspre_g1int2int_int_llint atspre_g0int2int_int_llint
#define atspre_g1int2int_int_ssize atspre_g0int2int_int_ssize
*)

(* ****** ****** *)
//
extern
fun{}
atspre_g0int2int_int_int
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_int(out) =
fprintln! (out, "\
atspre_g0int2int_int_int(x) (x)\
")
//
(* ****** ****** *)
//
extern
fun{}
atspre_g0int2int_int_lint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_lint(out) =
fprintln! (out, "\
atspre_g0int2int_int_lint(x) ((atstype_lint)(x))\
")
//
(* ****** ****** *)
//
extern
fun{}
atspre_g0int2int_int_llint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_llint(out) =
fprintln! (out, "\
atspre_g0int2int_int_llint(x) ((atstype_llint)(x))\
")
//
(* ****** ****** *)
//
extern
fun{}
atspre_g0int2int_int_ssize
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_ssize(out) =
fprintln! (out, "\
atspre_g0int2int_int_ssize(x) ((atstype_ssize)(x))\
")
//
(* ****** ****** *)

(* end of [integer_gen.dats] *)

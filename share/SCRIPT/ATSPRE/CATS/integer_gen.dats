(* ****** ****** *)
//
// For generating CATS/integer.cats
//
(* ****** ****** *)

(*
#define atspre_g0int2int_int_int(x) ((atstype_int)(x))
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
atspre_g0int2int_(out: FILEref): void
extern
fun{}
atspre_g0int2int_int_(out: FILEref): void
extern
fun{}
atspre_g0int2int_lint_(out: FILEref): void
extern
fun{}
atspre_g0int2int_ssize_(out: FILEref): void
//
extern
fun{}
atspre_g1int2int_(out: FILEref): void
extern
fun{}
atspre_g1int2int_int_(out: FILEref): void
extern
fun{}
atspre_g1int2int_lint_(out: FILEref): void
extern
fun{}
atspre_g1int2int_ssize_(out: FILEref): void
//
(* ****** ****** *)

implement
{}(*tmp*)
atspre_g0int2int_(out) =
{
//
val () = atspre_g0int2int_int_(out)
val () = atspre_g0int2int_lint_(out)
//
} (* end of [atspre_g0int2int_] *)

(* ****** ****** *)

implement
{}(*tmp*)
atspre_g1int2int_(out) =
{
//
val () = atspre_g1int2int_int_(out)
val () = atspre_g1int2int_lint_(out)
//
} (* end of [atspre_g1int2int_] *)

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
#define \
atspre_g0int2int_int_int(x) ((atstype_int)(x))\
")
//
extern
fun{}
atspre_g0int2int_int_lint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_lint(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_int_lint(x) ((atstype_lint)(x))\
")
//
extern
fun{}
atspre_g0int2int_int_llint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_llint(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_int_llint(x) ((atstype_llint)(x))\
")
//
extern
fun{}
atspre_g0int2int_int_ssize
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_int_ssize(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_int_ssize(x) ((atstype_ssize)(x))\
")
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atspre_g0int2int_int_(out) =
{
//
val () = atspre_g0int2int_int_int(out)
val () = atspre_g0int2int_int_lint(out)
val () = atspre_g0int2int_int_llint(out)
val () = atspre_g0int2int_int_ssize(out)
//
} (* end of [atspre_g0int2int_int_] *)
//
(* ****** ****** *)
//
extern
fun{}
atspre_g1int2int_int_int
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_int_int(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_int_int atspre_g0int2int_int_int\
") (* end of [atspre_g1int2int_int_int] *)
//
extern
fun{}
atspre_g1int2int_int_lint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_int_lint(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_int_lint atspre_g0int2int_int_lint\
") (* end of [fprintln! *)
//
extern
fun{}
atspre_g1int2int_int_llint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_int_llint(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_int_llint atspre_g0int2int_int_llint\
") (* end of [fprintln! *)
//
extern
fun{}
atspre_g1int2int_int_ssize
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_int_ssize(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_int_ssize atspre_g0int2int_int_ssize\
") (* end of [fprintln! *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atspre_g1int2int_int_(out) =
{
//
val () = atspre_g1int2int_int_int(out)
val () = atspre_g1int2int_int_lint(out)
val () = atspre_g1int2int_int_llint(out)
val () = atspre_g1int2int_int_ssize(out)
//
} (* end of [atspre_g1int2int_int_] *)
//
(* ****** ****** *)

(*
#define atspre_g0int2int_lint_int(x) ((atstype_int)(x))
#define atspre_g0int2int_lint_lint(x) ((atstype_lint)(x))
#define atspre_g0int2int_lint_llint(x) ((atstype_llint)(x))
#define atspre_g0int2int_lint_ssize(x) ((atstype_ssize)(x))
#define atspre_g1int2int_lint_int atspre_g0int2int_lint_int
#define atspre_g1int2int_lint_lint atspre_g0int2int_lint_lint
#define atspre_g1int2int_lint_llint atspre_g0int2int_lint_llint
#define atspre_g1int2int_lint_ssize atspre_g0int2int_lint_ssize
*)

(* ****** ****** *)
//
extern
fun{}
atspre_g0int2int_lint_int
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_lint_int(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_lint_int(x) ((atstype_int)(x))\
")
//
extern
fun{}
atspre_g0int2int_lint_lint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_lint_lint(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_lint_lint(x) ((atstype_lint)(x))\
")
//
extern
fun{}
atspre_g0int2int_lint_llint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_lint_llint(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_lint_llint(x) ((atstype_llint)(x))\
")
//
extern
fun{}
atspre_g0int2int_lint_ssize
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g0int2int_lint_ssize(out) =
fprintln! (out, "\
#define \
atspre_g0int2int_lint_ssize(x) ((atstype_ssize)(x))\
")
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atspre_g0int2int_lint_(out) =
{
//
val () = atspre_g0int2int_lint_int(out)
val () = atspre_g0int2int_lint_lint(out)
val () = atspre_g0int2int_lint_llint(out)
val () = atspre_g0int2int_lint_ssize(out)
//
} (* end of [atspre_g0int2int_lint_] *)
//
(* ****** ****** *)
//
extern
fun{}
atspre_g1int2int_lint_int
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_lint_int(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_lint_int atspre_g0int2int_lint_int\
") (* end of [fprintln! *)
//
extern
fun{}
atspre_g1int2int_lint_lint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_lint_lint(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_lint_lint atspre_g0int2int_lint_lint\
") (* end of [fprintln! *)
//
extern
fun{}
atspre_g1int2int_lint_llint
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_lint_llint(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_lint_llint atspre_g0int2int_lint_llint\
") (* end of [fprintln! *)
//
extern
fun{}
atspre_g1int2int_lint_ssize
  (out: FILEref): void
implement
{}(*tmp*)
atspre_g1int2int_lint_ssize(out) =
fprintln! (out, "\
#define \
atspre_g1int2int_lint_ssize atspre_g0int2int_lint_ssize\
") (* end of [fprintln! *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
atspre_g1int2int_lint_(out) =
{
//
val () = atspre_g1int2int_lint_int(out)
val () = atspre_g1int2int_lint_lint(out)
val () = atspre_g1int2int_lint_llint(out)
val () = atspre_g1int2int_lint_ssize(out)
//
} (* end of [atspre_g1int2int_lint_] *)
//
(* ****** ****** *)
//
extern
fun
{}(*tmp*)
integer_gen_main(out: FILEref): void
//
(* ****** ****** *)

implement
{}(*tmp*)
integer_gen_main(out) =
{
//
val () = atspre_g0int2int_(out)
val () = atspre_g1int2int_(out)
//
} (* end of [integer_gen_main] *)

(* ****** ****** *)

(* end of [integer_gen.dats] *)

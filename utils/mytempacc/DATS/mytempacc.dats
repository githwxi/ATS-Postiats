(* ****** ****** *)
(*
HX-2019-06-03:
[mytempacc] provides
default options to [tempacc]
*)
(* ****** ****** *)
//
(*
Here is the "logic":
//
If -DATS_MEMALLOC-* is missing:
-DATS_MEMALLOC_LIBC is chosen if -lgc is missing
-DATS_MEMALLOC_GCBDW is chosen if -lgc is present
//
If -dry or --dryrun is present:
the generated command-line is printed out but not executed
//
*)
//
(* ****** ****** *)

#include
"share/HATS\
/temptory_staload_bucs320.hats"

(* ****** ****** *)

typedef
stringlst = list0(string)

(* ****** ****** *)
//
extern
fun
flag1_exists
(xs: stringlst, x0: string): bool
extern
fun
flag2_exists
(xs: stringlst, x0: string, x1: string): bool
//
(* ****** ****** *)

implfun
flag1_exists
  (xs, x0) =
(
case+ xs of
| list0_nil() => false
| list0_cons(x1, xs) =>
  if
  (x0 = x1)
  then true else flag1_exists(xs, x0)
)

(* ****** ****** *)

implfun
flag2_exists
  (xs, x0, x1) =
(
case+ xs of
| list0_nil() => false
| list0_cons(x2, xs2) =>
  if
  (x0 = x2)
  then
  (
  case+ xs of
  | list0_nil() => false
  | list0_cons(x3, xs3) =>
    if
    (x1 = x3)
    then true
    else flag2_exists(xs2, x0, x1)
  ) else flag2_exists(xs2, x0, x1)
) (* end of [flag2_exists] *)

(* ****** ****** *)

local
//
val r_out = ref<int>(0)
val r_lgc = ref<int>(0)
val r_dry = ref<int>(0)
//
val r_ccats = ref<int>(0)
val r_tcats = ref<int>(0)
//
val r_DATS_MEMALLOC = ref<int>(0)
val r_DATS_MEMALLOC_USER = ref<int>(0)
val r_DATS_MEMALLOC_LIBC = ref<int>(0)
val r_DATS_MEMALLOC_GCBDW = ref<int>(0)
//
in (* in-of-local *)

(* ****** ****** *)

fun
out_set
(args: stringlst): void =
if
flag1_exists
(args, "-o") then r_out[] := 1 else ()

fun
lgc_set
(args: stringlst): void =
if
flag1_exists
(args, "-lgc") then r_lgc[] := 1 else ()

(* ****** ****** *)

fun
dry_set
(args: stringlst): void =
if
flag1_exists
(args, "-dry") then r_dry[] := 1
else
(
if
flag1_exists
(args, "--dryrun") then r_dry[] := 1 else ()
)

(* ****** ****** *)

fun
ccats_set
(args: stringlst): void =
if
flag1_exists
(args, "-ccats") then r_ccats[] := 1 else ()
fun
tcats_set
(args: stringlst): void =
if
flag1_exists
(args, "-tcats") then r_tcats[] := 1 else ()

(* ****** ****** *)

fun
DATS_MEMALLOC_set() =
(
 r_DATS_MEMALLOC[] :=
 r_DATS_MEMALLOC_USER[]
 +
 r_DATS_MEMALLOC_LIBC[]
 +
 r_DATS_MEMALLOC_GCBDW[]
)

(* ****** ****** *)

fun
DATS_MEMALLOC_USER_set
(args: stringlst): void =
if
flag1_exists
(args, "-DATS_MEMALLOC_USER")
then
r_DATS_MEMALLOC_USER[] := 1
else
(
if
flag2_exists
(args, "-D", "ATS_MEMALLOC_USER")
then r_DATS_MEMALLOC_USER[] := 1 else ()
)

fun
DATS_MEMALLOC_LIBC_set
(args: stringlst): void =
if
flag1_exists
(args, "-DATS_MEMALLOC_LIBC")
then
r_DATS_MEMALLOC_LIBC[] := 1
else
(
if
flag2_exists
(args, "-D", "ATS_MEMALLOC_LIBC")
then r_DATS_MEMALLOC_LIBC[] := 1 else ()
)

fun
DATS_MEMALLOC_GCBDW_set
(args: stringlst): void =
if
flag1_exists
(args, "-DATS_MEMALLOC_GCBDW")
then
r_DATS_MEMALLOC_GCBDW[] := 1
else
(
if
flag2_exists
(args, "-D", "ATS_MEMALLOC_GCBDW")
then r_DATS_MEMALLOC_GCBDW[] := 1 else ()
)

(* ****** ****** *)

fun
dry_q(): bool = (r_dry[] > 0)
fun
ccats_q(): bool = (r_ccats[] > 0)
fun
tcats_q(): bool = (r_tcats[] > 0)

(* ****** ****** *)

local

fun
helper0
( args
: stringlst): void =
{
//
val () = out_set(args)
val () = lgc_set(args)
//
val () = dry_set(args)
//
val () = ccats_set(args)
val () = tcats_set(args)
//
val () =
(
DATS_MEMALLOC_set()
) where
{
val () =
DATS_MEMALLOC_USER_set(args)
val () =
DATS_MEMALLOC_LIBC_set(args)
val () =
DATS_MEMALLOC_GCBDW_set(args)
}
//
} (* end of [helper0] *)

fun
helper1
( args
: stringlst): stringlst =
( args ) where
{
val args =
(
if
(r_DATS_MEMALLOC[] > 0)
then args
else
(
if
(r_lgc[] = 0)
then
list0_cons
("-DATS_MEMALLOC_LIBC", args)
else
list0_cons
("-DATS_MEMALLOC_GCBDW", args)
)
) : stringlst
} (* end of [helper1] *)

in (* in-of-local *)

fun
myprocess_args
( args
: stringlst): stringlst =
(
ifcase
| ccats_q() => args
| tcats_q() => args
| _(*else*) =>
  let val () = helper0(args) in helper1(args) end
)

fun
usage(): void =
{
val () =
println!("Usage: mytempacc [FLAG] [FILE]")
val () =
println!("The following options are supported:")
val () =
println!("  -dry/--dryrun: for command generation only")
}

end // end of [local]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

%{^
#include <unistd.h>
%} (* %{^ *)

(*
int
execvp
(const char *file, char *const argv[]);
*)
implfun
main1
(argc, argv) =
let
//
val () =
(
if
argc = 1
then
(usage(); exit(1))
) // end of val
//
val
arg0 = "tempacc"
//
val
args =
list1_vt2t
(listize(argc, argv))
val
args =
g0ofg1(list1_tail(args))
//
val
args =
myprocess_args(args)
//
(*
val () =
println!("args = ", args)
*)
//
in (*in-of-let*)
//
if
dry_q()
then
(
(
0 // SUCCESS!
) where
{
//
val () =
(
print(arg0);
list0_foreach<x0>(args)
)
val () = println!()
}
) where
{
typedef x0 = string
impltmp
list0_foreach$work<x0>(x0) =
ifcase
//
| (x0 = "-dry") => ()
| (x0 = "--dryrun") => ()
//
| _(*else*) =>
   (print!(" "); print(x0))
}
else
(
  $extfcall(int, "execvp", arg0, argv)
) where
{
val
argc =
list0_length(args) + 2
val
argv =
$UN.calloc<string>(argc)
val () =
$UN.cptr0_set(argv, arg0)
//
val cp =
(
list0_foldleft<x0><r0>(args, succ(argv))
) where
{
  typedef x0 = string
  typedef r0 = cptr(string)
  impltmp
  list0_foldleft$fopr<x0><r0>(r0, x0) = ($UN.cptr0_set(r0, x0); succ(r0))
}
} (* end of [else] *)
//
end (* end of [main0] *)

(* ****** ****** *)

(* end of [mytempacc.dats] *)

(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start time: June, 2015
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
STDIO =
"libats/libc/SATS/stdio.sats"
//
(* ****** ****** *)
//
#define
PATSOLVE_targetloc "./../ATS-extsolve"
//
#staload
"{$PATSOLVE}/SATS/patsolve_cnstrnt.sats"
#staload
"{$PATSOLVE}/SATS/patsolve_parsing.sats"
//
(* ****** ****** *)

#staload "./../SATS/patsolve_z3_commarg.sats"
#staload "./../SATS/patsolve_z3_solving.sats"

(* ****** ****** *)

implement
fprint_commarg(out, ca) = (
//
case+ ca of
//
| CAhelp(str) => fprint! (out, "CAhelp(", str, ")")
//
| CAgitem(str) => fprint! (out, "CAgitem(", str, ")")
//
| CAinput(str) => fprint! (out, "CAinput(", str, ")")
//
| CAoutput(str) => fprint! (out, "CAoutput(", str, ")")
//
| CAscript(str) => fprint! (out, "CAscript(", str, ")")
//
| CAargend((*void*)) => fprint! (out, "CAargend(", ")")
//
) (* end of [fprint_commarg] *)

(* ****** ****** *)

fun{
} argv_getopt_at
  {n:int}{i:nat}
(
  n: int n, argv: !argv(n), i: int i
) : stropt =
(
//
if i < n
  then stropt_some (argv[i]) else stropt_none ()
// end of [if]
//
) (* end of [argv_getopt_at] *)

(* ****** ****** *)

implement
patsolve_z3_cmdline
  (argc, argv) = let
//
vtypedef
res_vt = commarglst_vt
//
fun
aux
{n:int}
{i:nat | i <= n}
(
  argc: int n
, argv: !argv(n)
, i: int i, res0: res_vt
) : res_vt = let
in
//
if
i < argc
then let
//
val arg = argv[i]
//
in
//
case+ arg of
//
| "-h" => let
    val ca =
      CAhelp(arg)
    val res0 =
      cons_vt(ca, res0)
    // end of [val]
  in
    aux(argc, argv, i+1, res0)
  end // end of ...
| "--help" => let
    val ca =
      CAhelp(arg)
    val res0 =
      cons_vt(ca, res0)
    // end of [val]
  in
    aux(argc, argv, i+1, res0)
  end // end of ...
//
| "-i" => let
    val ca =
      CAinput(arg)
    val res0 =
      cons_vt(ca, res0)
    // end of [val]
  in
    aux2(argc, argv, i+1, res0)
  end // end of ...
| "--input" => let
    val ca =
      CAinput(arg)
    val res0 =
      cons_vt(ca, res0)
    // end of [val]
  in
    aux2(argc, argv, i+1, res0)
  end // end of ...
//
| _ (*rest*) => let
    val ca =
      CAgitem(arg)
    val res0 =
      cons_vt(ca, res0)
    // end of [val]
  in
    aux(argc, argv, i+1, res0)
  end // end of [...]
//
end // end of [then]
else res0 // end of [else]
//
end // end of [aux]
//
and
aux2
{n:int}
{i:nat | i <= n}
(
  argc: int n
, argv: !argv(n)
, i: int i, res0: res_vt
) : res_vt = let
in
//
if
i < argc
then let
//
val arg = argv[i]
//
val ca =
  CAgitem(arg)
val res0 =
  cons_vt(ca, res0)
// end of [val]
in
  aux(argc, argv, i+1, res0)
end // end of [then]
else res0 // end of [else]
//
end // end of [aux2]
//
val args = aux(argc, argv, 0, nil_vt)
//
in
//
list_vt_reverse(list_vt_cons(CAargend(), args))
//
end // end of [patsolve_z3_cmdline]

(* ****** ****** *)
//
extern fun patsolve_z3_help(): void
extern fun patsolve_z3_input(): void
extern fun patsolve_z3_gitem(string): void
extern fun patsolve_z3_input_arg(string): void
//
extern fun patsolve_z3_argend((*void*)): void
//
extern fun patsolve_z3_commarglst_finalize(): void
//
(* ****** ****** *)

typedef
state_struct =
@{
//
  nerr= int
//
, input= int
//
, ninput= int
//
, fopen_inp= int
, inpfil_ref= FILEref
//
} (* end of [state_struct] *)

(* ****** ****** *)

local
//
var
the_state: state_struct?
//
val () = the_state.nerr := 0
//
val () = the_state.input := 0
val () = the_state.ninput := 0
//
val () = the_state.fopen_inp := 0
val () = the_state.inpfil_ref := stdin_ref
//
in (* in-of-local *)
//
val
the_state
  : ref(state_struct) =
  ref_make_viewptr(view@the_state | addr@the_state)
//
end // end of [local]

(* ****** ****** *)

fun
process_arg
  (x: commarg): void = let
//
(*
val () =
fprintln!
(
  stdout_ref
, "patsolve_z3_commarglst: process_arg: x = ", x
) (* end of [val] *)
*)
//
in
//
case+ x of
//
| CAhelp _ => patsolve_z3_help ()
//
| CAinput _ => patsolve_z3_input ()
//
| CAgitem(str) => patsolve_z3_gitem(str)
//
(*
| CAoutput(str) => fprint! (out, "CAoutput(", str, ")")
| CAscript(str) => fprint! (out, "CAscript(", str, ")")
*)
| CAargend() => patsolve_z3_argend ()
//
| _ (*rest-of-CA*) => ()
//
end // end of [process_arg]

(* ****** ****** *)

implement
patsolve_z3_commarglst
  (xs) = let
(*
val () = println! ("patsolve_z3_commarglst")
*)
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = process_arg(x)
  in
    patsolve_z3_commarglst (xs)
  end // end of [list_vt_cons]
//
| ~list_vt_nil
    ((*void*)) => patsolve_z3_commarglst_finalize ()
  // end of [list_vt_nil]
//
end // end of [patsolve_z3_commarglst]

(* ****** ****** *)

implement
patsolve_z3_help() = let
//
val out = stdout_ref
val cmdname = "patsolve_z3"
//
in
//
fprintln!
  (out, "Usage: ", cmdname, " <command> ... <command>\n");
fprintln!
  (out, "where a <command> is of one of the following forms:\n");
//
fprintln! (out, "  -h (for printing out this help usage)");
fprintln! (out, "  -i <filename> (input from <filename>)");
//
fprintln! (out);
//
fprintln! (out, "  --help (for printing out this help usage)");
//
fprintln! (out, "  --input <filename> (input from <filename>)");
//
fprintln! (out);
//
end (* end of [patsolve_z3_help] *)

(* ****** ****** *)

implement
patsolve_z3_input() =
{
//
(*
val () =
prerrln!
  ("patsolve_z3_input: ...")
*)
//
val () = !the_state.input := 1
//
} (* end of [patsolve_z3_input] *)

(* ****** ****** *)

implement
patsolve_z3_gitem(arg) = let
(*
//
val () =
prerrln!
(
"patsolve_z3_gitem: arg = ", arg
) (* println! *)
//
*)
macdef
input() = (!the_state.input > 0)
//
in
//
case+ 0 of
| _ when input() =>
  {
    val () = patsolve_z3_input_arg(arg)
    val () = !the_state.ninput := !the_state.ninput+1
  } (* _ when input() *)
| _ (*unrecognized*) => ()
//
end (* end of [patsolve_z3_gitem] *)

(* ****** ****** *)

local

fun
auxmain
(
  path: string
) : void = let
//
val
opt =
fileref_open_opt(path, file_mode_r)
//
in
//
case+ opt of
| ~Some_vt(filr) =>
  {
//
    val n0 = !the_state.fopen_inp
    val () = !the_state.fopen_inp := 1
//
    val f0 = !the_state.inpfil_ref
    val () = if n0 > 0 then fileref_close(f0)
    val () = !the_state.inpfil_ref := filr
//
    val c3t0 =
      parse_fileref_constraints(filr)
    // end of [val]
//
(*
    val () =
    fprint! (
      stdout_ref
    , "patsolve_z3_input_arg: c3t0 =\n"
    ) (* end of [fprint] *)
    val () = fpprint_c3nstr(stdout_ref, c3t0)
    val () = fprint_newline (stdout_ref)
*)
//
    val ((*void*)) = c3nstr_z3_solve(c3t0)
//
  } (* end of [Some_vt] *)
//
| ~None_vt((*void*)) =>
  {
//
    val n0 = !the_state.fopen_inp
    val () = !the_state.fopen_inp := 0
//
    val f0 = !the_state.inpfil_ref
    val () = if n0 > 0 then fileref_close(f0)
    val () = !the_state.inpfil_ref := stdin_ref
//
    val () =
    prerrln!
      ("The file [", path, "] cannot be opened for read!")
    // end of [val]
//
  } (* end of [None_vt] *)
//
end // end of [auxmain]

in (* in-of-local *)

implement
patsolve_z3_input_arg
  (path) =
(
//
case+ path of
| "-" =>
  {
    val inp = stdin_ref
    val c3t0 =
      parse_fileref_constraints(inp)
    // end of [val]
    val ((*void*)) = c3nstr_z3_solve(c3t0)
  }
| _(* ... *) => auxmain(path)
//
) (* end of [patsolve_z3_input_arg] *)

end // end of [local]

(* ****** ****** *)

implement
patsolve_z3_argend
  ((*void*)) = let
//
macdef
mytest() =
if !the_state.input > 0
  then !the_state.ninput = 0 else false
// end of [mytest]
(* end of [macdef] *)
//
in
//
case+ 0 of
| _ when
    mytest() =>
  {
    val inp = stdin_ref
    val c3t0 =
    parse_fileref_constraints(inp)
    val ((*void*)) = c3nstr_z3_solve(c3t0)
  }
| _ (*rest*) => ((*ignored*))
//
end (* end of [patsolve_z3_argend] *)

(* ****** ****** *)

implement
patsolve_z3_commarglst_finalize
  ((*void*)) =
{
  val n0 = !the_state.fopen_inp
  val f0 = !the_state.inpfil_ref
  val () = if n0 > 0 then fileref_close(f0)
} (* end of [patsolve_z3_commarglst_finalize] *)

(* ****** ****** *)

(* end of [patsolve_z3_commarg.dats] *)

(* ****** ****** *)
//
// Atscc2scm:
// from ATS to Scheme
//
(* ****** ****** *)
//
// HX-2016-05-19: start
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#define
ATS_DYNLOADNAME"libatscc2scm_dynload"
//
(* ****** ****** *)
//
staload
STDIO = "{$PATSLIBATSLIBC}/SATS/stdio.sats"
//
(* ****** ****** *)
//
#if
defined
(
CATSPARSEMIT_targetloc
)
#then
#else
//
#define
CATSPARSEMIT_targetloc
"./../CATS-parsemit"
//
#endif // end of [ifdef]
//
(* ****** ****** *)
//
#staload
"{$CATSPARSEMIT}/SATS/catsparse.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_emit.sats"
#staload
"{$CATSPARSEMIT}/SATS/catsparse_parsing.sats"
//
(* ****** ****** *)
//
val () =
catsparse_all_dynload() where
{
extern
fun
catsparse_all_dynload(): void = "ext#"
} (* end of [val] *)
//
val () =
catsparse_mylib_dynload() where
{
extern
fun
catsparse_mylib_dynload(): void = "ext#"
} (* end of [val] *)
//
(* ****** ****** *)

#dynload "./atscc2scm_emit.dats"
#dynload "./atscc2scm_emit2.dats"

(* ****** ****** *)
//
datatype
comarg =
COMARGkey of (int, string)
//
typedef comarglst = List0 (comarg)
//
(* ****** ****** *)

datatype
waitkind =
  | WTKnone of ()
  | WTKinput of ()
  | WTKoutput of () // -o / --output
// end of [waitkind]

(* ****** ****** *)

datatype OUTCHAN =
  | OUTCHANref of (FILEref) | OUTCHANptr of (FILEref)
// end of [OUTCHAN]

fun
outchan_get_fileref
  (x: OUTCHAN): FILEref =
(
//
case+ x of
| OUTCHANref (filr) => filr | OUTCHANptr (filp) => filp
//
) (* end of [outchan_get_fileref] *)

(* ****** ****** *)

typedef
cmdstate = @{
  comarg0= comarg
, ncomarg= int // number of arguments
, waitkind= waitkind
// number of processed input files;
, ninputfile= int // waiting for STDIN if it is 0
, outchan= OUTCHAN // current output channel
, nerror= int // number of accumulated errors
} (* end of [cmdstate] *)

(* ****** ****** *)

fun
cmdstate_set_outchan
(
  state: &cmdstate >> _, chan_new: OUTCHAN
) : void = let
//
val chan_old = state.outchan
val ((*void*)) = state.outchan := chan_new
//
in
//
case+
chan_old of
| OUTCHANref (filr) => ()
| OUTCHANptr (filp) => let
    val err = $STDIO.fclose0 (filp) in (*nothing*)
  end // end of [OUTCHANptr]
//
end // end of [cmdstate_set_outchan]

(* ****** ****** *)
//
extern
fun
atscc2scm_fileref
  (state: &cmdstate >> _, filr: FILEref): void
//
implement
atscc2scm_fileref
  (state, inp) = let
//
val oc = state.outchan
val out = outchan_get_fileref (oc)
//
val d0cs = parse_from_fileref (inp)
//
val () = emit_time_stamp (out)
//
val ((*void*)) = emit_toplevel (out, d0cs)
//
val () = emit_text (out, ";;;;;;\n")
val () = emit_text (out, ";;\n")
val () = emit_text (out, ";; end-of-compilation-unit")
val () = emit_text (out, "\n;;")
val () = emit_text (out, "\n;;;;;;")
//
val ((*flusing*)) = emit_newline (out)
//
in
  // nothing
end // end of [atscc2scm_fileref]

(* ****** ****** *)
//
macdef fopen = $STDIO.fopen
//
extern
fun
atscc2scm_basename
(
  state: &cmdstate >> _, fname: string
) : void // end-of-fun
//
implement
atscc2scm_basename
  (state, fname) = let
//
val inp =
  fopen (fname, file_mode_r)
//
val p_inp = $STDIO.ptrcast(inp)
//
in
//
if
p_inp > 0
then let
//
val inp =
  $UNSAFE.castvwtp0{FILEref}(inp)
val ((*void*)) =
  the_filename_push(filename_make(fname))
//
in
  atscc2scm_fileref (state, inp)
end // end of [then]
else let
//
prval
(
// freed
) = $STDIO.FILEptr_free_null (inp)
val ((*void*)) = state.nerror := state.nerror + 1
//
in
  // nothing
end // end of [else]
//
end // end of [atscc2scm_basename]

(* ****** ****** *)

fun
cmdstate_set_outchan_basename
(
  state: &cmdstate >> _, basename: string
) : void = let
//
val filp =
  $STDIO.fopen (basename, file_mode_w)
val p0 = $STDIO.ptrcast(filp)
//
(*
val () = println! ("cmdstate_set_outchan_basename: p0 = ", p0)
*)
//
in
//
if
p0 > 0
then let
  val filp = $UNSAFE.castvwtp0{FILEref}(filp)
in
  cmdstate_set_outchan (state, OUTCHANptr (filp))
end // end of [then]
else let
  prval
  ( // freed
  ) = $STDIO.FILEptr_free_null (filp)
  val ((*void*)) = state.nerror := state.nerror + 1
in
  cmdstate_set_outchan (state, OUTCHANref (stderr_ref))
end // end of [else]
//
end // end of [cmdstate_set_outchan_basename]

(* ****** ****** *)
//
fn isinwait
  (state: cmdstate): bool =
(
  case+ state.waitkind of WTKinput () => true | _ => false
) (* end of [isinwait] *)
//
fn isoutwait
  (state: cmdstate): bool =
(
  case+ state.waitkind of WTKoutput () => true | _ => false
) (* end of [isoutwait] *)
//
(* ****** ****** *)
//
extern
fun
comarg_warning (string): void
//
implement
comarg_warning (str) = {
  val () = prerr ("waring(ATS)")
  val () = prerr (": unrecognized command line argument [")
  val () = prerr (str)
  val () = prerr ("] is ignored.")
  val () = prerr_newline ()
} (* end of [comarg_warning] *)
//
(* ****** ****** *)
  
fun
atscc2scm_usage
  (cmd: string): void = {
//
val () =
println!
(
  "Usage: ", cmd, " <command> ... <command>\n"
)
val () =
println!
(
  "where each <command> is of one of the following forms:\n"
)
//
val () =
println! ("  -i <filename> : for processing <filename>")
val () =
println! ("  --input <filename> : for processing <filename>")
//
val () =
println! ("  -o <filename> : output into <filename>")
val () =
println! ("  --output <filename> : output into <filename>")
//
val () =
println! ("  -h : for printing out this help usage")
val () =
println! ("  --help : for printing out this help usage")
//
} (* end of [atscc2scm_usage] *)
  
(* ****** ****** *)

fun
process_cmdline
(
  state: &cmdstate, arglst: comarglst
) : void = let
in
//
case+ arglst of
//
| list_nil () => let
    val nif = state.ninputfile
    val wait0 =
    (
      case+ 0 of
      | _ when nif < 0 => true
      | _ when nif = 0 => isinwait (state)
      | _ (* nif > 0 *) => false
    ) : bool // end of [val]

  in
    if wait0 then (
      if state.ncomarg = 0
        then atscc2scm_usage ("atscc2scm")
        else atscc2scm_fileref (state, stdin_ref)
    ) (* end of [if] *)
  end // end of [list_nil]
//
| list_cons
    (arg, arglst) => let
    val () =
      state.ncomarg := state.ncomarg + 1
    // end of [val]
  in
    process_cmdline2 (state, arg, arglst)
  end // end of [list_cons]
//
end // end of [process_cmdline]

and
process_cmdline2
(
  state: &cmdstate, arg: comarg, arglst: comarglst
) : void = let
in
//
case+ arg of
//
| _ when
    isinwait(state) => let
    val nif = state.ninputfile
  in
    case+ arg of
    | COMARGkey (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1 (state, arglst, key)
    | COMARGkey (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2 (state, arglst, key)
    | COMARGkey (_, fname) => let
        val () = state.ninputfile := nif + 1
        val () = atscc2scm_basename (state, fname(*input*))
      in
        process_cmdline (state, arglst)
      end // end of [COMARGkey]
  end // end of [_ when isinpwait]
//
| _ when
    isoutwait(state) => let
//
    val COMARGkey (_, fname) = arg
//
    val () = cmdstate_set_outchan_basename (state, fname)
//
    val () = state.waitkind := WTKnone ()
//
  in
    process_cmdline (state, arglst)
  end // end of [_ when isoutwait]
//
| COMARGkey (1, key) =>
    process_cmdline2_COMARGkey1 (state, arglst, key)
| COMARGkey (2, key) =>
    process_cmdline2_COMARGkey2 (state, arglst, key)
//
| COMARGkey (_, key) => let
    val () = comarg_warning (key)
    val () = state.waitkind := WTKnone ()
  in
    process_cmdline (state, arglst)
  end // end of [COMARGkey]
//
end // end of [process_cmdline2]

and
process_cmdline2_COMARGkey1
(
  state: &cmdstate >> _, arglst: comarglst, key: string
) : void = let
//
val () = (
//
case+ key of
//
| "-i" => {
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput()
  } (* end of [-i] *)
//
| "-o" => {
    val () = state.waitkind := WTKoutput ()
  } (* end of [-o] *)
//
| "-h" => {
    val () = atscc2scm_usage ("atscc2scm")
    val () = state.waitkind := WTKnone(*void*)
    val () = if state.ninputfile < 0 then state.ninputfile := 0
  } (* end of [-h] *)
//
| _ (*unrecognized*) => comarg_warning (key)
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey1]

and
process_cmdline2_COMARGkey2
(
  state: &cmdstate >> _, arglst: comarglst, key: string
) : void = let
//
val () = state.waitkind := WTKnone ()
//
val () = (
//
case+ key of
//
| "--input" => {
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput()
  } (* end of [--input] *)
//
| "--output" => {
    val () = state.waitkind := WTKoutput ()
  } (* end of [--output] *)
//
| "--help" => {
    val () = atscc2scm_usage ("atscc2scm")
    val () = state.waitkind := WTKnone(*void*)
    val () = if state.ninputfile < 0 then state.ninputfile := 0
  } (* end of [--help] *)
//
| _ (*unrecognized*) => comarg_warning (key)
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey2]

(* ****** ****** *)
//
extern
fun
comarg_parse (string):<> comarg
//
extern
fun
comarglst_parse{n:nat}
  (argc: int n, argv: !argv(n)): list (comarg, n)
// end of [comarglst_parse]
//
(* ****** ****** *)

implement
comarg_parse
  (str) = let
//
fun
loop
{n,i:nat | i <= n} .<n-i>.
(
  str: string n, n: int n, i: int i
) :<> comarg = 
(
  if i < n
    then (
    if (str[i] != '-')
      then COMARGkey (i, str) else loop (str, n, i+1)
    ) else COMARGkey (n, str)
) (* end of [if] *)  
// end of [loop]
//
val str = g1ofg0(str)
val len = string_length (str)
//
in
  loop (str, sz2i(len), 0)
end // end of [comarg_parse]

(* ****** ****** *)

implement
comarglst_parse
  {n}(argc, argv) = let
//
fun
loop
{i,j:nat | i <= n} .<n-i>.
(
  argv: !argv(n), i: int(i), res: list_vt(comarg, j)
) : list_vt (comarg, n-i+j) =
(
//
if i < argc
  then let
    val res = list_vt_cons (comarg_parse (argv[i]), res)
  in
    loop (argv, i+1, res)
  end // end of [then]
  else res // end of [else]
// end of [if]
) (* end of [loop] *)
//
val res =
  loop (argv, 0, list_vt_nil())
//
in
  list_vt2t (list_vt_reverse (res))
end // end of [comarglst_parse]

(* ****** ****** *)
//
extern
fun
atscc2scm_main0
  {n:pos}
(
  argc: int(n), argv: !argv(n)
) : void =
  "ext#libatscc2scm_atscc2scm_main0"
//
implement
atscc2scm_main0
  (argc, argv) = () where
{
//
val () =
prerrln!
(
  "Hello from atscc2scm!"
) (* end of [val] *)
//
//
val arglst =
  comarglst_parse (argc, argv)
//
val+list_cons (arg0, arglst) = arglst
//
var
state = @{
  comarg0= arg0
, ncomarg= 0 // counting from 0
, waitkind= WTKnone ()
// number of prcessed
, ninputfile= ~1 // input files
, outchan= OUTCHANref (stdout_ref)
, nerror= 0 // number of accumulated errors
} : cmdstate // end of [var]
//
val () = process_cmdline (state, arglst)
//
val () =
if
state.nerror = 1
then let
  val () =
  prerrln! ("atscc2scm: there is a reported error.")
in
  // nothing
end // end of [then]
else if
state.nerror >= 2
then let
  val () =
  prerrln! ("atscc2scm: there are some reported errors.")
in
  // nothing
end // end of [then]
else () // end of [else]
//
(*
val () =
prerrln! ("Good-bye from atscc2scm!")
*)
//
} (* end of [atscc2scm_main0] *)

(* ****** ****** *)

#ifndef
ATSCC2SCM_MAIN_NONE
//
implement
main0 (argc, argv) =
{
//
val () = atscc2scm_main0(argc, argv)
//
} (* end of [main0] *)
//
#endif // ifndef(ATSCC2SCM_MAIN_NONE)

(* ****** ****** *)

(* end of [atscc2scm_main.dats] *)

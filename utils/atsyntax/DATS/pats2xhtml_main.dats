(*
**
** for highlighting/xreferencing ATS2 code
** Author: Hongwei Xi (hwxi AT gmhwxi DOT com)
**
*)

(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload SYM = "src/pats_symbol.sats"
staload FIL = "src/pats_filename.sats"

(* ****** ****** *)

staload "../SATS/pats2xhtml.sats"

(* ****** ****** *)

(*
** HX-2012-06:
** prfexp: text-decoration: line-through for erasure?
*)
#define PSYNMARK_HTML_FILE_BEG "\
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n\
\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n\
<html xmlns=\"http://www.w3.org/1999/xhtml\">\n\
<head>\n\
  <title></title>\n\
  <meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>\n\
  <style type=\"text/css\">\n\
    .patsyntax {color:#808080;background-color:#E0E0E0;}\n\
    .patsyntax span.keyword {color:#000000;font-weight:bold;}\n\
    .patsyntax span.comment {color:#787878;font-style:italic;}\n\
    .patsyntax span.extcode {color:#A52A2A;}\n\
    .patsyntax span.neuexp  {color:#800080;}\n\
    .patsyntax span.staexp  {color:#0000F0;}\n\
    .patsyntax span.prfexp  {color:#603030;}\n\
    .patsyntax span.dynexp  {color:#F00000;}\n\
    .patsyntax span.stalab  {color:#0000F0;font-style:italic}\n\
    .patsyntax span.dynlab  {color:#F00000;font-style:italic}\n\
    .patsyntax span.dynstr  {color:#008000;font-style:normal}\n\
    .patsyntax span.stacstdec  {text-decoration:none;}\n\
    .patsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}\n\
    .patsyntax span.dyncstdec  {text-decoration:none;}\n\
    .patsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}\n\
    .patsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}\n\
  </style>\n\
</head>\n\
<body class=\"patsyntax\">\n\
" // end of [PSYNMARK_HTML_FILE_BEG]

#define PSYNMARK_HTML_FILE_END "\
</body>\n\
</html>\n\
" // end of [PSYNMARK_HTML_FILE_END]

(* ****** ****** *)

fun pats2xhtml_file_beg
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_FILE_BEG)
fun pats2xhtml_file_end
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_FILE_END)

(* ****** ****** *)

#define PSYNMARK_HTML_PRE_BEG "<pre class=\"patsyntax\">\n"
#define PSYNMARK_HTML_PRE_END "</pre>\n"

fun pats2xhtml_pre_beg
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_PRE_BEG)
fun pats2xhtml_pre_end
  (out: FILEref): void = 
  fprint_string (out, PSYNMARK_HTML_PRE_END)

(* ****** ****** *)
//
staload "src/pats_comarg.sats"
//
viewtypedef comarglst (n: int) = list_vt (comarg, n)
//
(* ****** ****** *)

datatype
waitkind =
  | WTKnone of ()
  | WTKinput_sta of () // -s ...
  | WTKinput_dyn of () // -d ...
  | WTKoutput of () // -o ...
  | WTKdefine of () // -DATS ...
  | WTKinclude of () // -IATS ...
// end of [waitkind]

fn waitkind_get_stadyn
  (knd: waitkind): int =
  case+ knd of
  | WTKinput_sta () => 0
  | WTKinput_dyn () => 1
  | _ => ~1 // this is not a valid input kind
// end of [cmdkind_get_stadyn]

(* ****** ****** *)

datatype OUTCHAN =
  | OUTCHANref of (FILEref) | OUTCHANptr of (FILEref)
// end of [OUTCHAN]

fun outchan_get_fileref
  (x: OUTCHAN): FILEref = (
  case+ x of
  | OUTCHANref (filr) => filr | OUTCHANptr (filp) => filp
) // end of [outchan_get_fileref]

(* ****** ****** *)

typedef
cmdstate = @{
  comarg0= comarg
, waitkind= waitkind
// number of processed input files;
, ninputfile= int // waiting for STDIN if it is 0
, outchan= OUTCHAN // current output channel
, standalone= bool (* output is a stand-alone file *)
, nerror= int // number of accumulated errors
} // end of [cmdstate]

fun cmdstate_set_outchan (
  state: &cmdstate, _new: OUTCHAN
) : void = let
  val _old = state.outchan
  val () = state.outchan := _new
in
  case+ _old of
  | OUTCHANref _ => ()
  | OUTCHANptr (filp) => let
      val _err = $STDIO.fclose0_err (filp) in (*nothing*)
    end // end of [OUTCHANptr]
end // end of [cmdstate_set_outchan]

fun cmdstate_set_outchan_basename (
  state: &cmdstate, basename: string
) : void = let
//
val [l:addr] (pfopt | p) =
  $STDIO.fopen_err (basename, file_mode_w)
// end of [val]
in
//
if p > null then let
  prval Some_v (pf) = pfopt
  val filp = __cast (pf | p) where {
    extern castfn __cast (pf: FILE w @ l | p: ptr l):<> FILEref
  } // end of [val]
in
  cmdstate_set_outchan (state, OUTCHANptr (filp))
end else let
  prval None_v () = pfopt
  val () = state.nerror := state.nerror + 1
in
  cmdstate_set_outchan (state, OUTCHANref (stderr_ref))
end // end of [if]
//
end // end of [cmdstate_set_outchan_basename]

(* ****** ****** *)

fn isinpwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKinput_sta () => true
  | WTKinput_dyn () => true
  | _ => false
// end of [isinpwait]

fn isoutwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKoutput () => true | _ => false
// end of [isoutwait]

fn isdatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKdefine () => true | _ => false
// end of [isdatswait]

fn isiatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKinclude () => true | _ => false
// end of [isiatswait]

(* ****** ****** *)

fun
pats2xhtml_level1_state_fileref (
  state: &cmdstate, inp: FILEref
) : void = let
  val stadyn =
    waitkind_get_stadyn (state.waitkind)
  val out = outchan_get_fileref (state.outchan)
  val putc =
    lam (c: char)
      : int =<cloref1> $STDIO.fputc0_err (c, out)
    // end of [lam]
  val () = if state.standalone then pats2xhtml_file_beg (out)
  val () = pats2xhtml_pre_beg (out)
  val () = pats2xhtml_level1_fileref (stadyn, inp, putc)
  val () = pats2xhtml_pre_end (out)
  val () = if state.standalone then pats2xhtml_file_end (out)
in
  // nothing
end // end of [pats2xhtml_level1_state_fileref]

fun
pats2xhtml_level1_state_basename (
  state: &cmdstate, basename: string
) : void = let
//
val opt = $FIL.filenameopt_make_local (basename)
//
in
//
case+ opt of
| ~Some_vt (fil) => let
    prval pfmod = file_mode_lte_r_r
    val fsym =
      $FIL.filename_get_fullname (fil)
    val fname = $SYM.symbol_get_name (fsym)
    val [l:addr] (pf | p) =
      $STDIO.fopen_exn (fname, file_mode_r)
    val inp = __cast (pf | p) where {
      extern castfn __cast (pf: FILE r @ l | p: ptr l): FILEref
    } // end of [val]
    val () = pats2xhtml_level1_state_fileref (state, inp)
    val _err = $STDIO.fclose0_err (inp)
  in
    // nothing
  end // end of [Some_vt]
| ~None_vt () => let
    val () = prerr "error(ATS)"
    val () = prerr ": the file of the name ["
    val () = prerr (basename)
    val () = prerr "] is not available."
    val () = prerr_newline ()
  in
    state.nerror := state.nerror + 1
  end // end of [None_vt]
//
end // end of [pats2xhtml_level1_state_basename]

(* ****** ****** *)

fn pats2xhtml_usage
  (cmd: string): void = {
  val () = printf
    ("usage: %s <command> ... <command>\n\n", @(cmd))
  val () = printf
    ("where each <command> is of one of the following forms:\n\n", @())
  val () = printf
    ("  -o <filename> : output into <filename>\n", @())
  val () = printf
    ("  --output <filename> : output into <filename>\n", @())
  val () = printf
    ("  -s <filename> : for processing static <filename>\n", @())
  val () = printf
    ("  --static <filename> : for processing static <filename>\n", @())
  val () = printf
    ("  -d <filename> : for processing dynamic <filename>\n", @())
  val () = printf
    ("  --dynamic <filename> : for processing dynamic <filename>\n", @())
  val () = printf
    ("  --embedded : for outputing xhtml code to be embedded\n", @())
  val () = printf
    ("  -h : for printing out this help usage\n", @())
  val () = printf
    ("  --help : for printing out this help usage\n", @())
} // end of [pats2xhtml_usage]

(* ****** ****** *)

fn*
process_cmdline
  {i:nat} .<i,0>. (
  state: &cmdstate
, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arglst of
| ~list_vt_cons
    (arg, arglst) => (
    process_cmdline2 (state, arg, arglst)
  ) // endof [list_vt_cons]
| ~list_vt_nil ()
    when state.ninputfile = 0 => let
    val stadyn = waitkind_get_stadyn (state.waitkind)
  in
    case+ 0 of
    | _ when
        stadyn >= 0 => {
        val inp = stdin_ref
        val out = outchan_get_fileref (state.outchan)
        val () = pats2xhtml_level1_state_fileref (state, inp)
      } // end of [_ when ...]
    | _ => ()
  end // end of [list_vt_nil when ...]
| ~list_vt_nil () => ()
//
end // end of [process_cmdline]

and
process_cmdline2
  {i:nat} .<i,2>. (
  state: &cmdstate
, arg: comarg
, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arg of
//
| _ when isinpwait (state) => let
//
// HX: the [inpwait] state stays unchanged
//
    val nif = state.ninputfile
  in
    case+ arg of
    | COMARGkey (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1 (state, arglst, key)
    | COMARGkey (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2 (state, arglst, key)
    | COMARGkey (_, basename) => let
        val stadyn = waitkind_get_stadyn (state.waitkind)
        val () = state.ninputfile := state.ninputfile + 1
        val () = pats2xhtml_level1_state_basename (state, basename)
      in
        process_cmdline (state, arglst)
      end (* end of [_] *)
  end // end of [_ when isinpwait]
//
| _ when isoutwait (state) => let
    val () = state.waitkind := WTKnone ()
    val COMARGkey (_, fname) = arg
    val () = cmdstate_set_outchan_basename (state, fname)
  in
    process_cmdline (state, arglst)
  end // end of [_ when isoutwait]
//
| _ when isdatswait (state) => let
    val () = state.waitkind := WTKnone ()
    val COMARGkey (_, def) = arg
    val () = process_DATS_def (def)
  in
    process_cmdline (state, arglst)
  end // end of [_ when isdatswait]
//
| _ when isiatswait (state) => let
    val () = state.waitkind := WTKnone ()
    val COMARGkey (_, dir) = arg
    val () = process_IATS_dir (dir)
  in
    process_cmdline (state, arglst)
  end
//
| COMARGkey (1, key) =>
    process_cmdline2_COMARGkey1 (state, arglst, key)
| COMARGkey (2, key) =>
    process_cmdline2_COMARGkey2 (state, arglst, key)
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
  {i:nat} .<i,1>. (
  state: &cmdstate
, arglst: comarglst (i)
, key: string // the string following [-]
) :<fun1> void = let
  val () = state.waitkind := WTKnone ()
  val () = (case+ key of
    | "-s" => {
        val () = state.ninputfile := 0
        val () = state.waitkind := WTKinput_sta
      }
    | "-d" => {
        val () = state.ninputfile := 0
        val () = state.waitkind := WTKinput_dyn
      }
    | "-o" => {
        val () = state.waitkind := WTKoutput ()
      }
    | "-h" => {
        val () = state.waitkind := WTKnone ()
        val () = pats2xhtml_usage ("pats2xhtml")
      }
    | _ when
        is_DATS_flag (key) => let
        val def = DATS_extract (key)
        val issome = stropt_is_some (def)
      in
        if issome then let
          val def = stropt_unsome (def)
        in
          process_DATS_def (def)
        end else let
          val () = state.waitkind := WTKdefine ()
        in
          // nothing
        end // end of [if]
      end
    | _ when
        is_IATS_flag (key) => let
        val dir = IATS_extract (key)
        val issome = stropt_is_some (dir)
      in
        if issome then let
          val dir = stropt_unsome (dir)
        in
          process_IATS_dir (dir)
        end else let
          val () = state.waitkind := WTKinclude ()
        in
          // nothing
        end // end of [if]
      end
    | _ => comarg_warning (key) // unrecognized
  ) : void // end of [val]
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey1]

and
process_cmdline2_COMARGkey2
  {i:nat} .<i,1>. (
  state: &cmdstate
, arglst: comarglst (i)
, key: string // the string following [--]
) :<fun1> void = let
  val () =
    state.waitkind := WTKnone ()
  val () = (case+ key of
    | "--static" =>
        state.waitkind := WTKinput_sta
    | "--dynamic" =>
        state.waitkind := WTKinput_dyn
    | "--output" =>
        state.waitkind := WTKoutput ()
    | "--embedded" =>
        state.standalone := false
    | "--help" => let
        val () =
          state.waitkind := WTKnone ()
        // end of [val]
      in
        pats2xhtml_usage ("pats2xhtml")
      end // end of ["--help"]
    | _ => comarg_warning (key) // unrecognized
  ) : void // end of [val]
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey2]

(* ****** ****** *)

dynload "src/pats_global.dats"
dynload "src/pats_errmsg.dats"
dynload "src/pats_effect.dats"
dynload "src/pats_symmap.dats"
dynload "src/pats_symenv.dats"
dynload "src/pats_comarg.dats"
dynload "src/pats_staexp1.dats"
dynload "src/pats_trans1_env.dats"
dynload "src/pats_trans1_error.dats"
dynload "src/pats_trans1_e0xp.dats"

(* ****** ****** *)

dynload "libatsynmark/dynloadall.dats"

(* ****** ****** *)

dynload "utils/atsyntax/DATS/pats2xhtml.dats"
dynload "utils/atsyntax/DATS/pats2xhtml_level1.dats"

(* ****** ****** *)

implement
main (argc, argv) = let
//
val arglst = comarglst_parse (argc, argv)
val ~list_vt_cons (arg0, arglst) = arglst
//
var
state = @{
  comarg0= arg0
, waitkind= WTKnone ()
// number of prcessed
, ninputfile= 0 // input files
, outchan= OUTCHANref (stdout_ref)
, standalone= true (* standalone output *)
, nerror= 0 // number of accumulated errors
} : cmdstate // end of [var]
//
val () = process_cmdline (state, arglst)
//
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [pats2xhtml_main.dats] *)

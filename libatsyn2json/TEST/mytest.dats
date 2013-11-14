(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)
//
staload "src/pats_basics.sats"
//
macdef isdebug () = (debug_flag_get () > 0)
//
(* ****** ****** *)

staload
ERR = "src/pats_error.sats"
staload
GLOB = "src/pats_global.sats"

(* ****** ****** *)

staload
FIL = "src/pats_filename.sats"
staload
LOC = "src/pats_location.sats"

(* ****** ****** *)

staload SYM = "src/pats_symbol.sats"

(* ****** ****** *)

staload "src/pats_lexing.sats"
staload "src/pats_tokbuf.sats"
staload "src/pats_parsing.sats"
staload "src/pats_syntax.sats"

(* ****** ****** *)

staload "src/pats_staexp1.sats"
staload "src/pats_dynexp1.sats"
staload TRANS1 = "src/pats_trans1.sats"
staload TRENV1 = "src/pats_trans1_env.sats"

(* ****** ****** *)

staload "src/pats_staexp2.sats"
staload "src/pats_stacst2.sats"
staload "src/pats_dynexp2.sats"
staload TRANS2 = "src/pats_trans2.sats"
staload TRENV2 = "src/pats_trans2_env.sats"

(* ****** ****** *)

staload "src/pats_comarg.sats"

(* ****** ****** *)

staload "./../SATS/libatsyn2json.sats"

(* ****** ****** *)

dynload "./../dynloadall.dats"

(* ****** ****** *)

%{^
//
extern void patsopt_PATSHOME_set () ;
extern char *patsopt_PATSHOME_get () ;
extern void patsopt_PATSHOMERELOC_set () ;
extern char *patsopt_PATSHOMERELOC_get () ;
//
%} // end of [%{^]

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

datatype
outchan =
  | OUTCHANref of (FILEref) | OUTCHANptr of (FILEref)
// end of [outchan]

fun
outchan_get_filr
  (oc: outchan): FILEref = (
  case+ oc of
  | OUTCHANref (filr) => filr | OUTCHANptr (filr) => filr
) // end of [outchan_get_filr]

fun
outchan_make_path
  (name: string): outchan = let
//
val (pfopt | filp) =
  $STDIO.fopen_err (name, file_mode_w)
//
in
//
if filp > null then let
  prval Some_v (pf) = pfopt
  val filr = $UN.castvwtp_trans {FILEref} @(pf | filp)
in
  OUTCHANptr (filr)
end else let
  prval None_v () = pfopt
in
  OUTCHANref (stderr_ref)
end // end of [if]
//
end // end of [outchan_make_path]

(* ****** ****** *)

typedef
cmdstate = @{
  comarg0= comarg
//
, PATSHOME= string
//
, waitkind= waitkind
// prelude-loading is done or not
, preludeflg= int
// number of processed input files
, ninputfile= int
//
, infil=filename
//
, outchan= outchan
// number of accumulated errors
, nerror= int
} // end of [cmdstate]

(* ****** ****** *)

fun cmdstate_set_outchan (
  state: &cmdstate, _new: outchan
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

local

var theOutFilename
  : Stropt = stropt_none
val (pf0 | ()) =
  vbox_make_view_ptr{Stropt}(view@ (theOutFilename) | &theOutFilename)
// end of [val]

in // in of [local]

fn theOutFilename_get
  (): Stropt = out where {
  prval vbox pf = pf0
  val out = theOutFilename
  val () = theOutFilename := stropt_none
} // end of [theOutFilename_get]

fn theOutFilename_set
  (name: Stropt) = () where {
  prval vbox pf = pf0
  val () = theOutFilename := name
} // end of [theOutFilename_set]

end // end of [local]

(* ****** ****** *)

fn fixity_load
  (PATSHOME: string): void = let
//
  val given = "prelude/fixity.ats"
  val fullname =
    $FIL.filename_append (PATSHOME, given)
  val fullname = string_of_strptr (fullname)
  val filename =
    $FIL.filename_make (given, given, fullname)
//
  val (pffil | ()) = 
    $FIL.the_filenamelst_push (filename)
  val d0cs = parse_from_filename_toplevel (0(*sta*), filename)
  val () = $FIL.the_filenamelst_pop (pffil | (*none*))
//
  val (
    pfenv | ()
  ) = $TRENV1.the_fxtyenv_push_nil ()
  val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
  val fxtymap = $TRENV1.the_fxtyenv_pop (pfenv | (*none*))
  val () = $TRENV1.the_fxtyenv_pervasive_joinwth (fxtymap)
(*
  val () = begin
    print "[fixity_load] is finished."; print_newline ()
  end // end of [val]
*)
in
  // empty
end // end of [fixity_load]

(* ****** ****** *)

fun
pervasive_load
(
  PATSHOME: string, given: string
) : void = {
//
(*
val () = (
  println! ("pervasive_load: given = ", given)
) (* end of [val] *)
*)
//
val fullname =
  $FIL.filename_append (PATSHOME, given)
val fullname = string_of_strptr (fullname)
//
val filename =
  $FIL.filename_make (given, given, fullname)
//
val (pfpush | ()) = 
  $FIL.the_filenamelst_push (filename)
val d0cs =
  parse_from_filename_toplevel (0(*sta*), filename)
val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
val () = $TRENV1.the_EXTERN_PREFIX_set ("atspre_")
val () = $GLOB.the_PACKNAME_set_name ("ATSLIB.prelude")
//
val (pfenv | ()) =
  $TRENV1.the_trans1_env_push ((*void*))
val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
val () = $TRENV1.the_trans1_env_pop (pfenv | (*none*))
//
val (pfenv | ()) =
  $TRENV2.the_trans2_env_push ((*void*))
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
val () = $TRENV2.the_trans2_env_pervasive_joinwth (pfenv | filename, d2cs)
//
val () = $GLOB.the_PACKNAME_set_none ()
val () = $TRENV1.the_EXTERN_PREFIX_set_none ()
//
} // end of [pervasive_load]

(* ****** ****** *)

fun prelude_load
(
  PATSHOME: string
) : void = {
//
val () = fixity_load (PATSHOME)
//
val () = pervasive_load (PATSHOME, "prelude/basics_pre.sats")
val () = pervasive_load (PATSHOME, "prelude/basics_sta.sats")
val () = pervasive_load (PATSHOME, "prelude/basics_dyn.sats")
val () = pervasive_load (PATSHOME, "prelude/basics_gen.sats")
//
val () = pervasive_load (PATSHOME, "prelude/macrodef.sats")
//
val () = stacst2_initialize () // internalizing some static consts
//
val () = pervasive_load (PATSHOME, "prelude/SATS/arith_prf.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/integer.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/pointer.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/bool.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/char.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/integer_ptr.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/integer_fixed.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/float.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/memory.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/string.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/strptr.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/tuple.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/reference.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/filebas.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/intrange.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/gorder.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/gnumber.sats")
//
(*
val () = pervasive_load (PATSHOME, "prelude/SATS/unsafe.sats") // manual loading
*)
//
val () = pervasive_load (PATSHOME, "prelude/SATS/list.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/list_vt.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/option.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/option_vt.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/array.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/array_prf.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/arrayptr.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/arrayref.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/matrix.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/matrixptr.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/matrixref.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/stream.sats")
val () = pervasive_load (PATSHOME, "prelude/SATS/stream_vt.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/gprint.sats")
//
val () = pervasive_load (PATSHOME, "prelude/SATS/parray.sats") // null-terminated
//
val () = pervasive_load (PATSHOME, "prelude/SATS/extern.sats") // interfacing externs
//
} // end of [prelude_load]

(* ****** ****** *)

fun prelude_load_if
(
  PATSHOME: string, flag: &int
) : void =
  if flag = 0 then let
    val () = flag := 1 in prelude_load (PATSHOME)
  end else () // end of [if]
// end of [prelude_load_if]

(* ****** ****** *)
//
extern
fun do_trans12
  (given: string, d0cs: d0eclist): d2eclist
extern
fun do_transfinal
  (state: &cmdstate, given: string, d0cs: d0eclist): void
//
(* ****** ****** *)

implement
do_trans12
  (given, d0cs) = let
//
val d1cs =
  $TRANS1.d0eclist_tr_errck (d0cs)
// end of [val]
val () = $TRANS1.trans1_finalize ()
//
val (
) = if isdebug() then
{
  val () = println! (
    "The 1st translation (fixity) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [if] // end of [val]
//
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
val (
) = if isdebug() then
{
  val () = println! (
    "The 2nd translation (binding) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [if] // end of [val]
//
in
  d2cs
end // end of [do_trans12]

(* ****** ****** *)

implement
do_transfinal
  (state, given, d0cs) = let
  val d2cs = do_trans12 (given, d0cs)
  val out = outchan_get_filr (state.outchan)
  val () = jsonize_d2eclist (out, d2cs)
in
  // nothing
end // end of [do_transfinal]

(* ****** ****** *)

fn*
process_cmdline
  {i:nat} .<i,0>. (
  state: &cmdstate, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arglst of
| ~list_vt_cons
    (arg, arglst) =>
    process_cmdline2 (state, arg, arglst)
| ~list_vt_nil ()
    when state.ninputfile = 0 => let
    val stadyn =
      waitkind_get_stadyn (state.waitkind)
    // end of [val]
  in
    case+ 0 of
    | _ when stadyn >= 0 => {
        val PATSHOME = state.PATSHOME
        val () =
          prelude_load_if (
          PATSHOME, state.preludeflg // loading once
        ) // end of [val]
//
        val () = state.infil := $FIL.filename_stdin
//
        val d0cs = parse_from_stdin_toplevel (stadyn)
//
        val () = do_transfinal (state, "<STDIN>", d0cs)
//
      } // end of [_ when ...]
    | _ => ((*void*))
  end // end of [list_vt_nil when ...]
| ~list_vt_nil () => ()
//
end // end of [process_cmdline]

and
process_cmdline2
  {i:nat} .<i,2>.
(
  state: &cmdstate
, arg: comarg, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arg of
//
| _ when
    isinpwait (state) => let
//
// HX: the [inpwait] state stays unchanged
//
    val stadyn = waitkind_get_stadyn (state.waitkind)
    val nif = state.ninputfile
  in
    case+ arg of
    | COMARGkey
        (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1 (state, arglst, key)
    | COMARGkey
        (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2 (state, arglst, key)
    | COMARGkey (_, given) => let
        val PATSHOME = state.PATSHOME
        val () = state.ninputfile := state.ninputfile + 1
        val () = prelude_load_if (PATSHOME, state.preludeflg)
//
        val d0cs = parse_from_givename_toplevel (stadyn, given, state.infil)
//
        val () = do_transfinal (state, given, d0cs)
//
      in
        process_cmdline (state, arglst)
      end (* end of [_] *)
    // end of [case]
  end // end of [_ when isinpwait]
//
| _ when
    isoutwait (state) => let
    val () = state.waitkind := WTKnone ()
//
    val COMARGkey (_, given) = arg
//
    val opt = stropt_some (given)
    val ((*void*)) = theOutFilename_set (opt)
//
    val _new = outchan_make_path (given)
    val ((*void*)) = cmdstate_set_outchan (state, _new)
//
  in
    process_cmdline (state, arglst)
  end // end of [_ when isoutwait]
//
| _ when
    isdatswait (state) => let
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
  {i:nat} .<i,1>.
(
  state: &cmdstate
, arglst: comarglst (i)
, key: string // [key]: the string following [-]
) :<fun1> void = let
//
val () = state.waitkind := WTKnone ()
val () =
(
case+ key of
//
| "-o" => let
    val () = state.waitkind := WTKoutput
  in
  end // end of [-o]
| "-s" => let
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput_sta
  in
  end // end of [-s]
| "-d" => let
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput_dyn
  in
  end // end of [-d]
//
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
//
| _ => comarg_warning (key) // unrecognized key
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey1]

and
process_cmdline2_COMARGkey2
  {i:nat} .<i,1>.
(
  state: &cmdstate
, arglst: comarglst (i)
, key: string // [key]: the string following [--]
) :<fun1> void = let
//
val () = state.waitkind := WTKnone ()
val () =
(
case+ key of
| "--output" =>
    state.waitkind := WTKoutput ()
//
| "--static" =>
    state.waitkind := WTKinput_sta
| "--dynamic" =>
    state.waitkind := WTKinput_dyn
//
| "--gline" => {
    val () = $GLOB.the_DEBUGATS_dbgline_set (1)
  } // end of [--gline]
//
| _ => comarg_warning (key) // unrecognized key
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey2]

(* ****** ****** *)

implement
main (
  argc, argv
) = () where {
//
val () = println! ("Hello from ATS/Postiats!")
//
val (
) = set () where
{ 
  extern fun set (): void = "mac#patsopt_PATSHOME_set"
} // end of [where] // end of [val]
val (
) = set () where
{
  extern fun set (): void = "mac#patsopt_PATSHOMERELOC_set"
} // end of [where] // end of [val]
//
val PATSHOME = let
  val opt = get () where
  {
    extern fun get (): Stropt = "mac#patsopt_PATSHOME_get"
  } // end of [where] // end of [val]
  val issome = stropt_is_some (opt)
in
  if issome
    then stropt_unsome (opt) else let
    val () = prerrln! ("The environment variable PATSHOME is undefined!")
  in
    $ERR.abort ()
  end // end of [if]
end : string // end of [PATSHOME]
//
// for the run-time and atslib
//
val () = $FIL.the_prepathlst_push (PATSHOME)
//
val () = $TRENV1.the_trans1_env_initialize ()
val () = $TRENV2.the_trans2_env_initialize ()
//
val arglst = comarglst_parse (argc, argv)
val+~list_vt_cons (arg0, arglst) = arglst
//
var
state = @{
  comarg0= arg0
, PATSHOME= PATSHOME
, waitkind= WTKnone ()
// load status of prelude files
, preludeflg= 0
// number of prcessed input files
, ninputfile= 0
//
, infil= $FIL.filename_dummy
// HX: the default output channel
, outchan= OUTCHANref (stdout_ref)
//
, nerror= 0 // number of accumulated errors
} : cmdstate // end of [var]
//
val () = process_cmdline (state, arglst)
//
} // end of [main]

(* ****** ****** *)

(* end of [mytest.dats] *)

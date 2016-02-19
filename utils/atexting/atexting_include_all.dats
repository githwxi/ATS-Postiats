(* ****** ****** *)
//
// ATS-texting
//
(* ****** ****** *)
//
// HX-2016-02-16
//
(* ****** ****** *)
//
#define ATS_MAINATSFLAG 1
//
(* ****** ****** *)
//
#define
ATS_DYNLOADNAME
"atexting_include_all_dynload"
//
(* ****** ****** *)
//
local #include "./DATS/atexting_fname.dats" in (*nothing*) end
local #include "./DATS/atexting_posloc.dats" in (*nothing*) end
//
local #include "./DATS/atexting_token.dats" in (*nothing*) end
local #include "./DATS/atexting_atext.dats" in (*nothing*) end
//
local #include "./DATS/atexting_parerr.dats" in (*nothing*) end
//
local #include "./DATS/atexting_lexbuf.dats" in (*nothing*) end
local #include "./DATS/atexting_lexing.dats" in (*nothing*) end
//
local #include "./DATS/atexting_tokbuf.dats" in (*nothing*) end
//
local #include "./DATS/atexting_global.dats" in (*nothing*) end
//
local #include "./DATS/atexting_textdef.dats" in (*nothing*) end
//
local #include "./DATS/atexting_parsing.dats" in (*nothing*) end
//
local #include "./DATS/atexting_strngfy.dats" in (*nothing*) end
local #include "./DATS/atexting_topeval.dats" in (*nothing*) end
//
local #include "./DATS/atexting_commarg.dats" in (*nothing*) end
//
(* ****** ****** *)
//
staload
"prelude/DATS/integer.dats"
staload
"prelude/DATS/filebas.dats"
//
(* ****** ****** *)
//
staload
"libc/SATS/stdio.sats"  
//
staload
"libats/ML/SATS/basis.sats"  
//
(* ****** ****** *)

datatype
outchan =
  | OUTCHANptr of FILEref
  | OUTCHANref of FILEref
// end of [OUTCHAN]

(* ****** ****** *)

fun
outchan_get_fileref
  (x0: outchan): FILEref =
(
//
case+ x0 of
| OUTCHANref(filr) => filr
| OUTCHANptr(filp) => filp
//
) // outchan_get_fileref

(* ****** ****** *)

fun
outchan_close(x0: outchan): void =
(
//
case+ x0 of
| OUTCHANref(filr) => ()
| OUTCHANptr(filp) => fclose0_exn(filp)
//
) (* end of [outchan_close] *)

(* ****** ****** *)

#ifdef
MAIN_NONE
#then
//
// HX:
// the [main] is
// to be implemented
//
#else
//
local
//
staload
"./SATS/atexting.sats"
//
typedef
cmdstate = @{
//
comarg0= commarg
//
(*
, inpfil=filename
*)
//
, outmode= fmode
, outchan= outchan
//
} (* end of [cmdstate] *)
//
fun
process_commarg
(
  x0: commarg
, state: &cmdstate >> _
) : void = let
in
//
case+ x0 of
| CAhelp _ => ()
| CAgitem _ => ()
| CAnsharp(_, opt) => let
    val ns =
    (
      case+ opt of
      | None0() => 0
      | Some0(ns) => g0string2int(ns)
    ) : int // end of [val]
  in
    the_nsharp_set(ns)
  end // end of [CSnsharp]
//
| CAinpfil(_, opt) =>
  (
    case+ opt of
    | None0() => let
        val txts =
          parsing_from_stdin()
        // end of [val]
        val out =
          outchan_get_fileref(state.outchan)
        // end of [val]
      in
        atextlst_topeval(out, txts)
      end // end of [None0]
    | Some0(path) => let
        val txts =
          parsing_from_filename(path)
        // end of [val]
        val out =
          outchan_get_fileref(state.outchan)
        // end of [val]
      in
        atextlst_topeval(out, txts)
      end // end of [Some0]
  ) (* end of [CAinpfil] *)
//
| CAoutfil(_, opt) =>
    process_commarg_outfil(x0, opt, state)
  // end of [CAoutfil]
//
end // end of [process_commarg]
//
and
process_commarg_outfil
(
  x0: commarg
, opt: option0(string)
, state: &cmdstate >> _
) : void = let
in
//
case+ opt of
| None0() => ()
| Some0(path) => let
    val opt =
      fileref_open_opt(path, state.outmode)
    // end of [val]
  in
    case+ opt of
    | ~None_vt() => ()
    | ~Some_vt(filr) => state.outchan := OUTCHANref(filr)
  end // end of [val]
//
end // end of [process_commarg_outfil]
//
and
process_commarglst
(
  xs: commarglst
, state: &cmdstate >> _
) : void = let
in
//
case+ xs of
| list0_nil() => ()
| list0_cons(x, xs) => let
    val () =
    process_commarg(x, state)
  in
    process_commarglst(xs, state)
  end // end of [list0_cons]
//
end // end of [process_commarglst]
//
in (* in-of-local *)

implement
main0{n}
(
  argc, argv
) = ((*void*)) where
{
//
val () = the_nsharp_set(2)
//
val () =
println!("Hello from [atexting]!")
//
val out = stdout_ref
//
val args = commarglst_parse(argc, argv)
val _(*void*) = fprintln! (out, "args = ", args)
//
//
val txts = parsing_from_stdin((*void*))
//
val ((*void*)) = atextlst_topeval(out, txts)
//
} (* end of [main0] *)

end // end of [local]
//
#endif // #ifdef(MAIN_NONE)

(* ****** ****** *)

(* end of [atexting_include_all.dats] *)

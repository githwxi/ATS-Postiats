(* ****** ****** *)
(*
** Testing code for [getargs]
*)
(* ****** ****** *)
(*
** Author: Hongwei Xi
** Start Time: May, 2017
** Authoremail: gmhwxiATgmailDOTedu
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
#staload $GETARGS // opening it
//
#include "./../mylibies_link.hats"
//
(* ****** ****** *)

implement
{}(*tmp*)
getargs_usage() = let
//
val
arg0 = getargs_arg0<>()
//
in
//
println! ("Usage: ", arg0, " <command> ... <command>\n");
println! ("where a <command> is of one of the following forms:\n");
//
println! ("  -h,--help (for printing out this help usage)");
//
println! ("  -ev,--eval (for outputing <arg1> * <arg2>)");
//
println! ("  -a1,--arg1: <integer> (for inputing the 1st argument)");
//
println! ("  -a2,--arg2: <integer> (for inputing the 2nd argument)");
//
println! ("  -o,--output: <filename> (output into <filename>)");
println! ("  -ow,-output-w: <filename> (output-write into <filename>)");
println! ("  -oa,-output-a: <filename> (output-append into <filename>)");
//
end (* end of [getargs_usage] *)

(* ****** ****** *)

implement
{}(*tmp*)
getargs_is_output_w
  (opt) =
(
case+ opt of
| "-ow" => true
| "--output-w" => true
| _(* rest-of-string *) => false
)
implement
{}(*tmp*)
getargs_is_output_a
  (opt) =
(
case+ opt of
| "-oa" => true
| "--output-a" => true
| _(* rest-of-string *) => false
)

(* ****** ****** *)

implement
optargs_eval2_opt<>
  (fxs) = let
//
val-OPTARGS1(f, xs) = fxs
//
in
//
ifcase
| (
  f="-a1"||
  f="--arg1"
  ) =>
  the_state_set_key
    ("--arg1", GVint(g0string2int(xs.head())))
| (
  f="-a2"||
  f="--arg2"
  ) =>
  the_state_set_key
    ("--arg2", GVint(g0string2int(xs.head())))
| (
  f="-ev"||
  f="--eval"
  ) => let
     val out = the_outchan_get()
     val out = outchan_fileref(out)
     val-GVint(i1) = the_state_get_key("--arg1")
     val-GVint(i2) = the_state_get_key("--arg2")
   in
     fprintln!
     ( out
     , "The product of arg1 and arg2 is: ", i1 * i2
     ) (* fprintln! *)
   end
| _(* rest-of-flag *) =>
  (
    fprintln!(stderr_ref, "optargs_eval2_opt: unrecognized flag: ", f)
  )
//
end // end of [optargs_eval2_opt]

(* ****** ****** *)

local
var
ocr =
OUTCHANref(stdout_ref)
//
fun
focr
(
// argless
) : ref(outchan) =
  $UN.cast(addr@ocr)
//
in
implement
the_outchan_getref<>() = focr((*void*))
end // end of [local]

(* ****** ****** *)
//
val () =
the_optarty_set_key("-ow", OPTARTYeq(1))
val () =
the_optarty_set_key("-oa", OPTARTYeq(1))
//
val () =
the_optarty_set_key("-a1", OPTARTYeq(1))
val () =
the_optarty_set_key("--arg1", OPTARTYeq(1))
//
val () =
the_optarty_set_key("-a2", OPTARTYeq(1))
val () =
the_optarty_set_key("--arg2", OPTARTYeq(1))
//
(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val
arg0 = argv[0]
//
implement
getargs_arg0<>() = arg0
//
val () =
the_optarty_initset((*void*))
//
val
xs =
listize_argc_argv(argc, argv)
//
val xs = list0_of_list_vt(xs)
val optargss = optargs_parse_all(xs)
//
(*
val () = println!("optargss = ", optargss)
*)
//
val () = optargs_eval_all(optargss.tail())
//
} // end of [main0]

(* ****** ****** *)

(* end of [test01.dats] *)

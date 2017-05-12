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
optargs_eval2_opt<>
  (fxs) = let
//
val-OPTARGS1(f, xs) = fxs
//
in
//
case+ f of
| "--arg1" =>
  the_state_set_key
    ("--arg1", GVint(g0string2int(xs.head())))
| "--arg2" =>
  the_state_set_key
    ("--arg2", GVint(g0string2int(xs.head())))
| "--eval" => let
     val r0 =
       the_outchan_getref()
     val out =
       outchan_fileref(!r0)
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
    fprintln!(stderr_ref, "optargs_eval2_opt: fxs = ", fxs)
  )
//
end // end of [optargs_eval2_opt]

(* ****** ****** *)

val () =
the_optarty_set_key
  ("--arg1", OPTARTYeq(1))
val () =
the_optarty_set_key
  ("--arg2", OPTARTYeq(1))

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

implement
main0(argc, argv) =
{
//
val
xs =
listize_argc_argv
  (argc, argv)
//
val
xs = list0_of_list_vt(xs)
//
val () =
the_optarty_initset()
//
val
tas = optargs_parse_all(xs)
//
(*
val () = println!("tas = ", tas)
*)
//
val () =
optargs_eval_all(tas.tail())
//
} // end of [main0]

(* ****** ****** *)

(* end of [test01.dats] *)

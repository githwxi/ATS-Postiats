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
(* ****** ****** *)

implement
main0(argc, argv) =
{
//
local
val arg0 = argv[0]
in (*in-of-local*)
implement
getargs_arg0<>() = arg0
end // end of [local]
//
val () =
println!
  ("Hello from [getargs]!")
//
val () = getargs_usage()
//
var cout = OUTCHANref(stdout_ref)
//
implement
the_outchan_getref<>() = $UN.cast(addr@cout)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test00.dats] *)

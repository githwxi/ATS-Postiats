(* ****** ****** *)
//
staload
"./../SATS/libatsopt_ext.sats"
//
(* ****** ****** *)
//
extern
fun
libatsopt_dynloadall(): void = "ext#"
//
(* ****** ****** *)
//
#define
HELLO_WORLD "\
//
extern
fun
hello(): void = \"mac#\"
implement
hello() = print(\"Hello, world!\")
//
(* ****** ****** *)
//
val () = hello()
//
(* ****** ****** *)
//
" (* HELLO_WORLD *)

(* ****** ****** *)

#define
PREAMBLE "\
//
#include
\"share/atspre_define.hats\"
#include
\"{$LIBATSCC2JS}/staloadall.hats\"

(* ****** ****** *)

staload
\"{$LIBATSCC2JS}/SATS/print.sats\"

(* ****** ****** *)

#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME \"myself_dynload\"

(* ****** ****** *)
//
" (* PREAMBLE *)

(* ****** ****** *)

#define
POSTAMBLE "\
//
%{$
//
ats2jspre_the_print_store_clear();
myself_dynload();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]
//
" (* POSTAMBLE *)

(* ****** ****** *)

implement
main (argc, argv) =
{
//
val () = libatsopt_dynloadall()
//
val arg1 = COMARGprefil(PREAMBLE)
val arg2 = COMARGpostfil(POSTAMBLE)
//
val arg3 = COMARGstrlit("--dynamic")
val arg4 = COMARGstrinp(HELLO_WORLD)
//
#define :: list_cons
//
val
args =
(
  arg1::arg2::arg3::arg4::list_nil()
) : comarglst1
//
val
PATSOPTRES
  (nerr, strout, strerr) = patsoptres_main_arglst(args)
//
(*
val () =
println! ("patsoptres_main_arglst: nerr = ", nerr)
val () =
println! ("patsoptres_main_arglst: stdout = ", stdout)
val () =
println! ("patsoptres_main_arglst: stderr = ", stderr)
*)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_atscc2js.dats] *)


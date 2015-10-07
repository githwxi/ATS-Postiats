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
implement\n\
main0 () = println! \"Hello, world!\"\n\
"
//
(* ****** ****** *)

implement
main (argc, argv) =
{
//
val () = libatsopt_dynloadall()
//
val arg1 = COMARGstrlit("-cc")
val arg2 = COMARGstrlit("--dynamic")
val arg3 = COMARGstrinp(HELLO_WORLD)
//
#define :: list_cons
//
val
args =
(
  arg1 :: arg2 :: arg3 :: list_nil()
) : comarglst1
//
val nerr =
  patsopt_main_arglst(args)
//
val ((*void*)) =
if nerr > 0 then
  prerrln! ("[patsopt_main_arglst] encountered errors!")
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_ccomp.dats] *)

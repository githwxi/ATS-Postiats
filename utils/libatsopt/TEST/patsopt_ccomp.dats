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
val arg0 = COMARGstring("")
val arg1 = COMARGstring("-cc")
val arg2 = COMARGstring("--dynamic")
val arg3 = COMARGfilinp(HELLO_WORLD)
//
#define :: list_cons
//
val
args =
(
  arg0 :: arg1 :: arg2 :: arg3 :: list_nil()
) : comarglst1
//
val nerr =
  patsopt_main_list(args)
//
val ((*void*)) =
if nerr > 0 then
  prerrln! ("[patsopt_main_list] encountered errors!")
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_ccomp.dats] *)

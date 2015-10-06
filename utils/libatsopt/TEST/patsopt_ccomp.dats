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
val arg1 = COMARGstring("-tc")
val arg2 = COMARGstring("--dynamic")
val arg3 = COMARGfilinp(HELLO_WORLD)
//
#define :: list_cons
//
val args = arg0 :: arg1 :: arg2 :: arg3 :: list_nil()
//
val nerr = patsopt_main_list(args)
val ((*void*)) = println! ("patsopt_main_list: nerr = ", nerr)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_ccomp.dats] *)

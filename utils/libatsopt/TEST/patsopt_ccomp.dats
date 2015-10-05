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
val res = 
patsopt_tcats_string(1(*dyn*), HELLO_WORLD)
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_ccomp.dats] *)

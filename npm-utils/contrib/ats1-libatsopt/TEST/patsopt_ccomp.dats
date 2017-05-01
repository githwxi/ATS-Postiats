(* ****** ****** *)
//
(*
staload
"./../DATS/libatsopt_ext.dats"
*)
//
(* ****** ****** *)
//
extern
fun
libatsopt_dynloadall
(
(*void*)
) : void = "ext#libatsopt_dynloadall"
//
(* ****** ****** *)
//
datatype
comarg =
//
| COMARGstrlit of string
//
| COMARGstrinp of string
//
| COMARGprefil of string
| COMARGpostfil of string
//
typedef comarglst0 = List0(comarg)
typedef comarglst1 = List1(comarg)
//
(* ****** ****** *)
//
extern
fun
patsopt_main_arglst
  {n:pos}
(
  args: list(comarg, n)
) : int(*nerr*) =
  "ext#libatsopt_patsopt_main_arglst"
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
main(argc, argv) =
{
//
val () = libatsopt_dynloadall()
//
val arg1 = COMARGstrlit("--dynamic")
val arg2 = COMARGstrinp(HELLO_WORLD)
//
#define :: list_cons
//
val
args =
(
  arg1::arg2::list_nil()
) : comarglst1
//
val
nerr =
patsopt_main_arglst(args)
//
val () =
if nerr > 0 then
  prerrln! ("[patsopt_main_arglst] encountered errors!")
//
} (* end of [main] *)

(* ****** ****** *)

(* end of [patsopt_ccomp.dats] *)

(* ****** ****** *)
(*
** Some code used in
** Effectivats-StreamPar
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
val xs =
intrange_stream
  (0, 1000) where
{
//
fun
intrange_stream
(
 m: int, n: int
) : stream(int) = $delay
(
if
(m >= n)
then stream_nil((*void*))
else stream_cons(m, intrange_stream(m+1, n))
)
//
} (* end of [where] *) // end of [val]
//
val nxs = stream_length(xs) // nxs = 1000
//
(* ****** ****** *)
//
val ys =
intrange_stream_vt
  (0, 1000) where
{
//
fun
intrange_stream_vt
(
 m: int, n: int
) : stream_vt(int) = $ldelay
(
if
(m >= n)
then
stream_vt_nil((*void*))
else
stream_vt_cons(m, intrange_stream_vt(m+1, n)) 
)
//
} (* end of [where] *) // end of [val]
//
val nys = stream_vt_length(ys) // nys = 1000
//
(* ****** ****** *)
//
val
Hello =
streamize_string_char("Hello")
val
hello =
(Hello).map(TYPE{charNZ})(lam c => $UNSAFE.cast(tolower(c)))
val
hello =
un_streamize_string_char(hello)
//
val () = println!("hello = ", hello)
//
(* ****** ****** *)
//
val
Hello =
streamize_string_char("Hello")
val
HELLO =
(Hello).map(TYPE{charNZ})(lam c => $UNSAFE.cast(toupper(c)))
val
HELLO =
un_streamize_string_char(HELLO)
//
val () = println!("HELLO = ", HELLO)
//
(* ****** ****** *)
//
fun
myfilename_nchar
  (fname: string): int = let
//
val opt =
streamize_filename_char(fname)
//
in
//
case+ opt of
| ~Some_vt(cs) =>
  (
    stream_vt_length(cs)
  )
| ~None_vt((*void*)) =>
  (
    prerrln!
    ("ERROR: Cannot open the file: [", fname, "]");
    exit(1) // abnormal exit
  )
//
end // end of [myfilename_nchar]
//
val () =
println!
("nchar(StreamPar_misc.dats) = ", myfilename_nchar("./StreamPar_misc.dats"))
//
(* ****** ****** *)
//
fun
myfilename_nline
  (fname: string): int = let
//
val opt =
streamize_filename_char(fname)
//
in
//
case+ opt of
| ~Some_vt(cs) =>
  (
    stream_vt_length
    ((cs).filter()(lam c => c = '\n'))
  )
| ~None_vt((*void*)) =>
  (
    prerrln!
    ("ERROR: Cannot open the file: [", fname, "]");
    exit(1) // abnormal exit
  )
//
end // end of [myfilename_nline]
//
val () =
println!
("nline(StreamPar_misc.dats) = ", myfilename_nline("./StreamPar_misc.dats"))
//
(* ****** ****** *)

fun
{a:t@ype}
mylist_append
(
xs: list0(a)
,
ys: list0(a)
) : list0(a) =
auxmain(xs, ys) where
{
  fun
  auxmain
  ( xs: list0(a)
  , ys: list0(a)): list0(a) =
  (
  case+ xs of
  | list0_nil() => ys
  | list0_cons(x0, xs) => list0_cons(x0, auxmain(xs, ys))
  )
} (* end of [list0_append] *)

(* ****** ****** *)
//
fun
{a:t@ype}
mylist_append
(
xs: list0(a)
,
ys: list0(a)
) : list0(a) =
un_streamize_list0_elt
  (stream_vt_append(streamize_list0_elt(xs), streamize_list0_elt(ys)))
//
(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

(* end of [StreamPar_misc.dats] *)

(* ****** ****** *)
//
// HX-2018-08-14:
//
// Processing lines
// in a given file via
// the use of [getline]
//
(* ****** ****** *)
//
(*
// How to compile:
// patscc -O3 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o foreach_getline foreach_getline.dats
*)
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

absvtype line = ptr

(* ****** ****** *)

extern
fun{}
line_nil(): line

(* ****** ****** *)

extern
fun{}
line_get
(&line >> line): int
extern
fun{}
line_free(x: line): void
extern
fun{}
line_process(x: !line): void

(* ****** ****** *)

extern
fun{}
foreach_getline((*void*)): void

(* ****** ****** *)

implement
{}(*tmp*)
line_nil() =
$UN.castvwtp0{line}(0)

(* ****** ****** *)

implement
{}(*tmp*)
line_free(x) =
strptr_free($UN.castvwtp0{strptr}(x))

(* ****** ****** *)
//
// HX-2018-08-14:
// Please re-implement
// [line_process] for your own purpose
//
implement
{}(*tmp*)
line_process(x) =
{
val () =
print!
("line_process: x = ", $UN.castvwtp1{string}(x))
}
//
(* ****** ****** *)

implement
{}(*tmp*)
foreach_getline
  ((*void*)) =
{
//
  fun
  loop
  (
  x0: &line >> _
  ) : void = let
    val err = line_get<>(x0)
  in
    if
    (err >= 0)
    then (line_process<>(x0); loop(x0)) else ()
  end // end of [let]
//
  var
  x0: line? = line_nil()
//
  val () = loop(x0)
//
  val () = line_free(x0)
//
} (* end of [foreach_getline] *)

(* ****** ****** *)
//
extern
fun{}
fileref_foreach_getline
  (inp: FILEref): void
//
(* ****** ****** *)

implement
{}(*tmp*)
fileref_foreach_getline
  (inp) = let
//
var
len:
size_t = i2sz(0)
//
val p_len = addr@len
//
implement
line_get<>(x0) =
$extfcall
(int, "getline", addr@x0, p_len, inp)
//
in
  foreach_getline<>()
end // end of [fileref_foreach_getline]

(* ****** ****** *)

implement
main0(argc, argv) =
(
case+ argc of
| 1 =>
  (prerrln!
   argv[0] " " "<filepath>"; exit(1))
| _ =>> let
    val
    opt =
    fileref_open_opt(argv[1], file_mode_r)
  in
    case+ opt of
    | ~None_vt() =>
      (
        exit(1) where
        { val () =
          prerrln! argv[0] ": can't open [" argv[1] "]!"
        }
      )
    | ~Some_vt(inp) =>
      (
        (fileref_foreach_getline<>(inp); fileref_close(inp))
      )
  end // end of [_]
)

(* ****** ****** *)

(* end of [foreach_getline.dats] *)

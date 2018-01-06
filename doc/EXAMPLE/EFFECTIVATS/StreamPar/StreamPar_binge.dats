(* ****** ****** *)
(*
** A example used in
** Effectivats-StreamPar
*)
(* ****** ****** *)

%{^
//
#include <pthread.h>
//
#ifdef ATS_MEMALLOC_GCBDW
#undef GC_H
#define GC_THREADS
#include <gc/gc.h>
#endif // #if(ATS_MEMALLOC_GCBDW)
//
%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#define
LIBPCRE_targetloc
"contrib/atscntrb-libpcre"
//
(* ****** ****** *)
//
#include
"{$LIBPCRE}/mylibies.hats"
//
#staload $PCRE // opening it
#staload $PCRE_ML // opening it
//
(* ****** ****** *)
//
local
#include
"{$LIBPCRE}/mylibies_link.hats"
in (*nothing*) end
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS\
/atscntrb-hx-teaching-bucs/mylibies.hats"
//
#staload $BUCS520_2016_FALL // opening it
//
(* ****** ****** *)
//
fun
dir2fnames
(
  dname: string
) : stream_vt(string) = let
//
val cs =
stream_by_command<>
( "find"
, $list{string}(dname, "-type", "f")
) (* stream_by_command *)
val
css =
stream_vt_delim_cloptr
  (cs, lam(c) => c = '\n')
//
in
//
stream_vt_map_cloptr<List_vt(char)><string>
(css, lam(cs) => string_make_list(list_vt2t(cs)))
//
end // end of [dir2fnames]
//
(* ****** ****** *)

fun
fname2lines
( regex: string
, fname: string
) : stream_vt(string) = let
//
val opt =
streamize_filename_line(fname)
//
fun
mycheck
(line: string): bool =
(regstr_match_string(regex, line) >= 0)
//
in
//
(
case+ opt of
| ~None_vt() =>
   stream_vt_make_nil()
| ~Some_vt(lines) =>
   stream_vt_filter_cloptr
     (lines, lam(line) => mycheck(line))
   // stream_vt_filter_cloptr
)
//
end // end of [fname2lines]

(* ****** ****** *)

fun
stream_print_free
(xs: stream_vt(string)): void =
(
case+ !xs of
| ~stream_vt_nil() => ()
| ~stream_vt_cons(x, xs) => 
   let val () = println!(x) in stream_print_free(xs) end
)

(* ****** ****** *)

fun
list_vt_print_free
(xs: List_vt(string)): void =
(
case+ xs of
| ~list_vt_nil() => ()
| ~list_vt_cons(x, xs) => 
   let val () = println!(x) in list_vt_print_free(xs) end
)

(* ****** ****** *)
//
#include
"libats\
/BUCS520/StreamPar/mydepies.hats"
#include
"libats\
/BUCS520/StreamPar/mylibies.hats"
//
(* ****** ****** *)
//
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)

implement
main0(argc, argv) =
{
//
#define N 2
//
val
fws =
$FWS.fworkshop_create_exn()
//
val
added =
$FWS.fworkshop_add_nworker(fws, N)
val () =
prerrln!
("the number of workers = ", added)
//
val dname =
(
if argc >= 2 then argv[1] else "."
) : string
//
val regex =
(
if argc >= 3 then argv[2] else "^\\s*$"
) : string
//
(*
//
// HX-2018-01-06:
// this is not suitable
// for running in parallel
//
vtypedef a = string
vtypedef b = stream_vt(string)
vtypedef r = int(*fold*)
//
val res =
$StreamPar.streampar_mapfold_cloref<a><b><r>
(
  fws
, dir2fnames(dname), 0
, lam(x) => fname2lines(regex, x)
, lam(y, r) => let val () = stream_print_free(y) in r end
)
//
*)
//
vtypedef a = string
vtypedef b = List_vt(string)
vtypedef r = int(*fold*)
//
val res =
$StreamPar.streampar_mapfold_cloref<a><b><r>
(
  fws
, dir2fnames(dname), 0
, lam(x) => stream2list_vt(fname2lines(regex, x))
, lam(y, r) => let val () = list_vt_print_free(y) in r end
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [StreamPar_binge.dats] *)

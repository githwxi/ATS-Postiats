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
step1
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
( css
, lam(cs) => string_make_list(list_vt2t(cs))
)
//
end // end of [step1]
//
(* ****** ****** *)

fun
step2
( pat: string
, fname: string
) : List0_vt(string) = let
//
val opt =
streamize_filename_line(fname)
//
fun
mycheck
(x: string): bool =
(regstr_match_string(pat, x) >= 0)
//
in
//
case+ opt of
| ~None_vt() =>
   list_vt_nil()
| ~Some_vt(lines) =>
   stream2list_vt
   (stream_vt_filter_cloptr(lines, lam(x) => mycheck(x)))
//
end // end of [step2]

(* ****** ****** *)

fun
print_free
(xs: List_vt(string)): void =
(
case+ xs of
| ~list_vt_nil() => ()
| ~list_vt_cons(x, xs) => (println!(x); print_free(xs))
)
fun
print_free_if
(xs: List_vt(string)): void =
(
if isneqz(xs) then print_free(xs) else free(xs)
)

(* ****** ****** *)

//
#include
"libats/BUCS520\
/StreamPar/mydepies.hats"
#include
"libats/BUCS520\
/StreamPar/mylibies.hats"
//
(* ****** ****** *)
//
#staload
FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)

implement
main0(argc, argv) =
{
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
val fnames = step1(dname)
//
(*
val ((*void*)) =
(fnames).foreach()(lam(x) => print_free_if(x, step2(regex, x)))
*)
//
//
#define N 2
//
val
fws =
$FWS.fworkshop_create_exn()
//
val
added = $FWS.fworkshop_add_nworker(fws, N)
val () =
prerrln!("the number of workers = ", added)
//
vtypedef a = string
vtypedef b = List_vt(string)
vtypedef r = int(*fold*)
//
val res =
$StreamPar.streampar_mapfold_cloref<a><b><r>
(
  fws, fnames, 0
, lam(x) => step2(regex, x)
, lam(y, r) => (print_free_if(y); r)
)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [StreamPar_binge.dats] *)

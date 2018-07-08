(* ****** ****** *)
(*
** Directory traversal
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
//
#staload
"libats/libc/DATS/dirent.dats"
//
#staload
"prelude/DATS/filebas_dirent.dats"
//
(* ****** ****** *)
//
#include "./../mydepies.hats"
#include "./../mylibies.hats"
//
#staload FWS = $FWORKSHOP_chanlst
//
(* ****** ****** *)
//
extern
fun{}
DirWalk
( fws:
  $FWS.fworkshop
, dirpath: string): int(*status*)
//
extern
fun{}
DirWalk$skipped_test
( l0: int
, dir: string, fname: string): bool
//
extern
fun{}
DirWalk$recurse_test
( l0: int
, dir: string, fname: string): bool
//
extern
fun{}
DirWalk$process_test
( l0: int
, dir: string, fname: string): bool
//
extern
fun{}
DirWalk$process_fwork(fname: string): void
//
(* ****** ****** *)
//
implement
DirWalk$skipped_test<>
  (l0, dir, fname) =
(
if
(
fname="."
||
fname=".."
) then true else false
)
//
implement
DirWalk$recurse_test<>
  (l0, dir, fname) = let
  val
  sep = dirsep_gets<>()
  val
  fpath =
  string0_append3(dir, sep, fname)
  val isdir =
  test_file_isdir($UN.strptr2string(fpath))
  val ((*freed*)) = strptr_free(fpath)
in
//
  if isdir > 0 then true else false
//
end // end of [DirWalk$recurse_test<>]
//
implement
DirWalk$process_test<>
  (l0, dir, fname) = true
//
(* ****** ****** *)
//
implement
{}(*tmp*)
DirWalk
(fws, dir) =
let
//
vtypedef
fname = Strptr1
//
val
isdir =
test_file_isdir(dir)
//
fun
add_dir_fname
(
  x0: !fname, x1: fname
) : fname = res where
{
  val sep = dirsep_gets<>()
  val x0_ = $UN.strptr2string(x0)
  val x1_ = $UN.strptr2string(x1)
  val res = string0_append3(x0_, sep, x1_)
  val ((*freed*)) = strptr_free(x1)
}
//
overload + with add_dir_fname
//
fun
auxmain0
(
dir: string
) : int = 0 where
{
//
val
dir = string0_copy(dir)
//
val
fwork =
lam(x0: fname): void =<cloref1>
let
val () =
DirWalk$process_fwork<>($UN.strptr2string(x0)) in free(x0)
end // end of [val]
//
val () =
$StreamPar.streampar_foreach_cloref<fname>(fws, auxmain1(0, dir), fwork)
//
} (* end of [auxmain] *)
//
and
auxmain1
(
l0: int, x0: fname
) : stream_vt(fname) = let
//
val x0_ =
$UN.strptr2string(x0)
val
fnames =
streamize_dirname_fname<>(x0_)
//
in
  auxmain2(l0, x0, fnames)
end // end of [auxmain1]
//
and
auxmain2
(
l0: int, x0: fname,
xs: stream_vt(fname)
) : stream_vt(fname) = $ldelay
(
case+ !xs of
| ~stream_vt_nil() =>
  (
    free(x0); stream_vt_nil()
  )
| ~stream_vt_cons(x1, xs) => let
    val x0_ = $UN.strptr2string(x0)
    val x1_ = $UN.strptr2string(x1)
  in
    ifcase
    | DirWalk$skipped_test
        (l0, x0_, x1_) =>
      (
        free(x1); !(auxmain2(l0, x0, xs))
      )
    | DirWalk$recurse_test
        (l0, x0_, x1_) => !
      (
        stream_vt_append<fname>
          (auxmain1(l0+1, x0+x1), auxmain2(l0, x0, xs))
        // end of [stream_vt_append]
      )
    | DirWalk$process_test
        (l0, x0_, x1_) =>
        stream_vt_cons{fname}(x0+x1, auxmain2(l0, x0, xs))
    | _ (* not-to-be-processed *) =>
      (
        free(x1); !(auxmain2(l0, x0, xs))
      )
  end // end of [stream_vt_cons]
, (strptr_free(x0); lazy_vt_free(xs))
)
//
in
//
  if isdir > 0 then auxmain0(dir) else 1(*error*)
//
end // end of [DirWalk]

(* ****** ****** *)

#staload FWS = $FWORKSHOP_chanlst

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
#define N 4
//
val
fws =
$FWS.fworkshop_create_exn()
//
val
nadded =
$FWS.fworkshop_add_nworker(fws, N)
val () =
prerrln!
("the number of workers = ", nadded)
//
val
dirname =
(
if
argc >= 2 then argv[1] else "."
) : string
//
implement
DirWalk$process_fwork<>
  (fname) = println! (fname)
//
val status = DirWalk<>(fws, dirname)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [DirWalk.dats] *)

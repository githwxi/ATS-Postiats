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
#include "share/atspre_staload.hats"
#include "libats/libc/DATS/dirent.dats"
#include "share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#include
"$PATSHOMELOCS\
/atscntrb-bucs320-divideconquerpar/mydepies.hats"
#include
"$PATSHOMELOCS\
/atscntrb-bucs320-divideconquerpar/mylibies.hats"
//
(* ****** ****** *)
//
#staload $DivideConquer // for opening namespace
#staload $DivideConquerPar // for opening namespace
//
#staload FWS = $FWORKSHOP_chanlst // for list-based channels
//
(* ****** ****** *)
//
assume
input_t0ype = string
assume
output_t0ype = (int)
//
(* ****** ****** *)
//
typedef
fworkshop = $FWS.fworkshop
//
(* ****** ****** *)
//
extern
fun
DirWalk
( fws: fworkshop
, fname: string, fopr: cfun(string, int)
) : int // end of [DirWalk]
//
(* ****** ****** *)
//
fun
dir_skipped(dir: string): bool =
  if (dir = "." || dir = "..") then true else false
//
(* ****** ****** *)

implement
DirWalk
(fws, fname, fopr) =
let
//
val () = $tempenver(fws)
val () = $tempenver(fopr)
//
//
implement
DivideConquer$base_test<>
  (fname) = let
//
(*
val () =
println!("fname = ", fname)
*)
//
in
  test_file_isdir(fname) <= 0
end // end of [DivideConquer$base_test<>]
//
implement
DivideConquer$base_solve<>
  (fname) = fopr(fname)
//
//
implement
DivideConquer$divide<>
  (dir) = (
//
let
//
val
files =
streamize_dirname_fname(dir)
val
files =
stream_vt_filter_cloptr<string>
  (files, lam(x) => ~dir_skipped(x))
val
files =
stream_vt_map_cloptr<string><string>
  (files, lam(file) => string_append3(dir, "/", file))
//
in
  list0_of_list_vt(stream2list_vt(files))
end // end of [let]
//
) (* end of [DivideConquer$divide<>] *)
//
implement
DivideConquer$conquer$combine<>
  (_, rs) =
(
  list0_foldleft<int><int>(rs, 0, lam(res, r) => res + r)
)
//
implement
DivideConquerPar$fworkshop<>((*void*)) = FWORKSHOP_chanlst(fws)
//
in
  DivideConquer$solve<>( fname )
end // end of [DirWalk]

(* ****** ****** *)

fun
wc_line
(fname: string): int = let
//
val EOL = char2int0('\n')
//
fun
loop
( inp: FILEref
, r1: int, r2: int): int = let
//
val c0 = fileref_getc(inp)
//
in
  if
  (c0 >= 0)
  then (
  if c0 = EOL
    then loop(inp, 0, r2+1)
    else loop(inp, r1+1, r2)
  ) else (if r1 = 0 then r2 else r2 + 1)
end // end of [loop]
//
val
opt =
fileref_open_opt(fname, file_mode_r)
//
in
//
case+ opt of
| ~None_vt() =>
    (prerrln!("Cannot open the file: ", fname); 0)
| ~Some_vt(inp) =>
    let val nline =
      loop(inp, 0, 0) in fileref_close(inp); nline end
    // end of [let]
//
end // end of [wc_line]

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
added = $FWS.fworkshop_add_nworker(fws, N)
val () =
prerrln!("the number of workers = ", added)
//
val
root = (if argc >= 2 then argv[1] else "."): string
//
val nfile =
DirWalk
( fws, root
, lam(fname) => let
    val nline =
    wc_line(fname) in println!(fname, ": ", nline); 1
    // end of [val]
  end // end of [lam]
)
//
val () = println!("The total number of files: ", nfile)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [DirWalk.dats] *)

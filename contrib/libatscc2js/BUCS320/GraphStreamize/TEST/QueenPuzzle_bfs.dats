(*
For testing GraphStreamize_bfs
*)

(* ****** ****** *)
//
#define
ATS_STATIC_PREFIX "_QueenPuzzle_bfs_"
//
(* ****** ****** *)
//
#include "./../../../mylibies.hats"
//
#staload "./../../../SATS/print.sats"
#staload _ = "./../../../DATS/print.dats"
//
(* ****** ****** *)
//
#staload "./../DATS/GraphStreamize_bfs.dats"
//
(* ****** ****** *)

implement node_mark<>(nx) = ()
implement node_unmark<>(nx) = ()
implement node_is_marked<>(nx) = false

(* ****** ****** *)

#define N 8

(* ****** ****** *)

assume node_type = list0(int)
assume nodelst_vtype = stream_vt(node)

(* ****** ****** *)
//
implement
{}(*tmp*)
theStreamizeStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theStreamizeStore_insert(nx))
//
(* ****** ****** *)
//
implement
node_get_neighbors<>
  (nx0) = 
(
(N).stream_vt_map(TYPE{node})(lam x => cons0(x, nx0))
).filter()
  (
    lam nx =>
    let
      val-cons0(x0, nx) = nx
    in
      nx.iforall()(lam(i, x) => x0 != x && abs(x0 - x) != i+1)
    end // end of [let] // end of [lam]
  )
//
(* ****** ****** *)
//
extern
fun
QueenPuzzle_solve
(
// argumentless
) : stream(node) = "mac#"
//
implement
QueenPuzzle_solve
  ((*void*)) = res where
{
val
store =
qlistref_make_nil{node}()
//
val () =
qlistref_insert(store, nil0)
//
val res = GraphStreamize_bfs(store)
//
} (* end of [QueenPuzzle_solve] *)
//
(* ****** ****** *)

//
extern
fun
QueenPuzzle_solve_print
  () : void = "mac#"
//
implement
QueenPuzzle_solve_print
  ((*void*)) = let
//
val xss = QueenPuzzle_solve()
val xss = (xss).filter()(lam(xs) => length(xs) >= N)
//
in
  println! ("There are ", length(xss), " (full) solutions in total.")
end // end of [QueenPuzzle_solve_print]

(* ****** ****** *)

%{^
//
// file inclusion
//
var fs = require('fs');
eval(fs.readFileSync('./../../../output/libatscc2js_all.js').toString());
eval(fs.readFileSync('./../../../CATS/PRINT/print_store_cats.js').toString());
//
%} // end of [%{^]

(* ****** ****** *)

%{$
//
QueenPuzzle_solve_print();
process.stdout.write(ats2jspre_the_print_store_join());
//
%} // end of [%{$]

(* ****** ****** *)

(* end of [QueenPuzzle_bfs.dats] *)

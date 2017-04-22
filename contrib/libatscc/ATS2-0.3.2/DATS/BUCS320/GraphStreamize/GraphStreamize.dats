(* ****** ****** *)
//
// Generic
// Graph streamization
// for libatscc
//
(* ****** ****** *)

abstype node_type = ptr
absvtype nodelst_vtype = ptr

(* ****** ****** *)

typedef node = node_type
vtypedef nodelst = nodelst_vtype

(* ****** ****** *)
//
extern
fun{}
node_get_neighbors(nx: !node): nodelst
//
(* ****** ****** *)
//
extern
fun{}
theStreamizeStore_choose
  ((*void*)): Option_vt(node)
//
(* ****** ****** *)
//
extern
fun{}
theStreamizeStore_insert(node): void
extern
fun{}
theStreamizeStore_insert_lst(nodelst): void
//
(* ****** ****** *)
//
extern
fun{}
GraphStreamize((*void*)): stream(node)
//
(* ****** ****** *)

implement
{}(*tmp*)
GraphStreamize
  ((*void*)) =
  streamize() where
{
//
fun
streamize
(
// argless
): stream(node) = $delay
(
let
//
val
opt =
theStreamizeStore_choose<>()
//
in
//
case+ opt of
| ~None_vt() =>
  stream_nil()
| ~Some_vt(nx) => let
    val nxs =
    node_get_neighbors<>(nx)
    val ((*void*)) =
    theStreamizeStore_insert_lst<>(nxs)
  in
    stream_cons(nx, streamize())
  end // end of [Some]
//
end // end of [let]
) (* end of [streamize] *)
//
} (* end of [GraphStreamize] *)

(* ****** ****** *)

(* end of [GraphStreamize.dats] *)

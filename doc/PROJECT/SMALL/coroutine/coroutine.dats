//
// A simple implementation of Co-routines
//
(* ****** ****** *)

staload "./coroutine.sats"

(* ****** ****** *)

implement{a,b}
co_run_seq (co, xs) = let
//
fun loop {n:nat} .<n>.
(
  co: &cortn (a, b) >> _
, xs: list (a, n), res: &ptr? >> list_vt (b, n)
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val y = co_run<a,b> (co, x)
    val () = res := list_vt_cons{b}{0}(y, _)
    val+list_vt_cons (_, res1) = res
    val () = loop (co, xs, res1)
    prval () = fold@ (res)
  in
    // nothing
  end // end of [list_cons]
| list_nil () => (res := list_vt_nil{b}())
//
end // end of [loop]
//
var res: ptr
prval () = lemma_list_param (xs)
val () = loop (co, xs, res)
//
in
  res
end // end of [co_run_seq]

(* ****** ****** *)

(* end of [coroutine.dats] *)

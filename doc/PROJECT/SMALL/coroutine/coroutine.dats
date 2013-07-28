//
// A simple implementation of Co-routines
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./coroutine.sats"

(* ****** ****** *)

stadef co = cortn

(* ****** ****** *)

implement
{a,b}
co_run (co, x) = let
  val (y, co2) = co_run2<a,b> (co, x) in co := co2; y
end // end of [co_run]

(* ****** ****** *)

implement
{a,b}
co_run2
  (co, x) = res where
{
  val cf = cortn2lcfun{a,b}(co)
  val res = cf (x)
  val () = cloptr_free ($UN.castvwtp0{cloptr0}(cf))
} // end of [co_run2]

(* ****** ****** *)

implement
{a,b}
co_run_list
  (co, xs) = let
//
prval () = lemma_list_param (xs)
//
fun loop {n:nat} .<n>.
(
  co: &co (a, b) >> _
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
val () = loop (co, xs, res)
//
in
  res
end // end of [co_run_list]

(* ****** ****** *)

implement
{a,b,c}
co_fmap (co, f) =
lcfun2cortn{a,c}
(
llam x => let
  val (y, co) = co_run2<a,b> (co, x) in (f(y), co_fmap<a,b,c> (co, f))
end (* end of [llam] *)
) // end of [co_fmap]

(* ****** ****** *)

(* end of [coroutine.dats] *)

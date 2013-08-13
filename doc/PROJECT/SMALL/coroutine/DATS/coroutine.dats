//
// A simple implementation of Co-routines
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "../SATS/coroutine.sats"

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

implement
{a,b}
co_arr (f) = lcfun2cortn{a,b} (llam (x) => (f (x), co_arr<a,b> (f)))

(* ****** ****** *)

implement
{a,b,c}
co_arr_fst (co) =
lcfun2cortn{@(a,c),@(b,c)}
(
llam @(x1, x2) => let
  val (y1, co) = co_run2<a,b> (co, x1) in ((y1, x2), co_arr_fst (co))
end (* end of [llam] *)
) // end of [co_arr_fst]

implement
{a,b,c}
co_arr_snd (co) =
lcfun2cortn{@(c,a),@(c, b)}
(
llam @(x1, x2) => let
  val (y2, co) = co_run2<a,b> (co, x2) in ((x1, y2), co_arr_snd (co))
end (* end of [llam] *)
) // end of [co_arr_snd]

(* ****** ****** *)

implement
{a,b,c}
co_arr_bind
  (cof, cog) =
lcfun2cortn{a,c}
(
llam x => let
  val (y, cof) = co_run2<a,b> (cof, x)
  val (z, cog) = co_run2<b,c> (cog, y) in (z, co_arr_bind (cof, cog))
end (* end of [llam] *)
) // end of [co_arr_bind]

(* ****** ****** *)

implement
{a,b,c}
co_arr_fanout
  (cof, cog) = 
lcfun2cortn{a,@(b,c)}
(
llam (x) => let
  val (y, cof) = co_run2<a,b> (cof, x)
  val (z, cog) = co_run2<a,c> (cog, x) in ((y, z), co_arr_fanout (cof, cog))
end (* end of [llam] *)
) // end of [co_arr_fanout]

(* ****** ****** *)

implement
{a,b}
co_arr_loop
  (co, y0) =
lcfun2cortn{a,b}
(
llam x => let
  val (y1, co) = co_run2<(a,b),b> (co, @(x, y0)) in (y1, co_arr_loop<a,b> (co, y1))
end (* end of [llam] *)
) // end of [co_arr_loop]

(* ****** ****** *)

(* end of [coroutine.dats] *)

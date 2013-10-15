(* ****** ****** *)
//
// HX-2013-10
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{a:vt0p} foo (x: &a >> _): void

(* ****** ****** *)

extern
fun{a:vt0p} foo2 (r: ref(a)): void

implement
{a}(*tmp*)
foo2 (r) =
{
  val (vbox pf | p) = ref_get_viewptr (r)
  val ((*void*)) = $effmask_ref (foo (!p))
} 

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-91.dats] *)

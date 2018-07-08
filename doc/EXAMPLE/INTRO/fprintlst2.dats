(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload _ = "libats/ML/DATS/list0.dats"

(* ****** ****** *)

implement
{x}{env}
list_iforeach_env
  (xs, env) = let
//
prval () = lemma_list_param (xs)
//
fun loop
  {n:nat}
  {i:nat} .<n>. (
  i: int i, xs: list (x, n), env: &env
) : intBtwe(i,n+i) =
  case+ xs of
  | list_cons
      (x, xs) => let
      val () = list_iforeach$fwork<x><env> (i, x, env)
    in
      loop (succ(i), xs, env)
    end // end of [list_cons]
  | list_nil () => (i) // number of processed elements
// end of [loop]
//
in
  loop (0, xs, env)
end // end of [list_iforeach_env]

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
//
val xs1 = g0ofg1($list{int}(0,1,2,3,4))
val xs2 = g0ofg1($list{int}(5,6,7,8,9))
val xss = cons0{list0(int)}(xs1, cons0{list0(int)}(xs2, nil0()))
//
(*
implement
fprint_val<list0(int)> (out, xs) = ()
*)
local
implement
fprint_val<list0(int)>
  (out, xs) = fprint_list0_sep<int> (out, xs, ", ")
in(*in-of-local*)
val () = fprint_list0_sep<list0(int)> (out, xss, "; ")
end // end of [local]
//
val ((*void*)) = fprint_newline (out)
//
} (* end of [val] *)

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("The code has passed all the tests given here.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [fprintlst2.dats] *)

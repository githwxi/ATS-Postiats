(*
** Some functions for traversing aggregates
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "contrib/atshwxi/testing/SATS/foreach.sats"

(* ****** ****** *)

implement{}
foreach_int (n) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: int n, i: int i
) : void =
  if i < n then let
    val () = foreach_int$fwork (i) in loop (n, succ(i))
  end else () // end of [if]
(* end of [loop] *)
//
in
  loop (n, 0)
end // end of [foreach_int]

(* ****** ****** *)

implement{}
foreach_size (n) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: size_t (n), i: size_t (i)
) : void =
  if i < n then let
    val () = foreach_size$fwork (i) in loop (n, succ(i))
  end else () // end of [if]
(* end of [loop] *)
//
in
  loop (n, g1int2uint(0))
end // end of [foreach_size]

(* ****** ****** *)

implement{a}
foreach_list (xs) = let
//
implement(env)
list_foreach$cont<a><env> (x, env) = true
implement(env)
list_foreach$fwork<a><env> (x, env) = foreach_list$fwork<a> (x)
//
in
  list_foreach<a> (xs)
end // end of [foreach_list]

(* ****** ****** *)

implement{a}
iforeach_list (xs) = let
//
implement(env)
list_iforeach$cont<a><env> (i, x, env) = true
implement(env)
list_iforeach$fwork<a><env> (i, x, env) = iforeach_list$fwork<a> (i, x)
//
in
  ignoret (list_iforeach<a> (xs))
end // end of [iforeach_list]

(* ****** ****** *)

implement{a}
foreach_list_vt (xs) = let
//
implement(env)
list_vt_foreach$cont<a><env> (x, env) = true
implement(env)
list_vt_foreach$fwork<a><env> (x, env) = foreach_list_vt$fwork<a> (x)
//
in
  list_vt_foreach<a> (xs)
end // end of [foreach_list_vt]

(* ****** ****** *)

implement{a}
iforeach_list_vt (xs) = let
//
implement(env)
list_vt_iforeach$cont<a><env> (i, x, env) = true
implement(env)
list_vt_iforeach$fwork<a><env> (i, x, env) = iforeach_list_vt$fwork<a> (i, x)
//
in
  ignoret (list_vt_iforeach<a> (xs))
end // end of [iforeach_list_vt]

(* ****** ****** *)

implement{a}
foreach_array (A, n) = let
//
implement(env)
array_foreach$cont<a><env> (x, env) = true
implement(env)
array_foreach$fwork<a><env> (x, env) = foreach_array$fwork<a> (x)
//
in
  ignoret (array_foreach<a> (A, n))
end // end of [foreach_array]

(* ****** ****** *)

implement{a}
iforeach_array (A, n) = let
//
typedef tenv = size_t
//
implement
array_foreach$cont<a><tenv> (x, env) = true
implement(env)
array_foreach$fwork<a><tenv> (x, env) = let
  val i = env; val () = env := succ (i) in iforeach_array$fwork<a> (i, x)
end // end of [array_foreach$fwork]
//
var env: tenv = g1int2uint (0)
//
in
  ignoret (array_foreach_env<a><tenv> (A, n, env))
end // end of [iforeach_array]

(* ****** ****** *)

local

staload IT = "prelude/SATS/iterator.sats"

in // in of [local]

implement
{knd}{x}
foreach_fiterator
  {kpm}{f,r} (itr) = let
//
val () = $IT.lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = $IT.iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !iter (f, r) >> iter (f+r, 0)
) : void = let
  val test = $IT.iter_isnot_atend (itr)
in
  if test then let
    val x = $IT.iter_get_inc (itr)
    val () = foreach_fiterator$fwork (x)
  in
    loop (itr)
  end else () // end of [if]
end (* end of [loop] *)
//
in
  loop (itr)
end // end of [foreach_fiterator]

(* ****** ****** *)

implement
{knd}{x}
foreach_literator
  {kpm}{f,r} (itr) = let
//
val () = $IT.lemma_iterator_param (itr)
//
stadef iter
  (f:int, r:int) = $IT.iterator (knd, kpm, x, f, r)
//
fun loop
  {f,r:int | r >= 0} .<r>. (
  itr: !iter (f, r) >> iter (f+r, 0)
) : void = let
  val test = $IT.iter_isnot_atend (itr)
in
  if test then let
    val p = $IT.iter_getref_inc (itr)
    prval (pf, fpf) = $UN.ptr_vtake {x} (p)
    val () = foreach_literator$fwork (!p)
    prval () = fpf (pf)
  in
    loop (itr)
  end else () // end of [if]
end (* end of [loop] *)
//
in
  loop (itr)
end // end of [foreach_literator]

end // end of [local]

(* ****** ****** *)

(* end of [foreach.dats] *)

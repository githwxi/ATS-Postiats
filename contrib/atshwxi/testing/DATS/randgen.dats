(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

staload F =
"contrib/atshwxi/testing/SATS/foreach.sats"
// end of [staload]

(* ****** ****** *)

staload
"contrib/atshwxi/testing/SATS/randgen.sats"
// end of [staload]

(* ****** ****** *)
//
implement randgen<int> () = 0
implement randgen<uint> () = 0u
//
implement randgen<lint> () = 0l
implement randgen<ulint> () = 0ul
//
implement randgen<llint> () = 0ll
implement randgen<ullint> () = 0ull
//
implement randgen<float> () = 0.0f
implement randgen<double> () = 0.0
implement randgen<ldouble> () = 0.0l
//
(* ****** ****** *)

implement{a}
randgen_list
  (n) = res where {
  fun loop
    {n:nat} .<n>. (
    n: int n
  , res: &ptr? >> list_vt (a, n)
  ) : void =
    if n > 0 then let
      val () = res :=
        list_vt_cons{a}{0} (_, _)
      val+ list_vt_cons (x, res1) = res
      val () = x := randgen<a> ()
      val () = loop (pred (n), res1)
    in
      fold@ (res)
    end else (res := list_vt_nil)
  // end of [loop]
  var res: ptr // uninitialized
  val () = loop (n, res)
} // end of [randgen_list]

(* ****** ****** *)

implement{a}
randgen_array (A, n) = let
//
implement
$F.iforeach_array_init__fwork<a> (_, x) = x := randgen<a> ()
//
in
  $F.iforeach_array_init<a> (A, n)
end // end of [randgen_array]

implement{a}
randgen_arrayptr
  (n) = A where {
  val A = arrayptr_make_uninitized<a> (n)
  val p = ptrcast (A)
  prval pf = arrayptr_takeout (A)
  val () = randgen_array (!p, n)
  prval () = arrayptr_addback (pf | A)
} // end of [randgen_arrayptr]

(* ****** ****** *)

(* end of [randgen.dats] *)

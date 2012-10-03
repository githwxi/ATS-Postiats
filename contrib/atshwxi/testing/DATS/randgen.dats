(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

staload
"contrib/atshwxi/testing/SATS/randgen.sats"
// end of [staload]

(* ****** ****** *)

implement{a}
randgen_ref (x) = x := randgen_val<a> ()

(* ****** ****** *)
//
implement randgen_val<int> () = 0
implement randgen_val<uint> () = 0u
//
implement randgen_val<lint> () = 0l
implement randgen_val<ulint> () = 0ul
//
implement randgen_val<llint> () = 0ll
implement randgen_val<ullint> () = 0ull
//
implement randgen_val<float> () = 0.0f
implement randgen_val<double> () = 0.0
implement randgen_val<ldouble> () = 0.0l
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
      val () = randgen_ref<a> (x)
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
randgen_arrayptr
  (n) = A where {
//
val A = arrayptr_make_uninitized<a> (n)
//
implement
array_initize$init<a> (_, x) = randgen_ref<a> (x)
//
prval pf = arrayptr_takeout (A)
val () = array_initize<a> (!(ptrcast(A)), n)
prval () = arrayptr_addback (pf | A)
//
} // end of [randgen_arrayptr]

(* ****** ****** *)

(* end of [randgen.dats] *)

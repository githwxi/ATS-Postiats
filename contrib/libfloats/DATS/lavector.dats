(* ****** ****** *)
//
// Linear Algebra vector operations
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/gvector.sats"
staload "libats/SATS/refcount.sats"

(* ****** ****** *)

staload "libfloats/SATS/blas.sats"

(* ****** ****** *)

staload "libfloats/SATS/lavector.sats"

(* ****** ****** *)

local

vtypedef
sourcerfc = refcnt (ptr)

datavtype
LAgvec
  (a:t@ype, int) =
  {n:int}{d:int | d >= 1}
  LAGVEC (a, n) of (uint(*rfc*), sourcerfc, ptr, int(n), int(d))
// end of [LAgvec]

assume
LAgvec_vtype
  (a:t0p, l:addr, n:int) = LAgvec (a, n)
// end of [assume]

in (* in of [local] *)

(* ****** ****** *)

implement{}
LAgvec_size (V) = let
//
val+LAGVEC(_, _, _, n, _) = V in n
//
end // end of [LAgvec_size]

(* ****** ****** *)

implement{}
LAgvec_vtakeout_vector
  {a}{n} (V, d0) = let
//
val+LAGVEC
  (_, _, gvp, n, d) = V
val () = (d0 := d)
prval [d:int]
  INTEQ () = inteq_make_gint (d)
//
in
  $UN.ptr0_vtake{gvector(a,n,d)}(gvp)
end // end of [LAgvec_vtakeout_vector]

(* ****** ****** *)

implement{}
LAgvec_incref
  {a}{l}{n} (V) = let
//
val+@LAGVEC(rfc, _, _, _, _) = V
val ((*void*)) = (rfc := succ(rfc))
prval () = fold@(V)
//
in
  $UN.castvwtp1{LAgvec(a,l,n)}(V)
end // end of [LAgvec_incref]

(* ****** ****** *)

implement{}
LAgvec_decref
  {a}{l}{n} (V) = let
//
val+@LAGVEC
  (rfc, src, _, _, _) = V
val rfc1 = pred (rfc)
//
in (* in of [LAgvec_decref] *)
//
if
isgtz(rfc1)
then let
  val () = rfc := rfc1
  prval () = fold@(V)
  prval () = $UN.cast2void (V)
in
  // nothing
end else let
  val opt =
    refcnt_decref_opt (src)
  val () = free@{a}{n}{1}(V)
  extern
  fun __free (ptr): void = "mac#atspre_mfree_gc"
in
  case+ opt of
  | ~Some_vt (gvp) => __free(gvp) | ~None_vt () => ()
end // end of [if]
//
end // end of [LAgvec_decref]

(* ****** ****** *)

implement{}
LAgvec_make_arrayptr
  (A, n) = let
  val pA = $UN.castvwtp0{ptr}(A)
  val src = refcnt_make<ptr> (pA)
in
  LAGVEC (1u, src, pA, n, 1)
end // end of [LAgvec_make_arrayptr]

implement{a}
LAgvec_split
  (V, i) = let
//
val+LAGVEC
  (_, src, p, n, d) = V
//
val src1 = refcnt_incref (src)
val src2 = refcnt_incref (src)
val ((*void*)) = LAgvec_decref (V)
//
val p1 = p
val i1 = i
val p2 = ptr_add<a> (p, i)
val i2 = n-i
val V1 = LAGVEC (1u, src1, p1, i1, d)
val V2 = LAGVEC (1u, src2, p2, i2, d)
//
in
  (V1, V2)
end // end of [LAgvec_split]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement{}
fprint_LAgvec$sep
  (out) = fprint_gvector$sep<> (out)
implement{a}
fprint_LAgvec (out, V) = let
//
val n = LAgvec_size (V)
//
var d: int
val (pf, fpf | p) = LAgvec_vtakeout_vector (V, d)
//
val () = fprint_gvector (out, !p, n, d)
//
prval () = fpf (pf)
//
in
  // nothing
end // end of [fprint_LAgvec]

(* ****** ****** *)

implement{a}
LAgvec_inner
  (V1, V2) = let
//
val n = LAgvec_size V1
//
var d1: int and d2: int
//
val
(
  pf1, fpf1 | p1
) = LAgvec_vtakeout_vector (V1, d1)
val
(
  pf2, fpf2 | p2
) = LAgvec_vtakeout_vector (V2, d2)
//
val res = blas_inner (!p1, !p2, n, d1, d2)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  res
end // end of [LAgvec_inner]

(* ****** ****** *)

implement{a}
add11_LAgvec_LAgvec
  (V1, V2) = res where
{
//
val res = copy_LAgvec (V2)
val ((*void*)) = LAgvec_1x1y (V1, res)
//
} // end of [add11_LAgvec_LAgvec]

(* ****** ****** *)

(* end of [lavector.dats] *)

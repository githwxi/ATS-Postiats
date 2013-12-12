(*
** ATS data for use in Java
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload JNI = "JNI/SATS/jni.sats"

(* ****** ****** *)

stadef jint = $JNI.jint
stadef jlong = $JNI.jlong
stadef JNIEnvPtr = $JNI.JNIEnvPtr
stadef jobject0 = $JNI.jobject0

(* ****** ****** *)

extern
fun
Java_MyMatrix__1make_1elt
(
  !JNIEnvPtr, !jobject0, m: jint, n: jint, x0: jint
) : jlong(*MyMatrix*) = "ext#"

(* ****** ****** *)

extern
fun
Java_MyMatrix__1get_1at
(
  !JNIEnvPtr, !jobject0, M: jlong, i: jint, j: jint
) : jint = "ext#" // end of [Java_MyMatrix__1get_1at]

extern
fun
Java_MyMatrix__1set_1at
(
  !JNIEnvPtr, !jobject0, M: jlong, i: jint, j: jint, x0: jint
) : void = "ext#" // end of [Java_MyMatrix__1set_1at]

(* ****** ****** *)

staload "MyMatrix.sats"

(* ****** ****** *)

implement
Java_MyMatrix__1make_1elt
  (env, obj, m, n, x0) = let
  val m = $UN.cast{Size}(m)
  val n = $UN.cast{Size}(n)
  val x0 = $UN.cast{int}(x0)
in
  $UN.cast{jlong}(MyMatrix__1make_elt (m, n, x0))
end // end of [Java_MyMatrix__1make_1elt]

(* ****** ****** *)

implement
Java_MyMatrix__1get_1at
  (env, obj, M, i, j) = let
  val M =
    $UN.cast{MyMatrix}(M)
  val i = $UN.cast{int}(i)
  and j = $UN.cast{int}(j) in $UN.cast{jint}(M[i,j])
end // end of [Java_MyMatrix__1get_1at]

(* ****** ****** *)

implement
Java_MyMatrix__1set_1at
  (env, obj, M, i, j, x0) = let
  val M =
    $UN.cast{MyMatrix}(M)
  val i = $UN.cast{int}(i)
  and j = $UN.cast{int}(j) in M[i,j] := $UN.cast2int(x0)
end // end of [Java_MyMatrix__1set_1at]

(* ****** ****** *)

local

assume
MyMatrix_type = mtrxszref(int)

in (* in of [local] *)
//
implement
MyMatrix__1make_elt
  (m, n, x0) = mtrxszref_make_elt (m, n, x0)
//
implement
MyMatrix__1get_at (M, i, j) = mtrxszref_get_at_gint (M, i, j)
implement
MyMatrix__1set_at (M, i, j, x) = mtrxszref_set_at_gint (M, i, j, x)
//
end // end of [local]

(* ****** ****** *)

%{$
//
// HX: This is ATS runtime:
//
#include "pats_ccomp_runtime.c"
#include "pats_ccomp_runtime2_dats.c"
#include "pats_ccomp_runtime_memalloc.c"
#include "pats_ccomp_runtime_trywith.c"
%}

(* ****** ****** *)

(* end of [MyMatrix.dats] *)

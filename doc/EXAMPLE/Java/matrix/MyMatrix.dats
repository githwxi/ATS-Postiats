(*
** Exporting a matrix in ATS for use in Java
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
Java_MyMatrix_matrix_1make_1elt
(
  !JNIEnvPtr, !jobject0, m: jint, n: jint, x0: jint
) : jlong(*matrix*) = "ext#"

(* ****** ****** *)

extern
fun
Java_MyMatrix_matrix_1get_1at
(
  !JNIEnvPtr, !jobject0, M: jlong, i: jint, j: jint
) : jint = "ext#" // end of [Java_MyMatrix_matrix_1get_1at]

extern
fun
Java_MyMatrix_matrix_1set_1at
(
  !JNIEnvPtr, !jobject0, M: jlong, i: jint, j: jint, x0: jint
) : void = "ext#" // end of [Java_MyMatrix_matrix_1set_1at]

(* ****** ****** *)

implement
Java_MyMatrix_matrix_1make_1elt
  (env, obj, m, n, x0) = let
  val m = $UN.cast{Size}(m)
  val n = $UN.cast{Size}(n)
  val x0 = $UN.cast{int}(x0)
in
  $UN.cast{jlong}(mtrxszref_make_elt<int> (m, n, x0))
end // end of [Java_MyMatrix_matrix_1make_1elt]

(* ****** ****** *)

implement
Java_MyMatrix_matrix_1get_1at
  (env, obj, M, i, j) = let
  val M = $UN.cast{mtrxszref(jint)}(M)
  val i = $UN.cast{int}(i) and j = $UN.cast{int}(j) in M[i,j]
end // end of [Java_MyMatrix_matrix_1get_1at]

(* ****** ****** *)

implement
Java_MyMatrix_matrix_1set_1at
  (env, obj, M, i, j, x0) = let
  val M = $UN.cast{mtrxszref(jint)}(M)
  val i = $UN.cast{int}(i) and j = $UN.cast{int}(j) in M[i,j] := $UN.cast{jint}(x0)
end // end of [Java_MyMatrix_matrix_1set_1at]

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

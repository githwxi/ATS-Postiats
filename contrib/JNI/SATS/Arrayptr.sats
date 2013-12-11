(*
** Arrayptr in ATS for use in Java
*)

(* ****** ****** *)

staload "./jni.sats"

(* ****** ****** *)

fun Java_Arrayptr_make_1elt
  (!JNIEnvPtr, jclass, asz: jlong, x0: jlong): jlong = "ext#"

(* ****** ****** *)

fun Java_Arrayptr_get_1at
  (!JNIEnvPtr, jclass, A: jlong, i: jlong): jlong = "ext#"
fun Java_Arrayptr_set_1at
  (!JNIEnvPtr, jclass, A: jlong, i: jlong, x: jlong): void = "ext#"

(* ****** ****** *)

fun Java_Arrayptr_free (!JNIEnvPtr, jclass, A: jlong): void = "ext#"

(* ****** ****** *)

(* end of [Arrayptr.sats] *)

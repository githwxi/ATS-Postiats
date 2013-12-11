(*
** arrayptr in ATS for use in Java
*)

(* ****** ****** *)

staload "./jni.sats"

(* ****** ****** *)

fun Java_ATSarrayptr_make_1elt
  (!JNIEnvPtr, jclass, asz: jsize, x0: jboxed): jboxed = "ext#"

(* ****** ****** *)

fun Java_ATSarrayptr_get_1at
  (!JNIEnvPtr, jclass, A: jboxed, i: jsize): jboxed = "ext#"
fun Java_ATSarrayptr_set_1at
  (!JNIEnvPtr, jclass, A: jboxed, i: jsize, x: jboxed): void = "ext#"

(* ****** ****** *)

fun Java_ATSarrayptr_free (!JNIEnvPtr, jclass, A: jboxed): void = "ext#"

(* ****** ****** *)

(* end of [ATSarrayptr.sats] *)

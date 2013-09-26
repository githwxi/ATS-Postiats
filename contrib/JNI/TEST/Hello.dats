(*
** A simple exampe of
** calling ATS functions from Java
*)

(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

staload JNI = "./../SATS/jni.sats"

(* ****** ****** *)

stadef JNIEnvPtr = $JNI.JNIEnvPtr
stadef jstring (l:addr) = $JNI.jstring(l)
stadef jobject (l:addr) = $JNI.jobject(l)

(* ****** ****** *)
//
// HX: helloFrom is declared in Java class [Hello]
//
extern
fun helloFrom{l1,l2:addr}
(
  env: !JNIEnvPtr, obj: !jobject l1, whom: jstring l2
) : void = "ext#Java_Hello_helloFrom" // endfun

(* ****** ****** *)

implement
helloFrom
  (env, obj, whom) = let
//
val (
) = assertloc ($JNI.jstring2ptr(whom) > 0)
//
val (pf | whom2) = $JNI.GetStringUTFChars (env, whom)
val () = println! ("Hello from ", whom2, "!")
val () = $JNI.ReleaseStringUTFChars (pf | env, whom, whom2)
//
in
  // nothing
end // end of [printHelloFrom]

(* ****** ****** *)

(* end of [Hello.dats] *)

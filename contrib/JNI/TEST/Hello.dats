(*
** A simple exampe of
** calling ATS functions from Java
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: Summer, 2012
//
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

staload JNI = "./../SATS/jni.sats"

(* ****** ****** *)
//
// HX: helloFrom is declared in Java class [Hello]
//
extern
fun
Java_Hello_helloFrom
(
  $JNI.JNIEnvPtr, $JNI.jobject0, whom: $JNI.jstring0
) : void = "ext#" // end of [fun]
//
(* ****** ****** *)

implement
Java_Hello_helloFrom
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
end // end of [Java_Hello_helloFrom]

(* ****** ****** *)

(* end of [Hello.dats] *)

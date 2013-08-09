(*
**
** An interface for ATS to interact with JNI
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Start Time: September, 2011
**
*)

(* ****** ****** *)
//
// Ported to ATS/Postiats by Hongwei Xi (August, 2013)
//
(* ****** ****** *)

%{#
#include "JNI/CATS/jni.cats"
%} // end of [%{#]

(* ****** ****** *)

#define ATS_PACKNAME "ATSCNTRB.JNI"
#define ATS_STALOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atscntrb_JNI_" // prefix for external names

(* ****** ****** *)
//
abst@ype jint = $extype"jint"
abst@ype jshort = $extype"jshort"
abst@ype jlong = $extype"jlong"
abst@ype jsize = $extype"jsize"
//
abst@ype jboolean = $extype"jboolean"
//
abst@ype jchar = $extype"jchar"
abst@ype jbyte = $extype"jbyte"
//
abst@ype jfloat = $extype"jfloat"
abst@ype jdouble = $extype"jdouble"
//
typedef Void = void
//
(* ****** ****** *)

abstype jstring = $extype"jstring"

(* ****** ****** *)

abstype jclass = ptr
abstype jobject (l:addr) = ptr
abstype jstring (l:addr) = ptr
typedef jstring = [l:addr] jstring (l)
typedef jstring0 = [l:agez] jstring (l)
typedef jstring1 = [l:addr | l > null] jstring (l)

(* ****** ****** *)

absvtype JNIEnvPtr = ptr // (JNIEnv *ptr)

(* ****** ****** *)

fun NewStringUTF
  (env: !JNIEnvPtr, str: string): jstring0 = "mac#%"
// end of [NewStringUTF]

(* ****** ****** *)

absview
GetStringUTFChars_v (src:addr, dst:addr)

fun
GetStringUTFChars{l1:agz}
(
  env: !JNIEnvPtr, x: jstring l1
) : [l2:addr]
(
  GetStringUTFChars_v (l1, l2) | strptr l2
) = "mac#%" // endfun

fun
ReleaseStringUTFChars{l1:agz}{l2:addr}
(
  pf: GetStringUTFChars_v (l1, l2)
| env: !JNIEnvPtr, src: jstring (l1), dst: strptr (l2)
) : void = "mac#%" // endfun

(* ****** ****** *)

(* end of [jni.sats] *)

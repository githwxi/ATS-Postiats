/*
**
** An interface for ATS to interact with JNI
** Contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Start Time: September, 2011
**
*/

/* ****** ****** */
//
// Ported to ATS/Postiats by Hongwei Xi (August, 2013)
//
/* ****** ****** */

#ifndef ATSCNTRB_JNI_JNI_CATS
#define ATSCNTRB_JNI_JNI_CATS

/* ****** ****** */

#include <jni.h>

/* ****** ****** */

ATSinline()
atstype_ptr
JNI_NewStringUTF
(
  atstype_ptr env, atstype_ptr str
) {
  return (*((JNIEnv*)env))->NewStringUTF((JNIEnv*)env, (char*)str) ;
} // end of [JNI_GetStringUTFChars]

#define atscntrb_JNI_NewStringUTF JNI_NewStringUTF

/* ****** ****** */

ATSinline()
atstype_ptr
JNI_GetStringUTFChars
(
  atstype_ptr env, atstype_ptr src
) {
  return
  (char*)((*((JNIEnv*)env))->GetStringUTFChars((JNIEnv*)env, (jstring)src, (jboolean*)0)) ;
} // end of [JNI_GetStringUTFChars]

ATSinline()
atsvoid_t0ype
JNI_ReleaseStringUTFChars
(
  atstype_ptr env, atstype_ptr src, atstype_ptr dst
) {
  (*((JNIEnv*)env))->ReleaseStringUTFChars((JNIEnv*)env, (jstring)src, (char*)dst) ; return ;
} // end of [JNI_ReleaseStringUTFChars]

#define atscntrb_JNI_GetStringUTFChars JNI_GetStringUTFChars
#define atscntrb_JNI_ReleaseStringUTFChars JNI_ReleaseStringUTFChars

/* ****** ****** */

#endif /* [ATSCNTRB_JNI_JNI_CATS] */

/* end of [jni.cats] */

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
jstring JNI_NewStringUTF
(
  JNIEnv *env, char *cstr
) {
  return (*env)->NewStringUTF(env, cstr) ;
} // end of [JNI_GetStringUTFChars]

#define atscntrb_JNI_NewStringUTF JNI_NewStringUTF

/* ****** ****** */

ATSinline()
char* JNI_GetStringUTFChars
(
  JNIEnv *env, jstring jstr
) {
  return
  (char*)((*env)->GetStringUTFChars(env, jstr, (jboolean*)0)) ;
} // end of [JNI_GetStringUTFChars]

ATSinline()
void JNI_ReleaseStringUTFChars
(
  JNIEnv *env, jstring jstr, char *cstr
) {
  (*env)->ReleaseStringUTFChars(env, jstr, cstr) ; return/*void*/ ;
} // end of [JNI_ReleaseStringUTFChars]

#define atscntrb_JNI_GetStringUTFChars JNI_GetStringUTFChars
#define atscntrb_JNI_ReleaseStringUTFChars JNI_ReleaseStringUTFChars

/* ****** ****** */

ATSinline()
void JNI_RaiseExceptionByClassName
(
  JNIEnv *env, char *clsname, char *msg
) {
  jclass jcls ;
//
  jcls = (*env)->FindClass(env, clsname) ;
//
  if (jcls)
  {
    (*env)->ThrowNew(env, jcls, msg) ; (*env)->DeleteLocalRef(env, jcls) ;
  }
//
  return ;
//
} // end of [JNI_raiseExnByClassName]

#define atscntrb_JNI_RaiseExceptionByClassName JNI_RaiseExceptionByClassName

/* ****** ****** */

#endif /* [ATSCNTRB_JNI_JNI_CATS] */

/* end of [jni.cats] */

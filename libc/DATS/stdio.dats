(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: May, 2012
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libc"
#define ATS_DYNLOADFLAG 0 // no need for dynloading at run-time
#define ATS_EXTERN_PREFIX "atslib_" // prefix for external names

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_fopen_exn
(
  atstype_string path
, atstype_string mode
) {
  FILE* filp ;
  filp = fopen ((char*)path, (char*)mode) ;
  if (!filp) ATSLIBfailexit("fopen") ; // HX: failure
  return filp ;
} // end of [atslib_fopen_exn]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fclose_exn
  (atstype_ptr filp) {
  int err ;
  err = fclose ((FILE*)filp) ;
  if (0 > err) ATSLIBfailexit("fclose") ;
  return ;
} // end of [atslib_fclose_exn]
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fflush_exn
(
  atstype_ptr filp
) {
  int err = fflush((FILE*)filp) ;
  if (0 > err) ATSLIBfailexit("fflush") ;
  return ;
} /* end of [atslib_fflush_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fgets_exn
(
  atstype_ptr buf
, atstype_int bsz
, atstype_ptr filp
) {
  atstype_ptr p ;
  p = fgets((char*)buf, (int)bsz, (FILE*)filp) ;
  if (!p)
  {
    if (feof((FILE*)filp))
    {
      *(char*)buf = '\000' ; // EOF is reached
    } else {
      ATSLIBfailexit("fgets") ; // abnormal exit
    } // end of [if]
  } /* end of [if] */
  return ;  
} /* end of [atslib_fgets_exn] */
%}

(* ****** ****** *)

%{
extern
atsvoid_t0ype
atslib_fputs_exn
(
  atstype_string str, atstype_ptr filp
) {
  int err ;
  err = fputs((char*)str, (FILE*)filp) ;
  if (0 > err) {
    ATSLIBfailexit("fputs") ; // abnormal exit
  } /* end of [if] */
  return ;  
} /* end of [atslib_fputs_exn] */
%}

(* ****** ****** *)

%{
extern
atstype_ptr
atslib_tmpfile_exn(
) {
  FILE* filp = tmpfile() ;
  if (!filp) ATSLIBfailexit("tmpfile") ;
  return (filp) ;
} // end of [atslib_tmpfile_exn]
%}

(* ****** ****** *)

(* end of [stdio.dats] *)

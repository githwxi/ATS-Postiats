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

%{
atstype_ptr
atslib_fopen_exn
(
  atstype_string path
, atstype_string mode
) {
  FILE* filp ;
  filp = atslib_fopen_err (filp) ;
  if (!filp) {
    perror ("fopen") ;    
    fprintf (stderr, (atstype_string)"exit(ATSLIB): [fopen] failed.\n") ;
    exit (1) ;
  } // end of [if]
  return filp ;
} // end of [atslib_fopen_exn]
%}

(* ****** ****** *)

%{
atsvoid_t0ype
atslib_fclose_exn
  (atstype_ptr filp) {
  int err ;
  err = atslib_fclose_err (filp) ;
  if (err < 0) {
    perror ("fclose") ;    
    fprintf (stderr, (atstype_string)"exit(ATSLIB): [fclose] failed.\n") ;
    exit (1) ;
  } // end of [if]
  return ;
} // end of [atslib_fclose_exn]
%}

(* ****** ****** *)

%{
atsvoid_t0ype
atslib_fflush_exn
(
  atstype_ptr filp
) {
  int err = fflush((FILE*)filp) ;
  if (err < 0) {
    perror ("fflush") ;
    ats_exit_errmsg (1, (atstype_string)"exit(ATSLIB): [fflush] failed\n") ;
  } // end of [if]
  return ;
} /* end of [atslib_fflush_exn] */
%}

(* ****** ****** *)

%{
atsvoid_t0ype
atslib_fgets_exn (
  atstype_ptr buf
, ats_int_type n
, atstype_ptr filp
) {
  atstype_ptr p ;
  p = fgets((char*)buf, (int)n, (FILE*)filp) ;
  if (!p) {
    if (feof((FILE*)filp)) {
      *(char*)buf = '\000' ; // EOF is reached
    } else {
      perror ("fgets") ;
      ats_exit_errmsg(1, (atstype_string)"exit(ATSLIB): [fgets] failed\n") ;
    } // end of [if]
  } /* end of [if] */
  return ;  
} /* end of [atslib_fgets_exn] */
%}

(* ****** ****** *)

(* end of [stdio.dats] *)

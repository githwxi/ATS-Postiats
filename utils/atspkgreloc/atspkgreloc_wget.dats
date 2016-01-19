(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: May, 2014 *)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/jsonats/SATS/jsonats.sats"
//
(* ****** ****** *)
//
staload _ = "libats/DATS/stringbuf.dats"
//
staload
_ = "{$LIBATSHWXI}/cstream/DATS/cstream.dats"
staload
_ = "{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
staload
_ = "{$LIBATSHWXI}/jsonats/DATS/jsonats.dats"
//
(* ****** ****** *)
//
extern
fun wget_params
  (source: string, target: string): (int, string)
//
(* ****** ****** *)

local

fun
suffix_max{n1,n2:int}
(
  str1: string(n1), n1: size_t(n1)
, str2: string(n2), n2: size_t(n2)
) : sizeLte(min(n1,n2)) = let
//
fun auxmain
(
  p1: ptr, p2: ptr, n: size_t
) : size_t =
  if n > 0 then let
    val p1 = ptr_pred<char> (p1)
    val p2 = ptr_pred<char> (p2)
    val c1 = $UN.ptr0_get<char> (p1)
    val c2 = $UN.ptr0_get<char> (p2)
  in
    if c1 = c2 then auxmain (p1, p2, pred(n)) else n
  end else (n) // end of [if]
//
val p1 = ptr_add<char> (string2ptr(str1), n1)
val p2 = ptr_add<char> (string2ptr(str2), n2)
//
val n12 = min (n1, n2)
val n12_ = auxmain (p1, p2, n12)
//
in
  $UN.cast{sizeLte(min(n1,n2))}(n12 - n12_)
end // end of [suffix_max]

in (* in-of-local *)

implement
wget_params
  (source, target) = let
//
(*
val () =
println! ("wget_params: source = ", source)
val () =
println! ("wget_params: target = ", target)
*)
//
val source = g1ofg0 (source)
val target = g1ofg0 (target)
val n1 = string_length (source)
val n2 = string_length (target)
//
val n12 = suffix_max (source, n1, target, n2)
//
(*
val () =
  println! ("wget_params: suffix_max = ", n12)
*)
//
fun aux1
(
  p: ptr, n: size_t, res: int
) : int =
  if n > 0 then let
    val c = $UN.ptr0_get<char> (p)
  in
    if (c != '/')
      then aux1 (ptr_succ<char> (p), pred(n), res)
      else aux2 (ptr_succ<char> (p), pred(n), res)
    // end of [if]
  end else (res) // end of [if]
//
and aux2
(
  p: ptr, n: size_t, res: int
) : int =
  if n > 0 then let
    val c = $UN.ptr0_get<char> (p)
  in
    if (c != '/')
      then aux1 (ptr_succ<char> (p), pred(n), res+1)
      else aux1 (ptr_succ<char> (p), pred(n), res+0)
    // end of [if]
  end else (res+1) // end of [if]
//
val cut_dirs = aux1 (string2ptr(source), n1 - n12, 0)
val dir_prefix = string_make_substring (target, i2sz(0), n2-n12)
//
in
  (cut_dirs, strnptr2string(dir_prefix))
end // end of [wget_params]

end // end of [local]

(* ****** ****** *)
//
extern
fun pkgreloc_jsonval
  (out: FILEref, jsv: jsonval): void
extern
fun pkgreloc_jsonvalist
  (out: FILEref, jsvs: jsonvalist): void
//
extern
fun pkgreloc_fileref
  (flag: int, out: FILEref, inp: FILEref): void
//
(* ****** ****** *)

implement
pkgreloc_jsonval
  (out, jsv) = let
//
fun auxmain
(
  source: string, target: string
) : void = () where
{
//
val isexi =
  test_file_exists (target)
//
val (
  cut_dirs, dir_prefix
) = wget_params (source, target)
//
val () =
if isexi
  then fprint (out, "#SKIP:: ;")
  else fprint (out, "wgetall:: ;")
//
val () =
  fprint! (out
  , " ", "$(WGET)"
  , " ", "$(WGETFLAGS)"
  , " ", "--cut-dirs=", cut_dirs
  , " ", "--directory-prefix=\"", dir_prefix, "\""
  , " ", "\"", source, "\""
  ) (* end of [fprint!] *) // end of [val]
//
val ((*void*)) = fprint_newline (out)
//
} (* end of [auxmain] *)
//
val opt1 =
  jsonval_object_get_key (jsv, "pkgreloc_source")
val opt2 =
  jsonval_object_get_key (jsv, "pkgreloc_target")
//
in
//
case+ opt1 of
| ~Some_vt (jsv_s) =>
  (
    case+ opt2 of
    | ~Some_vt (jsv_t) => let
        val-JSONstring (source) = jsv_s
        val-JSONstring (target) = jsv_t
      in
        auxmain (source, target)
      end // end of [Some_vt]
    | ~None_vt () => ((*void*))
  )
| ~None_vt ((*void*)) => option_vt_free (opt2)
//
end // end of [pkgreloc_jsonval]

(* ****** ****** *)

implement
pkgreloc_jsonvalist
  (out, jsvs) = let
//
implement(env)
list_foreach$fwork<jsonval><env> (x, env) = pkgreloc_jsonval (out, x)
//
in
  list_foreach<jsonval> (jsvs)
end // end of [pkgreloc_jsonvalist]

(* ****** ****** *)

implement
pkgreloc_fileref
  (flag, out, inp) = let
//
val () =
if flag = 0 then
{
//
val () =
fprint! (out,
"\
######\n\
#\n\
# A Makefile for relocating packages\n\
#\n\
######\n\
"
) (* end of [fprint!] *)
//
val () = fprint! (out, "#\n")
val () = fprint! (out, "WGET=wget\n")
val () = fprint! (out, "WGETFLAGS=-r -nH --timestamping --no-parent --execute robots=off\n")
val () = fprint! (out, "#\n")
val () = fprint! (out, "######\n")
val () = fprint! (out, "#\n")
val () = fprint! (out, "wgetall::\n")
val () = fprint! (out, "#\n")
//
} (* end of [if] *)
//
val jsvs = jsonats_parsexnlst_fileref (inp)
//
in
  pkgreloc_jsonvalist (out, jsvs)
end // end of [pkgreloc_fileref]

(* ****** ****** *)

datatype OUTCHAN =
  | OUTCHANref of (FILEref) | OUTCHANptr of (FILEref)
// end of [OUTCHAN]

(* ****** ****** *)

fun
outchan_close
  (x: OUTCHAN): void =
(
  case+ x of
  | OUTCHANref _ => ((*void*))
  | OUTCHANptr (out) => fileref_close (out)
) // end of [outchan_close]
  
(* ****** ****** *)

fun
outchan_get_fileref
  (x: OUTCHAN): FILEref =
(
  case+ x of
  | OUTCHANref (filr) => filr | OUTCHANptr (filp) => filp
) // end of [outchan_get_fileref]

(* ****** ****** *)

datatype
waitkind =
  | WTKnone of ()
  | WTKoutput of () // --output-w // --output-a
// end of [waitkind]

(* ****** ****** *)

typedef
cmdstate =
@{
  arg0= string
, ninput= int // local
, ninput2= int // global
, waitkind= waitkind // waiting ...
, outmode= int // write(0); append(1)
, outchan= OUTCHAN // current output channel
, nerror= int // number of accumulated errors
} (* end of [cmdstate] *)

(* ****** ****** *)
//
extern
fun arg_process
  (state: &cmdstate >> _, arg: string): void
extern
fun arg_process_inp
  (state: &cmdstate >> _, arg: string): void
extern
fun arg_process_out
  (state: &cmdstate >> _, arg: string): void
//
(* ****** ****** *)

extern
fun fprint_usage (out: FILEref, cmd: string): void

(* ****** ****** *)

implement
arg_process
  (state, arg) = let
in
//
case+ arg of
//
| "-h" => let
    val out = state.outchan
    val out = outchan_get_fileref (out)
    val ((*void*)) = state.ninput := 1
    val ((*void*)) = state.ninput2 := 1
  in
    fprint_usage (out, state.arg0)
  end
| "--help" => let
    val out = state.outchan
    val out = outchan_get_fileref (out)
    val ((*void*)) = state.ninput := 1
    val ((*void*)) = state.ninput2 := 1
  in
    fprint_usage (out, state.arg0)
  end
//
| "-o" =>
  {
    val () = state.ninput := 0
    val () = state.waitkind := WTKoutput()
  }
| "--output" =>
  {
    val () = state.ninput := 0
    val () = state.waitkind := WTKoutput()
  }
| "--output-w" =>
  {
    val () = state.ninput := 0
    val () = state.outmode := 0
    val () = state.waitkind := WTKoutput()
  }
| "--output-a" =>
  {
    val () = state.ninput := 1
    val () = state.outmode := 1
    val () = state.waitkind := WTKoutput()
  }
| _ (*rest*) => let
    val wtk = state.waitkind
  in
    case+ wtk of
    | WTKnone () => arg_process_inp (state, arg)
    | WTKoutput () => arg_process_out (state, arg)
  end (* end of [_] *)
//
end // end of [arg_process]

implement
arg_process_inp
  (state, arg) = let
//
val opt =
  fileref_open_opt (arg, file_mode_r)
//
in
  case+ opt of
  | ~Some_vt
      (inp) => let
      val n0 = state.ninput
      val out =
        outchan_get_fileref (state.outchan)
      // end of [val]
      val () = pkgreloc_fileref (n0, out, inp)
      val ((*closed*)) = fileref_close (inp)
      val () = state.ninput := n0 + 1
      val () = state.ninput2 := state.ninput2 + 1
    in
      // nothing
    end // end of [Some_vt]
  | ~None_vt ((*void*)) =>
    {
      val () = fprintln!
      (
        stderr_ref, "The file [", arg, "] cannot be opened for read."
      ) (* end of [val] *)
      val () = state.nerror := state.nerror + 1
    } (* end of [None_vt] *)
end // end of [arg_process_inp]

implement
arg_process_out
  (state, arg) = let
//
val () = state.waitkind := WTKnone ()
//
val () = outchan_close (state.outchan)
//
val fmode = (
if state.outmode = 0 then file_mode_w else file_mode_a
) : file_mode // end of [val]
//
val opt = fileref_open_opt (arg, fmode)
//
in
//
case+ opt of
| ~Some_vt (out) =>
  {
    val () = state.outchan := OUTCHANptr(out)
  }
| ~None_vt ((*void*)) =>
  {
    val () = fprintln!
    (
      stderr_ref, "The file [", arg, "] cannot be opened for write."
    ) (* end of [val] *)
    val () = state.outchan := OUTCHANref(stderr_ref)
  }
//
end // end of [arg_process_out]

(* ****** ****** *)

implement
fprint_usage
  (out, arg0) = let
in
//
fprintln! (out, "usage: ", arg0, " <command> ... <command>\n");
fprintln! (out, "where a <command> is of one of the following forms:\n");
fprintln! (out, "  -h (for printing out this help usage)");
fprintln! (out, "  --help (for printing out this help usage)");
fprintln! (out, "  filename (input from <filename>)");
fprintln! (out, "  -o filename (output into <filename>)");
fprintln! (out, "  --output filename (output into <filename>)");
fprintln! (out, "  --output-w filename (output-write into <filename>)");
fprintln! (out, "  --output-a filename (output-append into <filename>)");
fprint_newline (out);
//
end // end of [fprint_usage]

(* ****** ****** *)

implement
main{n}(argc, argv) = (0) where
{
//
fun loop
(
  state: &cmdstate >> _
, argv: !argv(n), i: natLte(n)
) : void =
(
if i < argc then let
  val () = arg_process (state, argv[i]) in loop (state, argv, i+1)
end else ((*void*)) // end of [if]
) (* end of [loop] *)
//
var state: cmdstate
//
val () =
  state.arg0 := argv[0]
//
val () = state.ninput := 0
val () = state.ninput2 := 0
//
val () = state.waitkind := WTKnone ()
//
val () = state.outmode := 0
val () = state.outchan := OUTCHANref (stdout_ref)
//
val () = state.nerror := 0
//
val ((*void*)) = loop (state, argv, 1)
//
val n0 = state.ninput
val out = outchan_get_fileref (state.outchan)
//
val ((*void*)) =
  if state.ninput2 = 0 then pkgreloc_fileref (n0, out, stdin_ref)
//
val ((*closed*)) = outchan_close (state.outchan)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atspkgreloc_wget.dats] *)

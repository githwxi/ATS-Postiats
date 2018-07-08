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
(* Start time: April, 2014 *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
staload
STRING =
"libats/libc/SATS/string.sats"
//
(* ****** ****** *)
//
staload
STAT =
"libats/libc/SATS/sys/stat.sats"
staload
_(*STAT*) =
"libats/libc/DATS/sys/stat.dats"
//
typedef stat = $STAT.stat
typedef mode_t = $STAT.mode_t
//
(* ****** ****** *)
//
staload
"./../libjson-c/SATS/json.sats"
staload _(*anon*) =
"./../libjson-c/DATS/json.dats"
//
(* ****** ****** *)
//
staload "./../libcurl/SATS/curl.sats"
//
(* ****** ****** *)
//
extern
fun{}
atsreloc_dmode (): mode_t
implement{}
atsreloc_dmode () = $UN.cast{mode_t}(0755)
extern
fun{}
atsreloc_fmode (): mode_t
implement{}
atsreloc_fmode () = $UN.cast{mode_t}(0644)

(* ****** ****** *)
//
extern
fun{}
atsreloc
(
  source: string, target: string
) : int // end o [atsreloc]
extern
fun{}
atsreloc2
(
  source: string, target: string
) : int // end o [atsreloc2]
//
(* ****** ****** *)
//
extern
fun
atsreloc_curl
(
  source: string, target: string
) : int // end o [atsreloc_curl]
//
extern
fun
atsreloc_curl2
(
  !CURLptr1
, source: string, target: string
) : int // end o [atsreloc_curl2]
//
(* ****** ****** *)
//
extern
fun
atsreloc_fileref(inp: FILEref): void
//
(* ****** ****** *)

implement{
} atsreloc
  (source, target) = let
//
var st: stat?
val ret = $STAT.stat(target, st)
prval ((*void*)) = opt_clear{stat}(st)
in
  if ret < 0 then atsreloc2 (source, target) else (0)
end // end of [atsreloc]

(* ****** ****** *)

implement
{}(*tmp*)
atsreloc2
  (source, target) = let
//
val target = g1ofg0(target)
val dirsep = dirsep_get<> ()
//
val rindex =
  string_rindex (target, dirsep)
//
var err0: int = 0
//
val () =
if
(rindex >= 0)
then
{
  val rindex = g1i2u(rindex)
  val tprefx =
    string_make_substring(target, i2sz(0), rindex)
  val mode = atsreloc_dmode<>((*void*))
  val err1 =
    $STAT.mkdirp<>($UN.strnptr2string(tprefx), mode)
  val ((*set*)) = err0 := err1
  val ((*freed*)) = strnptr_free (tprefx)
} (* end of [if] *) // end of [val]
//
in
  if err0 >= 0 then atsreloc_curl(source, target) else err0
end // end of [atsreloc2]

(* ****** ****** *)

(*
implement
atsreloc_curl
  (source, target) = err where
{
//
val arglst =
$list_vt{string}
  ("curl", " ", "-o", " ", target, " ", source, " ", "2>/dev/null")
val command =
  stringlst_concat ($UN.castvwtp1{List(string)}(arglst))
val ((*freed*)) = free (arglst)
val _(*err*) = $STDLIB.system ($UN.strptr2string(command))
val ((*freed*)) = free (command)
//
} (* end of [atsreloc_curl] *)
*)

(* ****** ****** *)

implement
atsreloc_curl
  (source, target) = let
//
val curl = curl_easy_init ((*void*))
//
in
//
if
ptrcast(curl) > 0
then let
  val nerr =
    atsreloc_curl2 (curl, source, target)
  val ((*void*)) = curl_easy_cleanup (curl)
in
  nerr
end // end of [then]
else let
  prval () = curl_easy_cleanup_null (curl) in ~1
end // end of [else]
//
end (* end of [atsreloc_curl] *)

(* ****** ****** *)

implement
atsreloc_curl2
(
  curl, source, target
) = nerr where
{
//
var nerr: int = 0
val p_curl = ptrcast(curl)
//
val err =
$extfcall
(
  CURLerror
, "curl_easy_setopt"
, p_curl, CURLOPT_URL, source
) (* end of [val] *)
val ((*void*)) =
  if (err != CURLE_OK) then nerr := nerr + 1
//
var knd: int = 0
val opt =
  fileref_open_opt (target, file_mode_w)
//
val target =
(
case+ opt of
| ~Some_vt(out) => out
| ~None_vt((*void*)) => (knd := 1; stdout_ref)
) : FILEref // end of [val]
//
val err =
$extfcall
(
  CURLerror
, "curl_easy_setopt"
, p_curl, CURLOPT_FILE, target
) (* end of [val] *)
val ((*void*)) =
  if (err != CURLE_OK) then nerr := nerr + 1
//
val err =
  curl_easy_perform(curl)
val err = CURLerror2code(err)
val ((*void*)) =
if
(err != CURLE_OK)
then
fprintln!
( stderr_ref
, "ERROR: curl_easy_perform(): failed: ", curl_easy_strerror(err)
) (* fprintln! *)
//
val ((*void*)) =
if (err != CURLE_OK) then nerr := nerr + 1
//
val ((*void*)) = if knd = 0 then fileref_close (target)
//
} (* end of [atsreloc_curl2] *)

(* ****** ****** *)

local
//
vtypedef
jobj = json_object0
//
fun
auxlst
(
  xs: List_vt(jobj), n: int
) : int = let
(*
val () = println! ("auxlst")
*)
in
//
case+ xs of
| ~list_vt_nil() => (n)
| ~list_vt_cons(x, xs) => let
//
    val () = assertloc(isneqz(x))
//
    val (fpf_s | jso_s) =
      json_object_object_get(x, "atsreloc_source")
    val (fpf_t | jso_t) =
      json_object_object_get(x, "atsreloc_target")
//
    val () =
    if
    (isneqz(jso_s)*isneqz(jso_t))
    then
    {
//
      val (fpf0 | source) =
        json_object_get_string(jso_s)
      val (fpf1 | target) =
        json_object_get_string(jso_t)
//
      val source_ = $UN.strptr2string(source)
      val target_ = $UN.strptr2string(target)
//
      val nerr = atsreloc (source_, target_)
      val ((*void*)) =
      if nerr > 0 then prerrln! ("ERROR: atsreloc_source= ", source_)
      val ((*void*)) =
      if nerr > 0 then prerrln! ("ERROR: atsreloc_target= ", target_)
//
      prval ((*void*)) = fpf0 (source) and ((*void*)) = fpf1 (target)
//
    }
//
    prval () = minus_addback (fpf_s, jso_s | x)
    prval () = minus_addback (fpf_t, jso_t | x)
//
    val _(*freed*) = json_object_put (x)
  in
    auxlst (xs, n+1)
  end // end of [list_vt_cons]
//
end // end of [auxlst]

in (* in-of-local *)

implement
atsreloc_fileref
  (inp) = () where
{
//
val cs =
  fileref_get_file_string(inp)
val itms =
  json_tokener_parse_list($UN.strptr2string(cs))
val ((*void*)) = strptr_free(cs)
//
val _(*nitm*) = auxlst(itms, 0)
//
(*
val () = println! ("atsreloc_fileref: nitm = ", nitm)
*)
//
} (* end of [atsreloc_fileref] *)

end // end of [local]

(* ****** ****** *)

implement
main{n}
(
  argc, argv
) = (0) where
{
//
var nfil: int = 0
//
fun loop
(
  argv: !argv(n)
, i: natLte(n), nfil: &int >> _
) : void =
(
if i < argc
  then let
    val inp = argv[i]
    val opt =
      fileref_open_opt(inp, file_mode_r)
    // end of [val]
  in
    case+ opt of
    | ~Some_vt (inp) => let
        val () = nfil := nfil + 1
        val () = atsreloc_fileref(inp)
        val () = fileref_close(inp)
      in
        loop (argv, i+1, nfil)
      end // end of [Some_vt]
    | ~None_vt ((*void*)) => loop(argv, i+1, nfil)
   end // end of [then]
   else ((*void*)) // end of [else]
// end of [if]
)
//
val err =
  curl_global_init(CURL_GLOBAL_DEFAULT)
val ((*void*)) = assertloc(err = CURLE_OK)
//
val ((*void*)) = loop(argv, 1, nfil)
val ((*void*)) = if nfil = 0 then atsreloc_fileref(stdin_ref)
//
val ((*void*)) = curl_global_cleanup((*void*))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atsreloc_curl.dats] *)

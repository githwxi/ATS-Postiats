(*
** Implementing the doublet game
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/strarr.sats"
staload _ = "libats/ML/DATS/array0.dats"
staload _ = "libats/ML/DATS/strarr.dats"

(* ****** ****** *)
//
staload
"libats/SATS/hashtbl_linprb.sats"
//
(* ****** ****** *)
//
staload _ = "libats/DATS/hashfun.dats"
staload _ = "libats/DATS/hashtbl_linprb.dats"
//
(* ****** ****** *)

staload "./doublet.sats"

(* ****** ****** *)

local
//
typedef key = strarr
typedef itm = int(*0/1*)
//
#define CAPACITY 131072
//
(*
//
// resizing is not allowed!
//
implement
hashtbl$recapacitize<> () = 0
*)
//
implement
hash_key<strarr>
  (str) = let
//
val K = 31UL
val n = length (str)
//
fun loop
(
  i: size_t, res: ulint
) : ulint = let
in
//
if i < n then let
  val res = K * res + $UN.cast{ulint}(str[i])
in
  loop (succ(i), res)
end else (res) // end of [if]
//
end // end of [loop]
//
in
  $effmask_all (loop (i2sz(0), 31415926536UL))
end // end of [hash_key]
//
implement
gequal_val<strarr> (str1, str2) = (str1 = str2)
//
implement(itm)
hashtbl_linprb_keyitm_is_null<strarr,itm> (kx) = ($UN.cast2ptr(kx.0) = 0)
//
in (* in of [local] *)

#include "{$LIBATSHWXI}/globals/HATS/ghashtbl_linprb.hats"

end // end of [local]

(* ****** ****** *)

#define WORDS "/usr/share/dict/words"

(* ****** ****** *)

val () = // initialization
{
//
val-~Some_vt(filr) =
  fileref_open_opt (WORDS, file_mode_r)
//
val () = let
//
fun loop
(
  filr: FILEref
) : void = let
  val isnot = fileref_isnot_eof (filr)
in
  if isnot
    then let
      val str =
        fileref_get_line_string (filr)
      val str2 = strarr_make_string ($UN.castvwtp1{string}(str))
      val ((*void*)) = strptr_free (str)
      val-~None_vt() = insert_opt (str2, 1)
    in
      loop (filr)
    end // end of [then]
    else () // end of [else]
  // end of [if]
end // end of [loop]
//
in
  loop (filr)
end // end of [val]
//
val ((*void*)) = fileref_close (filr)
//
} (* end of [val] *)

(* ****** ****** *)

implement
word_is_legal (w) = let
  val cp = search_ref (w)
in
  if cptr2ptr (cp) > 0 then true else false
end // end of [word_is_legal]

(* ****** ****** *)

(* end of [doublet_dict.dats] *)

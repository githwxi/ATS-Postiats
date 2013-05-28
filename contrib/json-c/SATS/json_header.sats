(*
** Start Time: May, 2013
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
*)

(* ****** ****** *)

#ifndef JSON_JSON_HEADER_HATS
#define JSON_JSON_HEADER_HATS

(* ****** ****** *)

absvtype array_list_vtype (l:addr) = ptr
vtypedef array_list (l) = array_list_vtype (l)
vtypedef
array_list0 = [l:addr | l >= null] array_list (l)
vtypedef
array_list1 = [l:addr | l >  null] array_list (l)

(* ****** ****** *)

#endif // end of [JSON_JSON_HEADER_HATS]

(* ****** ****** *)

(* end of [json_header.sats] *)

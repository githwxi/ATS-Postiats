(*
** Implementing Untyped Functional PL
*)

(* ****** ****** *)

abstype
location_type = ptr
typedef
location = location_type

(* ****** ****** *)

abstype d2var_type = ptr
typedef d2var = d2var_type
typedef d2varlst = List0 (d2var)

(* ****** ****** *)

datatype
d2exp_node =
  | D2Eint of (int)
  | D2Echar of (char)
  | D2Efloat of (float)
  | D2Estring of (string)
  | D2Eident of (string)
  | D2Elam of (d2varlst, d2exp)
  | D2Efix of (d2var, d2varlst, d2exp)
  | D2Eapp of (d2exp, d2explst)
  | D2Elet of (d2var, d2exp, d2exp)
// end of [d2exp_node]

where
d2exp = '{
  d2exp_loc= location, d2exp_node= d2exp_node
} (* end of [d2exp] *)

and d2explst = List0 (d2exp)

(* ****** ****** *)

(* end of [utfpl.sats] *)

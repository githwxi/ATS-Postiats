(*
** ML-style API in ATS for json-c
*)

(* ****** ****** *)

datatype
jsonVal =
  | JSONint of (llint)
  | JSONstring of (string)
  | JSONdouble of (double)
  | {n:nat}
    JSONarray of (arrayref (jsonVal, n), size_t (n))
  | {n:nat}
    JSONobject of (arrayref (labjsonVal, n), size_t (n))
// end of [jsonVal]

where labjsonVal = @(string, jsonVal)

(* ****** ****** *)

(* end of [json_ML.sats] *)

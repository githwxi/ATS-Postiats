(* ****** ****** *)
//
// processing command-line arguments
//
(* ****** ****** *)

datatype optarg =
  | TAint of int
  | TAstr of string
  | TAlist of argvalist
  | TAnone of ((*void*))
// end of [argval]

where
argvalist = List0 (optarg)

(* ****** ****** *)

datatype commarg =
  | CAarg of string
  | CAopt of (string(*name*), optarg)
// end of [commarg]

where
commarglst = List0 (commarg)

(* ****** ****** *)

(* end of [commarg.sats] *)

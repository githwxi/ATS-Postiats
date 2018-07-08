//usr/bin/env myatscc "$0"; exit
(* ****** ****** *)
//
// HX: Hello, world!
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)

implement
main0 () = {
  val () = println! ("你好世界!") // Chinese
  val () = println! ("Hello world!") // English
  val () = println! ("Hello wereld") // Dutch
  val () = println! ("Bonjour monde!") // French
  val () = println! ("Hallo Welt!") // German
  val () = println! ("γειά σου κόσμος!") // Greek
  val () = println! ("Ciao mondo!") // Italian
  val () = println! ("こんにちは世界!") // Japanese
  val () = println! ("여보세요 세계!") // Korean
  val () = println! ("Olá mundo!") // Portuguese
  val () = println! ("Здравствулте мир!") // Russian
  val () = println! ("Hola mundo!") // Spanish
} (* end of [main0] *)

(* ****** ****** *)

(* end of [hello.dats] *)

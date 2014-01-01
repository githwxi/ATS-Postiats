(*
** declatext:
** For documenting declarations
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "declatext.sats"

(* ****** ****** *)

viewtypedef
stringlst_vt = List_vt (string)
viewtypedef
declitemlst_vt = List_vt (declitem)

(* ****** ****** *)

local
val theDecltitle = ref<string> ("")
in // in of [local]
implement theDecltitle_get () = !theDecltitle
implement theDecltitle_set (x) = !theDecltitle := x
end // end of [local]
implement
decltitle (x) = let
  val () = theDecltitle_set (x) in $LDOC.atext_nil ()
end // end of [decltitle]

(* ****** ****** *)

local
val theDeclpreamble = ref<string> ("")
in // in of [local]
implement theDeclpreamble_get () = !theDeclpreamble
implement theDeclpreamble_set (x) = !theDeclpreamble := x
end // end of [local]
implement
declpreamble (x) = let
  val () = theDeclpreamble_set (x) in $LDOC.atext_nil ()
end // end of [declpreamble]

(* ****** ****** *)

local
val theDeclpostamble = ref<string> ("")
in // in of [local]
implement theDeclpostamble_get () = !theDeclpostamble
implement theDeclpostamble_set (x) = !theDeclpostamble := x
end // end of [local]
implement
declpostamble (x) = let
  val () = theDeclpostamble_set (x) in $LDOC.atext_nil ()
end // end of [declpostamble]

(* ****** ****** *)

local
val theDeclname = ref<string> ("")
in // in of [local]
implement theDeclname_get () = !theDeclname
implement theDeclname_set (x) = !theDeclname := x
end // end of [local]

(* ****** ****** *)

local

val theDeclnameLst = ref<stringlst_vt> (list_vt_nil)

in // in of [local]

implement
theDeclnameLst_add (x) = let
  val (vbox pf | p) = ref_get_view_ptr (theDeclnameLst)
in
  !p := list_vt_cons (x, !p)
end // end of [theDeclnameLst_add]

implement theDeclnameLst_get () = let
  val (vbox pf | p) = ref_get_view_ptr (theDeclnameLst)
  val xs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (xs)
end // end of [theDeclnameLst_get]

end // end of [local]

(* ****** ****** *)

local

val theDeclitemLst = ref<declitemlst_vt> (list_vt_nil)

in // in of [local]

implement
theDeclitemLst_add (x) = let
  val (vbox pf | p) = ref_get_view_ptr (theDeclitemLst)
in
  !p := list_vt_cons (x, !p)
end // end of [theDeclitemLst_add]

implement theDeclitemLst_get () = let
  val (vbox pf | p) = ref_get_view_ptr (theDeclitemLst)
  val xs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (xs)
end // end of [theDeclitemLst_get]

end // end of [local]

(* ****** ****** *)

implement
declname (x) = let
  val () = theDeclnameLst_add (x)
  val () = theDeclitemLst_add (DITMname (x))
in
  $LDOC.atext_nil ()
end // end of [declname]

implement
declname2 (name, href) = let
  val () = theDeclnameLst_add (name)
  val () = theDeclitemLst_add (DITMname2 (name, href))
in
  $LDOC.atext_nil ()
end // end of [declname]

implement
declsynop () = let
  val () = theDeclitemLst_add (DITMsynop ())
in
  $LDOC.atext_nil ()
end // end of [declsynop]
implement declsynopsis () = declsynop ()

implement
declsynop2 (x) = let
  val () = theDeclitemLst_add (DITMsynop2 (x))
in
  $LDOC.atext_nil ()
end // end of [declsynop2]
implement declsynopsis2 (x) = declsynop2 (x)

implement
declnamesynop (x) = let
  val _ignored = declname (x)
  val _ignored = declsynopsis ()
in
  $LDOC.atext_nil ()
end // end of [declname]

implement
decldescrpt (x) = let
  val () = theDeclitemLst_add (DITMdescrpt (x))
in
  $LDOC.atext_nil ()
end // end of [decldescrpt]

implement
declexample (x) = let
  val () = theDeclitemLst_add (DITMexample (x))
in
  $LDOC.atext_nil ()
end // end of [declexample]

implement
declparamlist () = let
  val () = theDeclitemLst_add (DITMparamlist ())
in
  $LDOC.atext_nil ()
end // end of [declparamlist]

implement
declparamadd (x1, x2) = let
  val () = theDeclitemLst_add (DITMparamadd (x1, x2))
in
  $LDOC.atext_nil ()
end // end of [declparamadd]

implement
declfunretval (x) = let
  val () = theDeclitemLst_add (DITMfunretval (x))
in
  $LDOC.atext_nil ()
end // end of [declfunretval]

(* ****** ****** *)

local
val theDeclrepLst = ref<d0eclreplst> (list_nil)
in // in of [local]
implement theDeclrepLst_get () = !theDeclrepLst
implement theDeclrepLst_set (xs) = !theDeclrepLst := xs
end // end of [local]

(* ****** ****** *)

(* end of [declatext.dats] *)

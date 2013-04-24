(* ****** ****** *)
//
// HX-2013-04:
// some code for use in Matt's HCSS talk in May
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload "libats/SATS/sllist.sats"
staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"

(* ****** ****** *)

extern
fun{
a:t0p}{b:t0p
} sllist_mapfree$fwork (x: a): b
extern
fun{
a:t0p}{b:t0p
} sllist_mapfree {n:nat} (xs: sllist (INV(a), n)): sllist (b, n)

(* ****** ****** *)

implement{a}{b}
sllist_mapfree (xs) =
(
if sllist_is_cons (xs) then let
  var xs = xs
  val x0 = sllist_uncons (xs)
  val y0 = sllist_mapfree$fwork<a><b> (x0)
in
  sllist_cons (y0, sllist_mapfree<a><b> (xs))
end else let
  prval () = sllist_free_nil (xs)
in
  sllist_nil ()
end (* end of [if] *)
)

(* ****** ****** *)

#define nil sllist_nil
#define cons sllist_cons
#define :: sllist_cons

(* ****** ****** *)

fun test() = let
//
val out = stdout_ref
val l1 = cons (1, cons (2, sllist_nil{int}()))
val () = fprintln! (out, "l1 = ", l1)
//
local
implement
sllist_mapfree$fwork<int><int> (a) = a + 1
in
val l2 = sllist_mapfree<int><int> (l1)
end
//
val () = fprintln! (out, "l2 = ", l2)
val () = sllist_free<int> (l2)
//
in
  // nothing
end // end of [test]

(* ****** ****** *)

implement main0 (argc, argv) = test()

(* ****** ****** *)

(*
From md@bu.edu Mon Apr 22 14:44:28 2013
Date: Mon, 22 Apr 2013 14:42:52 -0400
From: Matthew Danish <md@bu.edu>
To: Hongwei Xi <hwxi@bu.edu>
Subject: Re: postiats error

Perhaps we should get together and go over that then.


On Mon, Apr 22, 2013 at 2:28 PM, Hongwei Xi <hwxi@bu.edu> wrote:
      Pattern matching is yet to be implemented.

      You could just explain to the audience how the code is
      supposed to be compiled.

      On Mon, 22 Apr 2013, Matthew Danish wrote:

      >>I was thinking something like this but it won't compile to
      executable:
      >>
      >>staload _ = "prelude/DATS/list_vt.dats"
      >>staload _ = "prelude/DATS/integer.dats"
      >>
      >>extern fun{a:t@ype} {b:t@ype} map_work(_: a): b
      >>extern fun{a:t@ype} {b:t@ype} map {n: nat} (_: list_vt (a, n)):
      list_vt (b, n)
      >>
      >>implement{a}{b} map(ls) = case+ ls of
      >>  | ~list_vt_nil () => list_vt_nil ()
      >>  | ~list_vt_cons (x, xs) => list_vt_cons (map_work x, map<a><b>
      (xs))
      >>
      >>#define :: list_vt_cons
      >>#define nil list_vt_nil
      >>
      >>fun test() = let
      >>  val l1 = 1 :: 2 :: nil
      >>  implement map_work<int><int> (a) = a + 1
      >>  val l2 = map<int><int> (l1)
      >>in
      >>  list_vt_free<int> (l2)
      >>end
      >>
      >>implement main(argc, argv) = begin test(); 0 end
      >>
      >>
      >>
      >>On Mon, Apr 22, 2013 at 1:37 PM, Matthew Danish <md@bu.edu> wrote:
      >>      I looked at the binary search example in Postiats but I
      think it is too complicated for a talk.
      >>
      >>      I am thinking of just showing how ATS2 templates can be used
      for high level code but compile to efficient C.
      >>
      >>
      >>
      >>On Wed, Apr 17, 2013 at 3:50 PM, Hongwei Xi <hwxi@bu.edu> wrote:
      >>      On Wed, 17 Apr 2013, Matthew Danish wrote:
      >>
      >>      >> Ok now.
      >>      >>
      >>      >> So, on another note, any ideas on what would be a good
      concise example of ATS2
      >>      >> for the talk?
      >>
      >>Binary search is a good example; it involves the concepts of
      views,
      >>dependent types, termination-checking, templates, etc.
      >>
      >>>>
      >>>>
      >>>> On 4/16/2013 17:31, Hongwei Xi wrote:
      >>>>> On Tue, 16 Apr 2013, Matthew Danish wrote:
      >>>>>
      >>>>> > > I checked out the latest ATS and rebuilt it and rebuilt
      PATS but it
      >>>>> > > still gives me the same error.
      >>>>> > >
      >>>>> The reason that I didn't see this is due to my not doing a
      thorough
      >>>>> cleanup of my own previous build. So the file that caused the
      problem was
      >>>>> never used during my re-build.
      >>>>>
      >>>>
      >>
      >>
      >>
      >>
      >>
*)

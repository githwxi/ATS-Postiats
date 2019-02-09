(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Xanadu - Unleashing the Potential of Types!
** Copyright (C) 2018 Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi
// Start Time: January, 2019
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)

(*

opverbs:

map;

filter;
forall;
foreach;

foldl; reducel
foldr; reducer

imap; xmap2; zmap2;

lazy opverbs:

lmap;
lscan;
lfilter;

listize
streamize

list_xmap_list_vt_vt1_vt1(...)
list_xmap_stream_vt_vt1_vt1(...)

fun
list_xmap_list_vt_vt1_vt1
( !list_vt(x1, n1)
, !list_vt(x2, n2)): list_vt(y3, n1*n2)

#symload
list_xmap with
list_xmap_list_vt_vt0_vt0
#symload
list_xmap with
list_xmap_stream_vt_vt0_vt0

(
list_xmap<x1,x2><y3>
  (xs1, xs2)
) where
{
implement
list_xmap$fopr<x1,x2><y3>(x1, x2) = ...
}

*)

(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload
"libats/ML/SATS/basis.sats"
#staload
"libats/ML/SATS/list0.sats"
#staload
"libats/ML/SATS/list0_vt.sats"
//
(* ****** ****** *)
//
sortdef
tbox = type and tflt = t0ype
sortdef
vtbox = vtype and vtflt = vt0ype
//
(* ****** ****** *)
//
extern
fun
{xs
:tflt}
{x0
:tflt}
streamize(xs): stream(x0)
extern
fun
{xs
:vtflt}
{x0
:vtflt}
streamize_vt(xs): stream_vt(x0)
//
(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} forall(xs): bool
extern
fun
{x0:tflt} forall$test(x0): bool
//
implement
{xs}
{x0}
forall(xs) =
(
auxlst
(streamize_vt(xs))
) where
{
fun
auxlst
( xs
: stream_vt(x0)): bool =
(
case+ !xs of
| ~stream_vt_nil
   ((*void*)) => true
| ~stream_vt_cons
   ( x0, xs ) =>
  (
   if
   test
   then
   auxlst(xs)
   else
   let val () = ~xs in false end
  ) where
  {
    val test = forall$test<x0>(x0)
  }
)
} (* end of [forall] *)

(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} rforall(xs): bool
extern
fun
{x0:tflt} rforall$test(x0): bool
//
implement
{xs}
{x0}
rforall(xs) =
(
auxlst
(streamize_vt(xs))
) where
{
fun
auxlst
( xs
: stream_vt(x0)): bool =
(
case+ !xs of
| ~stream_vt_nil
   ((*void*)) => true
| ~stream_vt_cons
   ( x0, xs ) =>
  (
   if
   auxlst(xs)
   then
   rforall$test<x0>(x0) else false
  )
)
} (* end of [rforall] *)
//
implement
{x0}
rforall$test = forall$test<x0>
//
(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} iforall(xs): bool
extern
fun
{x0:tflt} iforall$test(int, x0): bool
//
implement
{xs}
{x0}
iforall(xs) =
(
  forall<xs><x0>(xs)
) where
{
//
var env
  : int = 0
val env =
$UN.cast
{ref(int)}(addr@(env))
//
implement
forall$test<x0>(x0) =
let
  val i0 = !env
in
  !env := i0+1
; iforall$test<x0>(i0, x0)
end // end of [forall$test]
//
} (* end of [iforall] *)
//
(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} foreach(xs): void
extern
fun
{x0:tflt} foreach$work(x0): void
//
(* ****** ****** *)

implement
{xs}
{x0}
foreach(xs) =
(
ignoret(forall<xs><x0>(xs))
) where
{
implement
forall$test<x0>(x0) =
let val () = foreach$work(x0) in true end
} (* end of [foreach] *)

(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} rforeach(xs): void
extern
fun
{x0:tflt} rforeach$work(x0): void
//
(* ****** ****** *)

implement
{xs}
{x0}
rforeach(xs) =
(
ignoret(rforall<xs><x0>(xs))
) where
{
implement
rforall$test<x0>(x0) =
let val () = rforeach$work(x0) in true end
} (* end of [rforeach] *)

(* ****** ****** *)
//
implement
{x0}
rforeach$work = foreach$work<x0>
//
(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} iforeach(xs): void
extern
fun
{x0:tflt} iforeach$work(int, x0): void
//
(* ****** ****** *)

implement
{xs}
{x0}
iforeach(xs) =
(
ignoret(iforall<xs><x0>(xs))
) where
{
implement
iforall$test<x0>(i, x0) =
let val () = iforeach$work(i, x0) in true end
} (* end of [iforeach] *)

(* ****** ****** *)

extern
fun
{xs:tflt}
{x0:tflt}
{y0:tflt}
map_list0(xs): list0(y0)
extern
fun
{x0:tflt}
{y0:tflt}
map_list0$fopr(x0): (y0)

(* ****** ****** *)

implement
{xs}
{x0}
{y0}
map_list0(xs) =
(
list0_vt2t
(list0_vt_reverse<y0>
 ($UN.castvwtp0{list0_vt(y0)}(!res))
)
) where
{
//
var
res:
list0(y0) = list0_nil()
val
res =
$UN.cast
{ref(list0(y0))}(addr@res)
//
val () =
(
  foreach<xs><x0>(xs)
) where
{
  implement
  foreach$work<x0>(x0) =
  {
    val y0 = map_list0$fopr<x0><y0>(x0)
    val () = (!res := list0_cons(y0, !res))
  }
}
//
} (* end of [map_list0] *)

(* ****** ****** *)

extern
fun
{xs:tflt}
{x0:tflt}
{y0:tflt}
imap_list0(xs): list0(y0)
extern
fun
{x0:tflt}
{y0:tflt}
imap_list0$fopr(int, x0): (y0)

implement
{xs}
{x0}
{y0}
imap_list0(xs) =
let
//
var env
  : int = 0
val env =
$UN.cast
{ref(int)}(addr@(env))
//
in
(
map_list0<xs><x0><y0>(xs)
) where
{
  implement
  map_list0$fopr<x0><y0>(x0) =
  let
    val i0 = !env
  in
    !env := i0 + 1;
    imap_list0$fopr<x0><y0>(i0, x0)
  end // end of [map_list0$fopr]
}
end // end of [imap_list0]

(* ****** ****** *)

extern
fun
{xs:tflt}
{x0:tflt}
{y0:tflt}
mapopt_list0(xs): list0(y0)
extern
fun
{x0:tflt}
{y0:tflt}
mapopt_list0$fopr(x0): option0_vt(y0)

(* ****** ****** *)

implement
{xs}
{x0}
{y0}
mapopt_list0(xs) =
(
list0_vt2t
(list0_vt_reverse<y0>
 ($UN.castvwtp0{list0_vt(y0)}(!res))
)
) where
{
//
var
res:
list0(y0) = list0_nil()
val
res =
$UN.cast
{ref(list0(y0))}(addr@res)
//
val () =
(
  foreach<xs><x0>(xs)
) where
{
  implement
  foreach$work<x0>(x0) =
  let
    val opt =
      mapopt_list0$fopr<x0>(x0)
    // end of [val]
  in
    case+ opt of
    | ~None0_vt() =>
        ((*void*))
    | ~Some0_vt(y0) =>
        (!res := list0_cons(y0, !res))
    // end of [case]
  end
  }
} (* end of [mapopt_list0] *)

(* ****** ****** *)
//
extern
fun
{xs:tflt}
{x0:tflt} print(xs): void
extern
fun
{xs:tflt}
{x0:tflt} prerr(xs): void
extern
fun
{xs:tflt}
{x0:tflt} fprint(FILEref, xs): void
extern
fun
{(*void*)} fprint$sep(FILEref): void
//
implement
{xs}
{x0}
print(xs) =
fprint<xs><x0>(stdout_ref, xs)
implement
{xs}
{x0}
prerr(xs) =
fprint<xs><x0>(stderr_ref, xs)
//
implement
{xs}
{x0}
fprint(out, xs) =
(
iforeach<xs><x0>(xs)
) where
{
implement
iforeach$work<x0>
  (i, x0) =
(
fprint_val<x0>(out, x0)
) where
{
val () =
if i > 0 then fprint$sep<>(out)
}
} (* end of [fprint] *)
//
implement
{(*void*)}
fprint$sep(out) = fprint_string(out, ",")
//
(* ****** ****** *)

(* end of [opverb.dats] *)

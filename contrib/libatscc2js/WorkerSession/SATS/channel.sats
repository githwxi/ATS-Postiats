(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

(*
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: October, 2015
*)

(* ****** ****** *)
//
// HX-2015-10-25:
//
(* ****** ****** *)
//
#define
ATS_STALOADFLAG 0 // no staloading at run-time
//
#define
ATS_EXTERN_PREFIX
"ats2js_workersession_" // prefix for extern names
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)
//
typedef
cfun0(res: vt0p) = () -<cloref1> res
typedef
cfun1(a: vt0p, res: vt0p) = (a) -<cloref1> res
typedef
cfun2(a1: vt0p, a2: vt0p, res: vt0p) = (a1, a2) -<cloref1> res
//
(* ****** ****** *)
//
abstype
chmsg_type(a:t@ype+)
//
typedef
chmsg(a:t0p) = chmsg_type(a)
//
(* ****** ****** *)
//
abstype chanpos((*void*))
abstype channeg((*void*))
//
(* ****** ****** *)
//
typedef
chpcont0() = cfun1(chanpos(), void)
typedef
chpcont1(a:t0p) = cfun2(chanpos(), a, void)
//
(* ****** ****** *)
//
typedef
chncont0() = cfun1(channeg(), void)
typedef
chncont1(a:t0p) = cfun2(channeg(), a, void)
//
(* ****** ****** *)
//
fun{a:t0p}
chmsg_parse(chmsg(INV(a))): (a)
//
(* ****** ****** *)

fun
chanpos0_close(chanpos()): void = "mac#%"

(* ****** ****** *)
//
fun
chanpos0_send
  {a:t0p}
(
  chanpos(), x0: a, k0: chpcont0()
) : void = "mac#%" // end-of-fun
//
fun
chanpos0_recv
  {a:t0p}
(
  chanpos(), k0: chpcont1(chmsg(a))
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
channeg0_new_file
  (filename: string): channeg() = "mac#%"
//
fun
channeg0_close(channeg((*nil*))): void = "mac#%"
//
(* ****** ****** *)
//
fun
channeg0_recv
  {a:t0p}
(
  channeg(), x0: a, k0: chncont0()
) : void = "mac#%" // end-of-fun
//
fun
channeg0_send
  {a:t0p}
(
  channeg(), k0: chncont1(chmsg(a))
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
{a:t0p}
{b:t0p}
rpc_server
  (chanpos(), fopr: (a) -<cloref1> b): void = "mac#%"
//
fun
{a:t0p}
{b:t0p}
rpc_server_cont
  (chanpos(), fopr: (a) -<cloref1> b): void = "mac#%"
//
(* ****** ****** *)
//
fun
{a:t0p}
{b:t0p}
rpc_client
  (channeg(), a, (b) -<cloref1> void): void = "mac#%"
//
(* ****** ****** *)
//
abstype chsnd(a:vt@ype)
abstype chrcv(a:vt@ype)
//
abstype chnil
abstype chcons(a:type, ss:type)
//
stadef :: = chcons
//
(* ****** ****** *)

stadef chsing(x:type) = chcons(x, chnil)

(* ****** ****** *)
//
(*
abstype ssnot(ss:type)
*)
//
(* ****** ****** *)
//
abstype ssconj(ss:type)
abstype ssdisj(ss:type)
//
abstype ssdisj_nil and ssconj_nil
//
(* ****** ****** *)
//
abstype
ssappend(ss1:type, ss2:type)
//
(* ****** ****** *)
//
abstype ssoption(ss:type)
//
typedef
ssoption_conj
  (ss:type) = ssconj(ssoption(ss))
typedef
ssoption_disj
  (ss:type) = ssdisj(ssoption(ss))
//
(* ****** ****** *)
//
abstype ssrepeat(ss:type)
//
typedef
ssrepeat_conj
  (ss:type) = ssconj(ssrepeat(ss))
typedef
ssrepeat_disj
  (ss:type) = ssdisj(ssrepeat(ss))
//
(* ****** ****** *)
//
abstype
sschoose_conj(ss1:type, ss2:type)
abstype
sschoose_disj(ss1:type, ss2:type)
//
(* ****** ****** *)

absvtype chanpos(ss:type)
absvtype channeg(ss:type)

(* ****** ****** *)
//
typedef
chpcont0(ss:type) = cfun1(chanpos(ss), void)
typedef
chpcont1(ss:type, a:t0p) = cfun2(chanpos(ss), a, void)
//
typedef
chncont0(ss:type) = cfun1(channeg(ss), void)
typedef
chncont1(ss:type, a:t0p) = cfun2(channeg(ss), a, void)
//
(* ****** ****** *)

typedef chpcont0_nil = chpcont0(chnil)
typedef chncont0_nil = chncont0(chnil)

(* ****** ****** *)
//
fun
chanpos1_send
  {a:t0p}{ss:type}
(
  chanpos(chsnd(a)::ss), x0: a, k0: chpcont0(ss)
) : void = "mac#%" // end-of-fun
//
fun
chanpos1_recv
  {a:t0p}{ss:type}
(
  chanpos(chrcv(a)::ss), k0: chpcont1(ss, chmsg(a))
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
fun
channeg1_recv
  {a:t0p}{ss:type}
(
  channeg(chrcv(a)::ss), x0: a, k0: chncont0(ss)
) : void = "mac#%" // end-of-fun
//
fun
channeg1_send
  {a:t0p}{ss:type}
(
  channeg(chsnd(a)::ss), k0: chncont1(ss, chmsg(a))
) : void = "mac#%" // end-of-fun
//
(* ****** ****** *)
//
vtypedef
chanpos_nil = chanpos(chnil)
vtypedef
channeg_nil = channeg(chnil)
//
(* ****** ****** *)
//
fun chanpos1_close(chanpos_nil): void = "mac#%"
fun channeg1_close(channeg_nil): void = "mac#%"
//
(* ****** ****** *)
//
(*
overload channel1_send with chanpos1_send
overload channel1_recv with chanpos1_recv
overload channel1_send with channeg1_recv
overload channel1_recv with channeg1_send
overload channel1_close with chanpos1_close
overload channel1_close with channeg1_close
*)
//
(* ****** ****** *)
//
typedef
chanpos_nullify(ss:type) =
  (chanpos(ss), chpcont0_nil) -<cloref1> void
typedef
channeg_nullify(ss:type) =
  (channeg(ss), chncont0_nil) -<cloref1> void
//
(* ****** ****** *)
//
fun{}
chanpos1_append
  {ss1,ss2:type}
(
  chanpos(ssappend(ss1,ss2)), k0: chpcont0_nil
, fserv1: chanpos_nullify(ss1), fserv2: chanpos_nullify(ss2)
) : void // end of [chanpos1_append]
//
fun{}
channeg1_append
  {ss1,ss2:type}
(
  channeg(ssappend(ss1,ss2)), k0: chncont0_nil
, fserv1: channeg_nullify(ss1), fserv2: channeg_nullify(ss2)
) : void // end of [channeg1_append]
//
(* ****** ****** *)
//
fun{}
chanpos1_choose_conj
  {ss1,ss2:type}
(
  chanpos(sschoose_conj(ss1,ss2)), k0: chpcont0_nil
, fserv1: chanpos_nullify(ss1), fserv2: chanpos_nullify(ss2)
) : void // end of [chanpos1_choose_conj]
//
fun{}
channeg1_choose_conj
  {ss1,ss2:type}
(
  channeg(sschoose_conj(ss1,ss2)), k0: chncont0_nil
, fserv1: channeg_nullify(ss1), fserv2: channeg_nullify(ss2)
) : void // end of [channeg1_choose_conj]
//
fun{}
channeg1_choose_conj$choose(): natLt(2)
fun{}
chanpos1_choose_conj$fwork_tag(tag: int): void
fun{}
channeg1_choose_conj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_choose_disj
  {ss1,ss2:type}
(
  chanpos(sschoose_disj(ss1,ss2)), k0: chpcont0_nil
, fserv1: chanpos_nullify(ss1), fserv2: chanpos_nullify(ss2)
) : void // end of [chanpos1_choose_disj]
fun{}
channeg1_choose_disj
  {ss1,ss2:type}
(
  channeg(sschoose_disj(ss1,ss2)), k0: chncont0_nil
, fserv1: channeg_nullify(ss1), fserv2: channeg_nullify(ss2)
) : void // end of [channeg1_choose_disj]
//
fun{}
chanpos1_choose_disj$choose(): natLt(2)
fun{}
chanpos1_choose_disj$fwork_tag(tag: int): void
fun{}
channeg1_choose_disj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_option_conj
  {ss:type}
(
  chanpos(ssoption_conj(ss))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_option_conj]
fun{}
channeg1_option_conj
  {ss:type}
(
  channeg(ssoption_conj(ss))
, k0: chncont0_nil, fserv: channeg_nullify(ss)
) : void // end of [channeg1_option_conj]
//
fun{}
channeg1_option_conj$choose(): natLt(2)
fun{}
chanpos1_option_conj$fwork_tag(tag: int): void
fun{}
channeg1_option_conj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_option_disj
  {ss:type}
(
  chanpos(ssoption_disj(ss))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_option_disj]
fun{}
channeg1_option_disj
  {ss:type}
(
  channeg(ssoption_disj(ss))
, k0: chncont0_nil, fserv: channeg_nullify(ss)
) : void // end of [channeg1_option_disj]
//
fun{}
chanpos1_option_disj$choose(): natLt(2)
fun{}
chanpos1_option_disj$fwork_tag(tag: int): void
fun{}
channeg1_option_disj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_repeat_conj
  {ss:type}
(
  chanpos(ssrepeat_conj(ss))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_repeat_conj]
//
fun{}
channeg1_repeat_conj
  {ss:type}
(
  channeg(ssrepeat_conj(ss))
, k0: chncont0_nil, fserv: channeg_nullify(ss)
) : void // end of [channeg1_repeat_conj]
//
fun{}
chanpos1_repeat_conj$init(): void
fun{}
channeg1_repeat_conj$init(): void
//
fun{}
channeg1_repeat_conj$choose(): natLt(2)
//
fun{}
chanpos1_repeat_conj$fwork_tag(tag: int): void
fun{}
channeg1_repeat_conj$fwork_tag(tag: int): void
//
fun{}
channeg1_repeat_conj$spawn(() -<lincloptr1> void): void
//
(* ****** ****** *)
//
fun{}
chanpos1_repeat_disj
  {ss:type}
(
  chanpos(ssrepeat_disj(ss))
, k0: chpcont0_nil, fserv: chanpos_nullify(ss)
) : void // end of [chanpos1_repeat_disj]
//
fun{}
channeg1_repeat_disj
  {ss:type}
(
  channeg(ssrepeat_disj(ss))
, k0: chncont0_nil, fserv: channeg_nullify(ss)
) : void // end of [channeg1_repeat_disj]
//
fun{}
chanpos1_repeat_disj$init(): void
fun{}
channeg1_repeat_disj$init(): void
//
fun{}
chanpos1_repeat_disj$choose(): natLt(2)
//
fun{}
chanpos1_repeat_disj$fwork_tag(tag: int): void
fun{}
channeg1_repeat_disj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_choose_conj
  {ss1,ss2:type}
(
  chanpos(sschoose_conj(ss1,ss2))
, k0: chpcont0_nil, f1: chanpos_nullify(ss1), f2: chanpos_nullify(ss2)
) : void // end of [chanpos1_choose_conj]
//
fun{}
channeg1_choose_conj
  {ss1,ss2:type}
(
  channeg(sschoose_conj(ss1,ss2))
, k0: chncont0_nil, f1: channeg_nullify(ss1), f2: channeg_nullify(ss2)
) : void // end of [channeg1_choose_cons]
//
fun{}
channeg1_choose_conj$choose((*void*)): natLt(2)
fun{}
chanpos1_choose_conj$fwork_tag(tag: int): void
fun{}
channeg1_choose_conj$fwork_tag(tag: int): void
//
(* ****** ****** *)
//
fun{}
chanpos1_choose_disj
  {ss1,ss2:type}
(
  chanpos(sschoose_disj(ss1,ss2))
, k0: chpcont0_nil, f1: chanpos_nullify(ss1), f2: chanpos_nullify(ss2)
) : void // end of [chanpos1_choose_disj]
//
fun{}
channeg1_choose_disj
  {ss1,ss2:type}
(
  channeg(sschoose_disj(ss1,ss2))
, k0: chncont0_nil, f1: channeg_nullify(ss1), f2: channeg_nullify(ss2)
) : void // end of [channeg1_choose_cons]
//
fun{}
chanpos1_choose_disj$choose((*void*)): natLt(2)
fun{}
chanpos1_choose_disj$fwork_tag(tag: int): void
fun{}
channeg1_choose_disj$fwork_tag(tag: int): void
//
(* ****** ****** *)

(* end of [channel.sats] *)

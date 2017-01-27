(*
**
** HX-2014-09-14:
** [weboxy] is a small package for doing
** webpage layout; it generates CSS for use
** and also HTML for the purpose of reviewing
**
*)

(* ****** ****** *)
//
#define
ATS_PACKNAME
"ATSCNTRB.HX.weboxy"
//
(* ****** ****** *)
//
(*
//
// HX-2017-01-26:
// weboxy.dats is to be included.
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
*)
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define UID "uid"
#define NAME "name"
//
#define WIDTH "width"
#define PWIDTH "pwidth"
//
#define HEIGHT "height"
#define PHEIGHT "pheight"
//
#define COLOR "color"
#define BGCOLOR "bgcolor"
//
#define PARENT "parent"
#define CHILDREN "children"
//
#define CONTENT "content"
//
#define PCENTLST "pcentlst"
#define TABSTYLE "tabstyle"
//
(* ****** ****** *)

typedef color = string

(* ****** ****** *)
//
extern
fun{}
randcolor((*void*)): color
//
extern
fun{}
randcolor_initize((*void*)): void
//
(* ****** ****** *)

datatype
tabstyle =
  | TSnone of ()
  | TShbox of ()
  | TSvbox of ()
// end of [tabstyle]

(* ****** ****** *)
//
extern
fun{}
tabstyle_isbox (ts: tabstyle): bool
extern
fun{}
tabstyle_ishbox (ts: tabstyle): bool
extern
fun{}
tabstyle_isvbox (ts: tabstyle): bool
//
overload .isbox with tabstyle_isbox
overload .ishbox with tabstyle_ishbox
overload .isvbox with tabstyle_isvbox
//
(* ****** ****** *)
//
datatype gval =
  | GVnil of ()
  | GVint of (int)
  | GVfloat of (double)
  | GVstring of (string)
  | {a:type} GVboxed of (a)
//
typedef gvalopt = Option(gval)
vtypedef gvalopt_vt = Option_vt(gval)
//
(* ****** ****** *)
//
typedef webox =
  ref(list0($tup(string, gval)))
//
typedef weboxlst = list0(webox)
typedef weboxopt = Option(webox)
//
(* ****** ****** *)
//
extern
fun
webox0_make((*void*)): webox
//
(* ****** ****** *)
//
extern
fun
webox_search
  (wbx: webox, k0: string): gvalopt_vt
extern
fun
webox_insert_any
  (wbx: webox, k: string, v: gval): void
//
implement
webox_search
  (wbx, k0) = let
  val kvs = wbx[]
  val opt = kvs.find_opt()(lam kv => k0 = kv.0)
in
  case+ opt of
  | ~None_vt() => None_vt()
  | ~Some_vt(kv) => Some_vt(kv.1)
end // end of [webox_search]
implement
webox_insert_any
  (wbx, k, v) =
(
let
  val kvs = wbx[] in wbx[] := list0_cons($tup(k, v), kvs)
end // end of [webox_insert_any]
)
//
(* ****** ****** *)
//
extern
fun{}
webox_make ((*void*)): webox
extern
fun{}
webox_make_name (name: string): webox
extern
fun{}
webox_make_name_width (name: string, width: int): webox
extern
fun{}
webox_make_name_pwidth (name: string, pwidth: int): webox
//
(* ****** ****** *)
//
// HX-2014-09-13:
// uid: unique indentification
//
extern
fun
webox_get_uid(webox): int
//
// HX-2014-09-13:
// name: name given by the user
//
extern
fun
webox_get_name(webox): string
//
overload .uid with webox_get_uid
overload .name with webox_get_name
//
(* ****** ****** *)
//
extern
fun
webox_get_width (webox): int
extern
fun
webox_set_width (webox, width: int): void
//
overload .width with webox_get_width
overload .width with webox_set_width
//
(* ****** ****** *)
//
// HX: p...: percentage
//
extern
fun
webox_get_pwidth (webox): int
extern
fun
webox_set_pwidth (webox, pwidth: int): void
//
overload .pwidth with webox_get_pwidth
overload .pwidth with webox_set_pwidth
//
(* ****** ****** *)
//
extern
fun
webox_get_height (webox): int
extern
fun
webox_set_height (webox, height: int): void
//
overload .height with webox_get_height
overload .height with webox_set_height
//
(* ****** ****** *)
//
// HX: p...: percentage
//
extern
fun
webox_get_pheight (webox): int
extern
fun
webox_set_pheight (webox, pheight: int): void
//
overload .pheight with webox_get_pheight
overload .pheight with webox_set_pheight
//
(* ****** ****** *)
//
extern
fun
webox_get_color (webox): color
extern
fun
webox_set_color (webox, c: color): void
//
overload .color with webox_get_color
overload .color with webox_set_color
//
(* ****** ****** *)
//
extern
fun
webox_get_bgcolor (webox): color
extern
fun
webox_set_bgcolor (webox, c: color): void
//
overload .bgcolor with webox_get_bgcolor
overload .bgcolor with webox_set_bgcolor
//
(* ****** ****** *)
//
extern
fun
webox_is_root (x: webox): bool
extern
fun
webox_get_parent (webox): weboxopt
extern
fun
webox_set_parent (webox, opt: weboxopt): void
//
overload .isrt with webox_is_root
overload .parent with webox_get_parent
overload .parent with webox_set_parent
//
(* ****** ****** *)
//
extern
fun
webox_get_children (webox): weboxlst
extern
fun
webox_set_children (webox, xs: weboxlst): void
extern
fun{}
webox_set_children_1 (webox, x: webox): void
extern
fun{}
webox_set_children_2 (webox, x1: webox, x2: webox): void
extern
fun{}
webox_set_children_3 (webox, x1: webox, x2: webox, x3: webox): void
extern
fun{}
webox_set_children_4 (webox, x1: webox, x2: webox, x3: webox, x4: webox): void
//
overload .children with webox_get_children
overload .children with webox_set_children
overload .children with webox_set_children_1
overload .children with webox_set_children_2
overload .children with webox_set_children_3
overload .children with webox_set_children_4
//
(* ****** ****** *)
//
extern
fun
webox_get_tabstyle(webox): tabstyle
extern
fun
webox_set_tabstyle(webox, sty: tabstyle): void
//
overload .tabstyle with webox_get_tabstyle
overload .tabstyle with webox_set_tabstyle
//
(* ****** ****** *)
//
datatype pcent =
  | PCnone of ()
  | PChard of intGte(0)
  | PCsoft of intGte(0)
//
typedef pcentlst = list0(pcent)
//
extern
fun
pcentlst_get_at
  (xs: pcentlst, i: intGte(0)): pcent
//
(* ****** ****** *)
//
extern
fun
webox_get_pcentlst (webox): pcentlst
extern
fun
webox_set_pcentlst (webox, xs: pcentlst): void
//
overload .pcentlst with webox_get_pcentlst
overload .pcentlst with webox_set_pcentlst
//
(* ****** ****** *)
//
extern
fun
webox_get_content (webox): string
extern
fun
webox_set_content (webox, content: string): void
//
overload .content with webox_get_content
overload .content with webox_set_content
//
(* ****** ****** *)

extern
fun{}
gprint_webox_width(wbx: webox): void

(* ****** ****** *)

extern
fun{}
gprint_webox_height(wbx: webox): void

(* ****** ****** *)

extern
fun{}
gprint_webox_color(wbx: webox): void
extern
fun{}
gprint_webox_bgcolor(wbx: webox): void

(* ****** ****** *)

extern
fun{}
gprint_css_preamble((*void*)): void
extern
fun{}
gprint_css_postamble((*void*)): void

(* ****** ****** *)

extern
fun{}
gprint_webox_css_one(webox): void
extern
fun{}
gprint_webox_css_all(webox): void
extern
fun{}
gprint_weboxlst_css_all(weboxlst): void

(* ****** ****** *)

extern
fun{}
gprint_webox_head_beg((*void*)): void
extern
fun{}
gprint_webox_head_end((*void*)): void

(* ****** ****** *)

extern
fun{}
gprint_webox_body_end((*void*)): void
extern
fun{}
gprint_webox_body_after((*void*)): void

(* ****** ****** *)

extern
fun{}
gprint_webox_html_all(wbx0: webox): void

(* ****** ****** *)
//
implement
{}(*tmp*)
randcolor() = ""
//
implement
{}(*tmp*)
randcolor_initize() = ()
//
(* ****** ****** *)
//
implement
{}(*tmp*)
tabstyle_isbox(ts) =
  case+ ts of TSnone () => false | _ => true
//
implement
{}(*tmp*)
tabstyle_ishbox(ts) =
  case+ ts of TShbox () => true | _ => false
implement
{}(*tmp*)
tabstyle_isvbox(ts) =
  case+ ts of TSvbox () => true | _ => false  
//
(* ****** ****** *)

implement
webox_get_name
  (wbx) = let
//
val opt =
  webox_search(wbx, NAME)
//
in
//
case+ opt of
| ~Some_vt (gv) =>
    let val-GVstring(nm) = gv in nm end
  // end of [Some_vt]
| ~None_vt ((*void*)) => "" (* nameless *)
//
end // end of [webox_get_name]

(* ****** ****** *)

implement
webox_get_width
  (wbx) = let
//
val opt =
  webox_search(wbx, WIDTH)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVint(w) = gv in w end
| ~None_vt((*void*)) => ~1(*erroneous*)
//
end // end of [webox_get_width]

(* ****** ****** *)
//
implement
webox_set_width
  (wbx, w) =
(
  webox_insert_any(wbx, WIDTH, GVint(w))
)
//
(* ****** ****** *)

implement
webox_get_pwidth
  (wbx) = let
//
val opt =
  webox_search(wbx, PWIDTH)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVint(pw) = gv in pw end
| ~None_vt((*void*)) => ~1(*erroneous*)
//
end // end of [webox_get_pwidth]

(* ****** ****** *)
//
implement
webox_set_pwidth
  (wbx, pw) =
(
webox_insert_any(wbx, PWIDTH, GVint(pw))
)
//
(* ****** ****** *)

implement
webox_get_height
  (wbx) = let
//
val opt =
  webox_search(wbx, HEIGHT)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVint(h) = gv in h end
| ~None_vt((*void*)) => ~1(*erroneous*)
//
end // end of [webox_get_height]

(* ****** ****** *)
//
implement
webox_set_height
  (wbx, h) =
(
webox_insert_any(wbx, HEIGHT, GVint(h))
)
//
(* ****** ****** *)

implement
webox_get_pheight
  (wbx) = let
//
val opt =
  webox_search(wbx, PHEIGHT)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVint(ph) = gv in ph end
| ~None_vt((*void*)) => ~1(*erroneous*)
//
end // end of [webox_get_pheight]

(* ****** ****** *)
//
implement
webox_set_pheight
  (wbx, ph) =
(
webox_insert_any(wbx, PHEIGHT, GVint(ph))
)
//
(* ****** ****** *)

implement
webox_get_color
  (wbx) = let
//
val opt =
  webox_search (wbx, COLOR)
//
in
//
case+ opt of
| ~Some_vt (gv) =>
  let val-GVstring(c) = gv in c end
| ~None_vt((*void*)) => ""(*erroneous*)
//
end // end of [webox_get_color]

(* ****** ****** *)
//
implement
webox_set_color
  (wbx, clr) =
(
webox_insert_any(wbx, COLOR, GVstring(clr))
)
//
(* ****** ****** *)

implement
webox_get_bgcolor
  (wbx) = let
//
val opt =
  webox_search(wbx, BGCOLOR)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVstring(clr) = gv in clr end
| ~None_vt ((*void*)) => ""(*erroneous*)
//
end // end of [webox_get_bgcolor]

(* ****** ****** *)
//
implement
webox_set_bgcolor
  (wbx, clr) =
(
webox_insert_any(wbx, BGCOLOR, GVstring(clr))
)
//
(* ****** ****** *)

implement
webox_get_parent
  (wbx) = let
//
val opt =
  webox_search(wbx, PARENT)
//
in
//
case+ opt of
| ~None_vt() =>
    None((*void*))
  // end of [None_vt]
| ~Some_vt(p) => let
    val-GVboxed(x) = p in $UN.cast{weboxopt}(x)
  end // end of [Some_vt]
//
end // end of [webox_get_parent]

(* ****** ****** *)
//
implement
webox_set_parent
  (wbx, p) =
(
webox_insert_any(wbx, PARENT, GVboxed(p))
)
//
(* ****** ****** *)

implement
webox_get_children
  (wbx) = let
//
val opt =
  webox_search(wbx, CHILDREN)
//
in
//
case+ opt of
| ~None_vt () =>
    list0_nil()
  // end of [None_vt]
| ~Some_vt (gv) => let
    val-GVboxed(x) = gv in $UN.cast{weboxlst}(x)
  end // end of [Some_vt]
//
end // end of [webox_get_children]

(* ****** ****** *)

implement
webox_set_children
  (wbx, xs) = let
//
val p0 = Some(wbx)
//
val () =
(xs).foreach()(lam x => x.parent(p0))
//
in
//
webox_insert_any
  (wbx, CHILDREN, GVboxed(xs))
//
end // end of [webox_set_children]
//
(* ****** ****** *)
//
local
//
#define :: cons0
//
in (* in-of-local *)
//
implement
{}(*tmp*)
webox_set_children_1
  (wbx, x) = webox_set_children(wbx, list0_sing(x))
implement
{}(*tmp*)
webox_set_children_2
  (wbx, x1, x2) = webox_set_children(wbx, list0_pair(x1, x2))
implement
{}(*tmp*)
webox_set_children_3
  (wbx, x1, x2, x3) = webox_set_children(wbx, x1::x2::x3::nil0())
implement
{}(*tmp*)
webox_set_children_4
  (wbx, x1, x2, x3, x4) = webox_set_children(wbx, x1::x2::x3::x4::nil0())
//
end // end of [local]

(* ****** ****** *)

implement
webox_get_tabstyle
  (wbx) = let
//
val opt =
  webox_search(wbx, TABSTYLE)
//
in
//
case+ opt of
| ~None_vt() =>
    TSnone((*void*))
  // end of [None_vt]
| ~Some_vt(gv) => let
    val-GVboxed(x) = gv in $UN.cast{tabstyle}(x)
  end // end of [Some_vt]
//
end // end of [webox_get_tabstyle]

(* ****** ****** *)
//
implement
webox_set_tabstyle
  (wbx, ts) =
(
webox_insert_any(wbx, TABSTYLE, GVboxed(ts))
)
//
(* ****** ****** *)

implement
webox_get_pcentlst
  (wbx) = let
//
val opt =
  webox_search(wbx, PCENTLST)
//
in
//
case+ opt of
| ~None_vt() =>
    list0_nil()
| ~Some_vt(gv) => let
    val-GVboxed(pcs) = gv in $UN.cast{pcentlst}(pcs)
  end // end of [Some_vt]
//
end // end of [webox_get_percentlst]

(* ****** ****** *)
//
implement
webox_set_pcentlst
  (wbx, pcs) =
(
webox_insert_any(wbx, PCENTLST, GVboxed(pcs))
)
//
(* ****** ****** *)

implement
pcentlst_get_at
  (pcs, i) = let
//
fun
loop
(
pcs: pcentlst, i: int
) : pcent =
(
case+ pcs of
| list0_nil() =>
  (
    PCnone()
  ) (* list_nil *)
| list0_cons(pc, pcs) =>
    if i > 0 then loop(pcs, i-1) else pc
  // end of [list_cons]
) (* end of [loop] *)
//
in
  loop(pcs, i)
end // end of [pcentlst_get_at]

(* ****** ****** *)

implement
webox_get_content
  (wbx) = let
//
val opt =
  webox_search(wbx, CONTENT)
//
in
//
case+ opt of
| ~Some_vt(gv) =>
  let val-GVstring(c0) = gv in c0 end
| ~None_vt((*void*)) => ""(*default*)
//
end // end of [webox_get_content]

(* ****** ****** *)
//
implement
webox_set_content
  (wbx, c0) =
(
webox_insert_any(wbx, CONTENT, GVstring(c0))
)
//
(* ****** ****** *)

local
//
val theUID = ref(0): ref(int)
//
fun theUID_getinc () =
  let val n = theUID[] in theUID[] := n+1; n end
//
in (* in-of-local *)

implement
webox0_make
(
// argumentless
) = wbx where {
//
val uid = theUID_getinc()
val wbx = ref(list0_nil(*void*))
//
val ((*void*)) =
  webox_insert_any (wbx, UID, GVint(uid))
//
} (* end of [webox0_make] *)

end // end of [local]

(* ****** ****** *)
//
implement
{}(*tmp*)
webox_make () = webox0_make ()
//
(* ****** ****** *)
//
implement
{}(*tmp*)
webox_make_name
  (name) = wbx where
{
//
val wbx = webox_make()
val ((*void*)) = 
  webox_insert_any(wbx, NAME, GVstring(name))
//
} (* end of [webox_make_name] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
webox_make_name_width
  (name, width) = wbx where
{
//
val wbx = webox_make_name(name)
val ((*void*)) = 
  webox_insert_any(wbx, WIDTH, GVint(width))
//
} (* end of [webox_make_name_width] *)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
webox_make_name_pwidth
  (name, pwidth) = wbx where
{
//
val wbx = webox_make_name(name)
val ((*void*)) = 
  webox_insert_any(wbx, PWIDTH, GVint(pwidth))
//
} (* end of [webox_make_name_pwidth] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_width
  (wbx) = let
//
val w = wbx.width()
//
in
//
if
(w >= 0)
then
(
gprintln!
(
"width: ", w, "px;"
)
)
else let
//
val pw = wbx.pwidth()
//
in
  if pw >= 0
    then gprintln! ("width: ", pw, "%;")
  // end of [if]
end // end of [else]
//
end // end of [gprint_webox_width]
  
(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_height
  (wbx) = let
//
val h = wbx.height()
//
in
//
if h >= 0
then
(
gprintln!
(
  "height: ", h, "px;"
)
)
else let
//
val ph = wbx.pheight()
//
in
  if ph >= 0
    then gprintln! ("height: ", ph, "%;")
  // end of [if]
end // end of [else]
//
end // end of [gprint_webox_height]
//
(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_color
  (wbx) = let
//
val clr = wbx.color()
//
in
//
if isneqz(clr)
  then gprintln! ("color: ", clr, ";")
//
end // end of [gprint_webox_color]

(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_bgcolor
  (wbx) = let
//
val clr = wbx.bgcolor()
//
in
//
if isneqz(clr)
  then gprintln! ("background-color: ", clr, ";")
//
end // end of [gprint_webox_bgcolor]
  
(* ****** ****** *)

implement
{}(*tmp*)
gprint_css_preamble() = ()
implement
{}(*tmp*)
gprint_css_postamble() = ()

(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_css_one
  (wbx0) = () where
{
//
fun auxlst
(
  wbxs: weboxlst, i: int
) : void =
(
//
case+ wbxs of
| list0_nil () => ()
| list0_cons (wbx, wbxs) => let
    val () =
    if i > 0
      then gprint(", ")
    // end of [if]
    val () = gprint(wbx.name())
  in
    auxlst (wbxs, i+1)
  end // end of [list_cons]
)
//
val name = wbx0.name()
//
val () = gprint! ("#", name, " {\n")
//
val () = gprint_string ("/*")
val () = gprint_string ("\nparent: ")
//
val () =
(
//
case+
wbx0.parent()
of // case+
| None() => ()
| Some(wbx) => gprint (wbx.name())
//
) (* end of [val] *)
//
val () = gprint_string("\nchildren: ")
val () = auxlst (wbx0.children(), 0(*i*))
//
val ((*closing*)) = gprint_string ("\n*/\n")
//
val () = gprint_webox_width (wbx0)
val () = gprint_webox_height(wbx0)
//
val () = gprint_webox_color(wbx0)
val () = gprint_webox_bgcolor(wbx0)
//
val ((*closing*)) = gprintln! ("} /* ", name, " */")
//
} (* end of [gprint_webox_css_one] *)

(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_css_all
  (x0) = let
//
val xs = x0.children()
//
val () =
  gprint_weboxlst_css_all(xs)
val () =
  if isneqz(xs) then gprint_newline()
//
in
  gprint_webox_css_one(x0)
end // end of [gprint_webox_css_all]

(* ****** ****** *)

implement
{}(*tmp*)
gprint_weboxlst_css_all
  (xs) = let
//
fun
loop
(
  xs: weboxlst, i: int
) : void =
  case+ xs of
  | list0_nil() => ()
  | list0_cons(x, xs) => let
      val () =
      if i > 0 then gprint ("\n")
      val () = gprint_webox_css_all(x)
    in
      loop (xs, i+1)
    end // end of [list_cons]
// end of [loop]
//
in
  loop (xs, 0)
end // end of [gprint_weboxlst_css_all]

(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_webox_head_beg() = ()
//
implement
{}(*tmp*)
gprint_webox_head_end() = ()
//
(* ****** ****** *)
//
implement
{}(*tmp*)
gprint_webox_body_end() = ()
implement
{}(*tmp*)
gprint_webox_body_after() = ()
//
(* ****** ****** *)

extern
fun{}
gprint_webox_html
  (wbx0: webox): void
extern
fun{}
gprint_weboxlst_html
(
  tbs: tabstyle, pcs: pcentlst, xs: weboxlst
) : void // end-of-function

(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_html
  (wbx0) = let
//
val
name = wbx0.name()
//
val () =
gprint!
(
  "<div id=\"", name, "\">\n"
) (* end of [val] *)
//
val wbxs = wbx0.children()
//
val () = (
//
if
isneqz(wbxs)
then let
  val ts = wbx0.tabstyle()
  val pcs = webox_get_pcentlst(wbx0)
in
  gprint (wbx0.content());
  gprint_weboxlst_html (ts, pcs, wbxs)
end // end of [then]
else let
  val msg = wbx0.content()
in
  if isneqz(msg)
    then gprint (msg)
    else gprint! ("[", name , "]\n")
  // end of [if]
end // end of [else]
//
) : void // end of [val]
//
val ((*closing*)) =
  gprintln! ("</div><!--", name, "-->")
//
in
  // nothing
end // end of [gprint_webox_html]

(* ****** ****** *)

implement
{}(*tmp*)
gprint_weboxlst_html
  (tbs, pcs, wbxs) = let
//
val isbox = tbs.isbox()
val ishbox = tbs.ishbox()
val isvbox = tbs.isvbox()
//
fun
gprint_hbox_pcent
  (pc: pcent): void =
(
case+ pc of
| PCnone() => ()
| PChard(n) => gprint!("width:", n, "%;")
| PCsoft(n) => gprint!("width:", n, "%;height:0px;")
)
//
fun
gprint_vbox_pcent
  (pc: pcent): void =
(
case+ pc of
| PCnone() => ()
| PChard(n) => gprint!("height:", n, "%;")
| PCsoft(n) => gprint!("width:0px;height:", n, "%;")
)
//
fun
loop{i:nat}
(
  wbxs: weboxlst, i: int i
) : void = let
in
//
case+ wbxs of
| list0_nil
    ((*void*)) => ()
  // end of [list0_nil]
| list0_cons
    (wbx, wbxs) => let
    val () =
    if i > 0 then gprint ("\n")
    val () =
    if isvbox then let
      val pc = pcentlst_get_at(pcs, i)
      overload gprint with gprint_vbox_pcent
    in
      gprint! ("<tr style=\"", pc, "\">\n")
    end // end of [then] // end of [if]
//
    val () =
    if ishbox then let
      val pc = pcentlst_get_at(pcs, i)
      overload gprint with gprint_hbox_pcent
    in
      gprint! ("<td style=\"vertical-align:top;", pc, "\">\n")
      // end of [if]
    end // end of [then] // end of [if]
//
// HX: there is no halign!
//
    val () =
    if isvbox then gprint ("<td>\n")
//
    val () = gprint_webox_html<>(wbx)
//
    val () = if isvbox then gprint ("</td>\n")
    val () = if ishbox then gprint ("</td>\n")
    val () = if isvbox then gprint ("</tr>\n")
  in
    loop (wbxs, i+1)
  end // end of [list_cons]
end // end of [loop]
//
val () =
if
isbox
then (
//
gprint(
"\
<table
 style=\"width:100%;height:100%;\"
 cellspacing=\"0\" cellpadding=\"0\">
") (* end of [val] *)
//
) (* end of [then] *) // end of [if]
//
val () =
if
ishbox
then
(
gprint("<tr height=\"100%\">\n")
)
//
val () = loop (wbxs, 0)
//
val () = if ishbox then gprint ("</tr>\n")
val () = if ishbox then gprint ("</table>\n")
val () = if isvbox then gprint ("</table>\n")
//
in
  // nothing
end // end of [gprint_weboxlst_html]

(* ****** ****** *)

implement
{}(*tmp*)
gprint_webox_html_all
  (wbx0) = let
//
val () =
gprint!(
"\
<!DOCTYPE html>\n\
<html>\n\
<head>\n\
") (* end of [val] *)
//
val () =
  gprint_webox_head_beg<>()
//
val () = gprint("<style>\n")
//
val () =
  gprint_css_preamble<>()
val () =
  gprint_webox_css_all<>(wbx0)
val () =
  gprint_css_postamble<>()
//
val () = gprint("</style>\n")
//
val () = gprint_webox_head_end<>()
//
val () = gprint("</head>\n")
//
val () = gprint("<body>\n")
val () = gprint_webox_html<>(wbx0)
val () = gprint_webox_body_end<>()
val () = gprint("</body>\n")
//
val () = gprint_webox_body_after<>()
//
val () = gprint("</html>\n")
//
val ((*flushing*)) = gprint_flush<>()
//
in
  // nothing
end // end of [gprint_webox_html_all]

(* ****** ****** *)

(* end of [weboxy.dats] *)

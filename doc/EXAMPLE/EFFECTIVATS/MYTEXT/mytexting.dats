(*
// ATS-texting
// for Effective ATS
*)
(* ****** ****** *)
//
#define
ATEXTING_targetloc
"$PATSHOME/utils/atexting"
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
#include
"share/HATS\
/atslib_staload_libats_libc.hats"
//
(* ****** ****** *)
//
#include
"{$ATEXTING}/mylibies.hats"
//
#staload $ATEXTING
#staload $ATEXTING_TEXTDEF
//
#include
"{$ATEXTING}/mylibies_link.hats"
//
(* ****** ****** *)
//
local
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_pre.dats"
in (* nothing *) end
//
local
#include
"{$ATEXTING}\
/DATS/SHARE/atexting_textdef_xhtml.dats"
in (* nothing *) end
//
(* ****** ****** *)
//
extern
fun
libatsynmark_dynloadall(): void = "ext#"
val () = libatsynmark_dynloadall((*void*))
//
(* ****** ****** *)

local

fun
__tagging__
(
  loc: loc_t
, t_beg: string
, t_end: string
, txtlst: atextlst
) : atext = let
//
val-
cons0
(x0, _) = txtlst
//
val x0 =
atext_make_string
(
  x0.atext_loc, atext_strngfy(x0)
)
//
val
t_beg =
atext_make_string(loc, t_beg)
val
t_end =
atext_make_string(loc, t_end)
//
val
txtlst =
$list{atext}(t_beg, x0, t_end)
//
in
  atext_make(loc, TEXTlist(g0ofg1(txtlst)))
end // end of [__tagging__]

in (* in-of-local *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "para"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<p>", "</p>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "filename"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<tt>", "</tt>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "command"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<em>", "</em>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "sub"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<sub>", "</sub>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

val () =
the_atextmap_insert
( "sup"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<sup>", "</sup>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "stacode"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<span style=\"color: #0000F0;\">", "</span>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

val () =
the_atextmap_insert
( "dyncode"
, TEXTDEFfun
  (
    lam(loc, xs) =>
    __tagging__(loc, "<span style=\"color: #F00000;\">", "</span>", xs)
  ) (* TEXTDEFfun *)
) (* the_atextmap_insert *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

fun
__thePage_style__
(
  loc: loc_t, _: atextlst
) : atext =
atext_make_string
( loc
, "\
<style type=\"text/css\">
  @import url(\"https://fonts.googleapis.com/css?family=Lato:400,300,700\");

  body {
    margin: 0 auto;
    width: 66%;
    font-family: \"Lato\", sans-serif;
    font-weight: 400;
    font-size: 15pt;
    color: #2E2E2E;
    padding-left: 2em;
    padding-right: 2em;
    border-left: 1px solid #acacac;
    border-right: 1px solid #acacac;
  }
  pre, .patsyntax {
    color: black;
    background-color: #FEFFEC;
    border: 1px solid #acacac;
    border-left: 5px solid #BCBCBC;
    padding: 20px;
    margin: 1.5em 0;
    font-family: monospace;
    font-size: 0.75em;
    overflow: auto;
    line-height: 1.3em;
  }
  h1, h2, h3 {
    font-family: \"Lato\", sans-serif;
  }
  h1 {
    border: 1px solid #8c8c8c;
    font-size: 1.2em;
    padding: 5px;
    background-color: #EEF;
    box-shadow: 1px 1px 2px #999;
    text-align: center;
  }
  h2 {
    border-bottom: 1px solid #8C8C8C;
    padding: 5px;
    margin-top: 1em;
    font-size: 1.2em;
    text-align: left;
  }
  h4 {
    border-bottom: 1px dashed #8C8C8C;
  }
  ol, ul {
    list-style: none;
    padding-left: 0;
  }
  li:first-child {
    border-top: 1px solid #EEF;
  }
  li:hover {
    background-color: #EEF;
  }
  li {
    border-bottom: 1px solid #EEF;
    border-left: 1px solid #EEF;
    border-right: 1px solid #EEF;
  }
  li a {
    display: inline-block;
    width: 100%;
    height: 100%;
    padding: 5px;
  }

  a:hover {
    color: black;
  }
  a:visited {
    color: #7D7D7D;
  }
  a {
    text-decoration: none;
    color: #0062BB;
  }

  @media print {
  body {
    margin: 0 auto;
    width: 90%;
    font-size: 12pt;
    border-left: 0;
    border-right: 0;
  }
  pre, .patsyntax {
    color: black;
    padding: 10px;
    font-size: 10pt;
  }
  h1 {
    box-shadow: none;
  }
  }
</style>
") (* end of [_thePage_style__] *)

fun
__thePage_script__
(
  loc: loc_t, _: atextlst
) : atext =
atext_make_string
( loc
, "\
<script type=\"text/javascript\">
  window.onload = function() {
    var links = [];
    var headers = document.getElementsByTagName('h2');

    for (var i = 0; i < headers.length; i++) {
        var header = headers[i];
        var subHeadings = header.getElementsByTagName('h4');
        var title = header.innerHTML;
        var link = title.trim().split(/\\s/).map(function(x) { return x.toLowerCase(); }).join('-');
        var html = '<h2 id=\"' + link + '\">' + title + '</h2>';
        var linkHtml = '<a href=\"#' + link + '\">' + html + '</a>';
        header.outerHTML = linkHtml;
        links.push({link: link, title: title});
    }

    if (links.length > 0) {
        var sideBarHtml = '<h2>Table of Contents</h2>';
        sideBarHtml += '<ul class=\"sidebar-list\">';
        for (var i = 0; i < links.length; i++) {
            var link = links[i];
            sideBarHtml += '<li class=\"sidebar-item\">';
            sideBarHtml += '<a href=\"#' + link.link + '\">' + link.title + '</a>';
            sideBarHtml += '</li>';
        }
        sideBarHtml += '</ul>';
        sideBarHtml += '<h2>Introduction</h2>';

        var sidebar = document.createElement('div');
        sidebar.className = 'sidebar';
        sidebar.innerHTML = sideBarHtml

        var mainTitle = document.getElementsByTagName('h1')[0];
        document.body.insertBefore(sidebar, mainTitle.nextSibling);
    }
  }
</script>
") (* end of [_thePage_script__] *)

in (* in-of-local *)
//
val () =
the_atextmap_insert
(
  "thePage_style"
, TEXTDEFfun(lam(loc, xs) => __thePage_style__(loc, xs))
)
val () =
the_atextmap_insert
(
  "thePage_script"
, TEXTDEFfun(lam(loc, xs) => __thePage_script__(loc, xs))
)
//
end // end of [local]

(* ****** ****** *)

local

val
def0 =
TEXTDEFfun
(
  lam(loc, xs) => atext_make_nil(loc)
) (* TEXTDEFfun *)

in (* in-of-local *)

val () = the_atextmap_insert("comment", def0)

end // end of [local]

(* ****** ****** *)

(* end of [mytexting.dats] *)

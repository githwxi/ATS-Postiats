(* ****** ****** *)
//
// HX-2013-12-29:
// for writing EFFECTIVATS series
//
(* ****** ****** *)
  
(*

Author: Hongwei Xi (gmhwxiATgmailDOTcom)
Author: Sami Zeinelabdin (https://github.com/sazl)

*)  
  
(* ****** ****** *)
//
dynload
"libatsdoc/dynloadall.dats"
dynload
"utils/libatsynmark/dynloadall.dats"
//
(* ****** ****** *)
//
staload
"libatsdoc/SATS/libatsdoc_atext.sats"
//
(* ****** ****** *)

#include "utils/atsdoc/HATS/xhtmlatxt.hats"

(* ****** ****** *)

fun
patscode_style
  ((*void*)): atext = atext_strcst("\
<style type=\"text/css\">
  .patsyntax {color:#808080;background-color:#E0E0E0;}
  .patsyntax span.keyword {color:#000000;font-weight:bold;}
  .patsyntax span.comment {color:#787878;font-style:italic;}
  .patsyntax span.extcode {color:#A52A2A;}
  .patsyntax span.neuexp  {color:#800080;}
  .patsyntax span.staexp  {color:#0000F0;}
  .patsyntax span.prfexp  {color:#603030;}
  .patsyntax span.dynexp  {color:#F00000;}
  .patsyntax span.stalab  {color:#0000F0;font-style:italic}
  .patsyntax span.dynlab  {color:#F00000;font-style:italic}
  .patsyntax span.dynstr  {color:#008000;font-style:normal}
  .patsyntax span.stacstdec  {text-decoration:none;}
  .patsyntax span.stacstuse  {color:#0000CF;text-decoration:underline;}
  .patsyntax span.dyncstdec  {text-decoration:none;}
  .patsyntax span.dyncstuse  {color:#B80000;text-decoration:underline;}
  .patsyntax span.dyncst_implement  {color:#B80000;text-decoration:underline;}
</style>
") (* end of [patscode_style] *)

(* ****** ****** *)

fun
patspage_style
  ((*void*)): atext = atext_strcst("\
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
") (* end of [patspage_style] *)

(* ****** ****** *)

fun
patspage_script
  ((*void*)): atext = atext_strcst("\
<script type=\"text/javascript\">
  window.onload = function() {
    var links = [];
    var headers = document.getElementsByTagName('h2');

    for (var i = 0; i < headers.length; i++) {
        var header = headers[i];
        var subHeadings = header.getElementsByTagName('h4');
        var title = header.innerHTML;
        var link = title.trim().split(/\s/).map(function(x) { return x.toLowerCase(); }).join('-');
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
") (* end of [patspage_script] *)

(* ****** ****** *)
//
fun
para
(
  x: string
) : atext = xmltagging("p", x)
//
(* ****** ****** *)
//
fun
command
(
  x: string
) : atext = xmltagging("em", x)
//
(* ****** ****** *)
//
fun
filename
(
  x: string
) : atext = xmltagging("u", x)
//
(*
fun
filename
(
  x: string
) : atext = xmltagging("tt", x)
*)
//
(* ****** ****** *)

local
//
staload
"utils/libatsynmark/SATS/libatsynmark.sats"
//
in (* in of [local] *)

fun
pats2xhtml_sats
  (x: string): atext = let
  val [l:addr]
  str = string_pats2xhtmlize_bground (0, x)
  prval () = addr_is_gtez {l} ()
in
  if strptr_is_null (str) then let
    prval () = strptr_free_null (str) in atext_nil ()
  end else atext_strptr (str) // end of [if]
end // end of [pats2xhtml_sats]

fun
pats2xhtml_dats
  (x: string): atext = let
  val [l:addr]
  str = string_pats2xhtmlize_bground (1, x)
  prval () = addr_is_gtez {l} ()
in
  if strptr_is_null (str) then let
    prval () = strptr_free_null (str) in atext_nil ()
  end else atext_strptr (str) // end of [if]
end // end of [pats2xhtml_dats]

end // end of [local]

(* ****** ****** *)

(* end of [atextfun.hats] *)

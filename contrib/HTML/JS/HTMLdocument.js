/**
  HTML5/canvas-2d functions for ATS2
  Author: Will Blair
  Authoremail: wdblairATcsDOTbuDOTedu
  Start Time: October 2013
  Author: Hongwei Xi
  Authoremail: hwxi AT cs DOT bu DOT edu
  Start Time: October 2013
 */

/* ****** ****** */

var atscntrb_html_document =
{
//
    atscntrb_html_document_get_documentElement_clientWidth:
    function () { return document.documentElement.clientWidth; },
    atscntrb_html_document_get_documentElement_clientHeight:
    function () { return document.documentElement.clientHeight; },
//
} ; // end of [atscntrb_html_document]

/* ****** ****** */

mergeInto(LibraryManager.library, atscntrb_html_document);

/* ****** ****** */

/* end of [HTMLdocument.js] */

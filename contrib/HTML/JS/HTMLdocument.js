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
    $MyDocument: {
	objcnt: 0,
	contexts: {},
	objadd: function (obj) {
	    var idx = ++MyDocument.objcnt;
	    MyDocument.contexts[idx] = obj;
	    return idx;
	}
    },
//
    atscntrb_html_document_encode:
    function(obj) { return MyDocument.objadd(obj) ; },
    atscntrb_html_document_decode:
    function(idx) { return MyDocument.contexts[idx] ; },
//
    atscntrb_html_document_get_documentElement_clientWidth:
    function () { return document.documentElement.clientWidth; },
    atscntrb_html_document_get_documentElement_clientHeight:
    function () { return document.documentElement.clientHeight; },
//
    atscntrb_html_document_element_free:
    function (idx) { delete MyDocument.contexts[idx]; },
    atscntrb_html_document_event_free:
    function (idx) { delete MyDocument.contexts[idx]; },
//
    atscntrb_html_document_getElementById:
    function (id) {
	var id2 = Pointer_stringify(id);
	return MyDocument.objadd(document.getElementById(id2));
    },
//
    atscntrb_html_document_element_get_width:
    function (idx) { return MyDocument.contexts[idx].width; },
    atscntrb_html_document_element_get_height:
    function (idx) { return MyDocument.contexts[idx].height; },
//
    atscntrb_html_document_element_set_width:
    function (idx, width) { MyDocument.contexts[idx].width = width; },
    atscntrb_html_document_element_set_height:
    function (idx, height) { MyDocument.contexts[idx].height = height; },
//
    atscntrb_html_document_element_get_value_int:
    function (idx) {
        var res = parseInt(MyDocument.contexts[idx].value);
        if (isNaN(res)) { return -1000000; } else { return res; }
    },
//
    atscntrb_html_document_event_get_keyCode:
    function (idx) { return MyDocument.contexts[idx].keyCode; },
    atscntrb_html_document_event_get_target:
    function (idx) {
        return MyDocument.objadd(MyDocument.contexts[idx].target);
    }
} ; // end of [atscntrb_html_document]

/* ****** ****** */

autoAddDeps(atscntrb_html_document, '$MyDocument');

/* ****** ****** */

mergeInto(LibraryManager.library, atscntrb_html_document);

/* ****** ****** */

/* end of [HTMLdocument.js] */

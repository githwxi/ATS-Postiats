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

var atscntrb_html5_canvas2d =
{
//
    $MyCanvas: {
	objcnt: 0,
	contexts: {},
	objadd: function (obj) {
	    var idx = ++MyCanvas.objcnt;
	    MyCanvas.contexts[idx] = obj;
	    return idx;
	}
    },
//
    atscntrb_html5_canvas2d_make:
    function (id) {
	var idx = 0;
	var id2 = Pointer_stringify(id);
        var canvas = document.getElementById(id2);

        if(!canvas) return 0;

        if(canvas.getContext)
	{
	    idx = MyCanvas.objadd(canvas.getContext("2d"));
        } else {
            throw "atscntrb_html5_canvas2d: 2D-canvas is not supported";
        }

        return idx ; 
    },
//
    atscntrb_html5_canvas2d_free:
    function (idx) { delete MyCanvas.contexts[idx]; },
//
    atscntrb_html5_canvas2d_beginPath:
    function (idx) { MyCanvas.contexts[idx].beginPath(); },
    atscntrb_html5_canvas2d_closePath:
    function (idx) { MyCanvas.contexts[idx].closePath(); },
//
    atscntrb_html5_canvas2d_moveTo:
    function (idx, x, y) { MyCanvas.contexts[idx].moveTo(x, y); },
    atscntrb_html5_canvas2d_lineTo:
    function (idx, x, y) { MyCanvas.contexts[idx].lineTo(x, y); },
//
    atscntrb_html5_canvas2d_scale:
    function (idx, sx, sy) {
        MyCanvas.contexts[idx].scale(sx, sy);
    },
    atscntrb_html5_canvas2d_rotate:
    function (idx, angle) {
        MyCanvas.contexts[idx].rotate(angle);
    },
    atscntrb_html5_canvas2d_translate:
    function (idx, x, y) {
        MyCanvas.contexts[idx].translate(x, y);
    },
//
    atscntrb_html5_canvas2d_arc:
    function
    (
      idx, xc, yc, rad, angle_beg, angle_end, CCW
    ) {
        MyCanvas.contexts[idx].arc(xc, yc, rad, angle_beg, angle_end, CCW);
    },
    atscntrb_html5_canvas2d_rect:
    function (idx, xul, yul, width, height) {
        MyCanvas.contexts[idx].rect(xul, yul, width, height);
    },
//
    atscntrb_html5_canvas2d_clearRect:
    function (idx, xul, yul, width, height) {
        MyCanvas.contexts[idx].clearRect(xul, yul, width, height);
    },
//
    atscntrb_html5_canvas2d_fill:
    function (idx) { MyCanvas.contexts[idx].fill(); },
    atscntrb_html5_canvas2d_stroke:
    function (idx) { MyCanvas.contexts[idx].stroke(); },
//
    atscntrb_html5_canvas2d_fillRect:
    function (idx, xul, yul, width, height) {
        MyCanvas.contexts[idx].fillRect(xul, yul, width, height);
    },
    atscntrb_html5_canvas2d_strokeRect:
    function (idx, xul, yul, width, height) {
        MyCanvas.contexts[idx].strokeRect(xul, yul, width, height);
    },
//
    atscntrb_html5_canvas2d_fillText:
    function (idx, text, x, y) {
        MyCanvas.contexts[idx].fillText(Pointer_stringify(text), x, y);
    },
    atscntrb_html5_canvas2d_fillText2:
    function (idx, text, x, y, maxWidth) {
        MyCanvas.contexts[idx].fillText2(Pointer_stringify(text), x, y, maxWidth);
    },
//
    atscntrb_html5_canvas2d_save:
    function (idx) { MyCanvas.contexts[idx].save(); },
    atscntrb_html5_canvas2d_restore:
    function (idx) { MyCanvas.contexts[idx].restore(); },
//
    atscntrb_html5_canvas2d_set_lineWidth_int:
    function (idx, width) {
        MyCanvas.contexts[idx].lineWidth = width ;
    },
    atscntrb_html5_canvas2d_set_lineWidth_double:
    function (idx, width) {
        MyCanvas.contexts[idx].lineWidth = width ;
    },
//
    atscntrb_html5_canvas2d_set_font_string:
    function (idx, font) {
        MyCanvas.contexts[idx].font = Pointer_stringify(font);
    },
    atscntrb_html5_canvas2d_set_textAlign_string:
    function (idx, value) {
        MyCanvas.contexts[idx].textAlign = Pointer_stringify(value);
    },
    atscntrb_html5_canvas2d_set_textBaseline_string:
    function (idx, value) {
        MyCanvas.contexts[idx].textBaseline = Pointer_stringify(value);
    },
//
    atscntrb_html5_canvas2d_set_fillStyle_string:
    function (idx, style) {
        MyCanvas.contexts[idx].fillStyle = Pointer_stringify(style);
    },
    atscntrb_html5_canvas2d_set_strokeStyle_string:
    function (idx, style) {
        MyCanvas.contexts[idx].strokeStyle = Pointer_stringify(style);
    },
//
    atscntrb_html5_canvas2d_set_shadowColor:
    function (idx, color) {
	MyCanvas.contexts[idx].shadowColor = Pointer_stringify(color);
    },
//
    atscntrb_html5_canvas2d_set_shadowBlur_int:
    function (idx, value) { MyCanvas.contexts[idx].shadowBlur = value; },
    atscntrb_html5_canvas2d_set_shadowBlur_double:
    function (idx, value) { MyCanvas.contexts[idx].shadowBlur = value; },
//
    atscntrb_html5_canvas2d_set_shadowOffsetX_int:
    function (idx, value) { MyCanvas.contexts[idx].shadowOffsetX = value; },
    atscntrb_html5_canvas2d_set_shadowOffsetX_double:
    function (idx, value) { MyCanvas.contexts[idx].shadowOffsetX = value; },
    atscntrb_html5_canvas2d_set_shadowOffsetY_int:
    function (idx, value) { MyCanvas.contexts[idx].shadowOffsetY = value; },
    atscntrb_html5_canvas2d_set_shadowOffsetY_double:
    function (idx, value) { MyCanvas.contexts[idx].shadowOffsetY = value; },
//
    atscntrb_html5_canvas2d_createLinearGradient:
    function (idx, x0, y0, x1, y1) {
	var grad =
	    MyCanvas.contexts[idx].createLinearGradient(x0, y0, x1, y1);
	return MyCanvas.objadd(grad);
    },
    atscntrb_html5_canvas2d_gradient_free:
    function (idx) { delete MyCanvas.contexts[idx] ; },
    atscntrb_html5_canvas2d_gradient_addColorStop:
    function (idx, stop, color) {
	MyCanvas.contexts[idx].addColorStop(stop, Pointer_stringify(color));
    },
//
    atscntrb_html5_canvas2d_set_fillStyle_gradient:
    function (idx, idx2) {
        MyCanvas.contexts[idx].fillStyle = MyCanvas.contexts[idx2] ;
    },
    atscntrb_html5_canvas2d_set_strokeStyle_gradient:
    function (idx, idx2) {
        MyCanvas.contexts[idx].strokeStyle = MyCanvas.contexts[idx2] ;
    },
//
} ; // end of [atscntrb_html5_canvas2d]

/* ****** ****** */

autoAddDeps(atscntrb_html5_canvas2d, '$MyCanvas');

/* ****** ****** */

mergeInto(LibraryManager.library, atscntrb_html5_canvas2d);

/* ****** ****** */

/* end of [HTML5canvas2d.js] */

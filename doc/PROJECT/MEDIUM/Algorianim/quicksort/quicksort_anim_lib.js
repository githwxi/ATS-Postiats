/**
   A wrapper around the Browser Request Animation frame interface
   Author: Will Blair
   Authoremail: wdblairATbuDOTedu
   Date: October 2013
 */
QuicksortAnimLib =
{
    JS_Math_random:
    function () { return Math.random(); },

    JS_canvas2d_set_size_int:
    function (id, width, height) {
        var id2 = Pointer_stringify(id)
        var elt = document.getElementById(id2);
        if(elt)
	{
	    elt.width = width; elt.height = height;
	}
	return ;
    },

    JS_window_requestAnimationFrame:
    function (ptr)
    {
        var func =
	    Runtime.getFuncWrapper(ptr, 'vi');
        var _requestAnimationFrame =
	    window.requestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.msRequestAnimationFrame;
        _requestAnimationFrame(func);
    },
} ; /* end of [QuicksortAnimLib] */

/* ****** ****** */

mergeInto(LibraryManager.library, QuicksortAnimLib);

/* ****** ****** */
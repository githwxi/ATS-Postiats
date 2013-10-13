/**
   A wrapper around the Browser Request Animation frame interface
   Author: Will Blair
   
   Date: October 2013
 */
Animation = {
    window_requestAnimationFrame:
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
};

mergeInto(LibraryManager.library, Animation);

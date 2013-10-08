/**
   A wrapper around the Browser Request Animation frame interface
   Author: Will Blair
   
   Date: October 2013
 */
Animation = {
    window_request_animation_frame: function (ptr) {
        var func = Runtime.getFuncWrapper(ptr, 'vi');
        
        var requestAnimationFrame = window.requestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.msRequestAnimationFrame;

        window.requestAnimationFrame(func);
    },
    document_documentElement_clientWidth: function () {
        return document.documentElement.clientWidth;
    },
    document_documentElement_clientHeight: function () {
        return document.documentElement.clientHeight;
    }
};

mergeInto(LibraryManager.library, Animation);

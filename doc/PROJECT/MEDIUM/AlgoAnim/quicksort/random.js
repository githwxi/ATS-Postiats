/**
   A wrapper around the Math object's random number capabilities.
   Author: Will Blair
   
   Date: October 2013
 */
Random = {
    JS_Math_random: function () { return Math.random(); },
};

mergeInto(LibraryManager.library, Random);

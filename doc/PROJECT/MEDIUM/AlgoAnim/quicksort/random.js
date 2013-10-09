/**
   A wrapper around the Math object's random number capabilities.
   Author: Will Blair
   
   Date: October 2013
 */
Random = {
    Math_random: function () {
        return Math.random();
    },
    Math_floor: function(n) {
        return Math.floor(n);
    }
};

mergeInto(LibraryManager.library, Random);

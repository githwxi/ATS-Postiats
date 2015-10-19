/* 
  This standard idiom in JS prevents the global namespace from being
  polluted with local variables.

*/
(
function()
{
//
var
theMores = $("#more").asEventStream("click")
//
var _ = theMores.onValue(function(x) { return _ATSJS_fmore(); })
//
}
)(/*void*/);

/* ****** ****** */

/* end of [showfile_post.js] */

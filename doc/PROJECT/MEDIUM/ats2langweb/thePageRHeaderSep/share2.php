<style>
#thePageRHeaderSep
{
  color: #FFFFF0;
}

#thePageRHeaderSepL
{
  text-align: left;
  padding-left: 2px;
}

#thePageRHeaderSepL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePageRHeaderSepL ul li
{
  float: left;
/*
  display: inline;
*/
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  padding-left: 8px;
  padding-right: 8px;
}

#thePageRHeaderSepL li.self
{
  font-weight: bold;
}
#thePageRHeaderSepL li.other
{
  font-weight: normal;
}

#thePageRHeaderSepL a:link
{
  color: #FFFFFF;
}
#thePageRHeaderSepL a:visited
{
  color: #80C0C0;
}
#thePageRHeaderSepL a:hover
{
  color: #C0E0E0;
}
#thePageRHeaderSepL a:active
{
  color: #C0C0C0;
}

.thePageRHeaderSepL_submenu
{
  display: none;
  position: absolute;
  padding: 6px;
  border-radius: 12px;
  background-color: rgba(160,20,50,0.875);
}

#thePageRHeaderSepR
{
  float: right;
}
#thePageRHeaderSepR_input
{
  height: 100%;
  font-size: 12pt;
  border-radius: 6px;
  background: #FFFFF0 url(//www.google.com/coop/intl/en/images/google_custom_search_watermark.gif) left no-repeat;
}
</style>

<script>
//
var
theTopmenuTable = 0;
var
theTopmenuTimeout = 0;
//
function
theTopmenuTable_hide()
{
  if(theTopmenuTable)
  {
    theTopmenuTable.css({display:'none'});
  }
}
function
theTopmenuTimeout_clear()
{
  if(theTopmenuTimeout)
  {
    clearTimeout(theTopmenuTimeout); theTopmenuTimeout = 0;
  }
}
//
function
topmenu_mouseout()
{
  topmenu_mouseout2(500); return;
}
function
topmenu_mouseout2(msec)
{
//
  if(theTopmenuTimeout) clearTimeout(theTopmenuTimeout); 
  theTopmenuTimeout =
  setTimeout (function(){theTopmenuTimeout=0;theTopmenuTable_hide();}, msec);
//
}
//
function
topmenu_mouseover(x0)
{
  var jqi = jQuery(x0);
  theTopmenuTable_hide();
  theTopmenuTimeout_clear();
  theTopmenuTable = jqi.next('table');
  theTopmenuTable.css({display:'table'});
  theTopmenuTable.css (
    {top:jqi.position().top+jqi.outerHeight(true)+10}
  ) ; // end of [theTopmenuTable.css]
  theTopmenuTable.css({left:jqi.position().left});
  return;
}
//
function
submenu_table_mouseout() { topmenu_mouseout(); }
function
submenu_table_mouseover() { theTopmenuTimeout_clear(); }
//
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>

<td width="75%">
<div
 id="thePageRHeaderSepL"
>
<?php thePageRHeaderSep_menu() ; ?>
</div>
</td>

<td width="25%">
<div
 id="thePageRHeaderSepR"
 style="margin-top:6px;margin-bottom:6px;"
>
<form
 id="search-form"
 action="https://www.google.com/cse"
>
<table>
<tr>
<td>
<input
 id="thePageRHeaderSepR_input"
 type="text" name="q" size="22"
 onblur="if (/^\s*$/.test(this.value)) this.style.background='#FFFFF0 url(//www.google.com/coop/intl/en/images/google_custom_search_watermark.gif) left no-repeat'"
 onfocus="this.style.background='#FFFFF0'"
/>
</td>
<td>
<input type="hidden" name="ie" value="UTF-8" />
<input type="hidden" name="cx" value="007881927213964201908:gqahxj364ly" />
<!--
<input class="button" type="submit" name="sa" value="Search" />
-->
</td>
</tr>
</table>
</form>
</div>
</td>

</tr>
</table>

<?php /* end of [share2.php] */ ?>
